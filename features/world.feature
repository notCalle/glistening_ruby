Feature: A scene world

    Scenario: Creating a world

        Given w := World[]
         Then w contains no objects
          And w has no light source

    # @wip
    # Scenario: The default world
    #
    #     Given point := Point[-10, 10, -10]
    #       And light := PointLight[point]
    #       And s1 := Sphere[] with:
    #           | material.color      | [0.8, 1.0, 0.6]   |
    #           | material.diffuse    | 0.7               |
    #           | material.specular   | 0.2               |
    #       And s2 := Sphere[] with:
    #           | transform           | Scaling[0.5, 0.5, 0.5] |
    #      When w is the default world
    #      Then w.light = light
    #       And w contains s1
    #       And w contains s2

    Scenario: Intersect a world with a ray

        Given w is the default world
          And p := Point[0, 0, -5]
          And v := Vector[0, 0, 1]
         When r := Ray[p, v]
          And xs := w.intersect r
         Then xs.count = 4
          And xs[0].t = 4
          And xs[1].t = 4.5
          And xs[2].t = 5.5
          And xs[3].t = 6

    Scenario: There is no shadow when nothing is colinear with point and light

        Given w is the default world
          And p := Point[0, 10, 0]
         Then p is not shadowed in w

    Scenario: The shadow when an object is between the point and the light

        Given w is the default world
          And p := Point[10, -10, 10]
         Then p is shadowed in w

    Scenario: There is no shadow when an object is behind the light

        Given w is the default world
          And p := Point[-20, 20, -20]
         Then p is not shadowed in w

    Scenario: There is no shadow when an object is behind the point

        Given w is the default world
          And p := Point[-2, 2, -2]
         Then p is not shadowed in w

    Scenario: shade_hit() is given an intersection in shadow

        Given w := World[]
          And p := Point[0, 0, -10]
          And light := PointLight[p]
          And w.light= light
          And s1 := Sphere[]
          And s1 is added to w
          And s2 := Sphere[]
          And T := Translation[0, 0, 10]
          And s2.transform= T
          And s2 is added to w
          And pr := Point[0, 0, 5]
          And vr := Vector[0, 0, 1]
          And r := Ray[pr, vr]
          And i := Intersection[4, s2]
         When comps := i.prepare r
          And c := w.shade_hit comps
         Then c = Color[0.1, 0.1, 0.1]

    Scenario: The reflected color for a non-reflective material

        Given w is the default world
          And p := Point[0, 0, 0]
          And v := Vector[0, 0, 1]
          And r := Ray[p, v]
          And shape := w.objects[1]
          And m := shape.material
          And m.ambient= 1
          And i := Intersection[1, shape]
         When comps := i.prepare r
          And color := w.reflected_color comps
         Then color = Color[0, 0, 0]

    Scenario: Shading a hit with a reflective material

        Given w is the default world
          And shape := Plane[]
          And shape.transform= Translation[0, -1, 0]
          And m := shape.material
          And m.reflective= 0.5
          And shape is added to w
          And p := Point[0, 0, -3]
          And v := Vector[0, -√2/2, √2/2]
          And r := Ray[p, v]
          And i := Intersection[√2, shape]
         When comps := i.prepare r
          And color := w.shade_hit comps
         Then color = Color[0.87676, 0.92434, 0.82917]

    Scenario: Finding color at point with mutually reflective surfaces

        Given w := World[]
          And p := Point[0, 0, 0]
          And c := Color[1, 1, 1]
          And w.light= PointLight[p, c]
          And lower := Plane[]
          And m := lower.material
          And m.reflective= 1
          And lower.transform= Translation[0, -1, 0]
          And lower is added to w
          And upper := Plane[]
          And m := upper.material
          And m.reflective= 1
          And upper.transform= Translation[0, 1, 0]
          And upper is added to w
          And v := Vector[0, 1, 0]
          And r := Ray[p, v]
         Then w.color_at r should terminate successfully

    Scenario: The reflected color at the maximum recursive depth

        Given w is the default world
          And shape := Plane[]
          And shape.transform= Translation[0, -1, 0]
          And m := shape.material
          And m.reflective= 0.5
          And shape is added to w
          And p := Point[0, 0, -3]
          And v := Vector[0, -√2/2, √2/2]
          And r := Ray[p, v]
          And i := Intersection[√2, shape]
         When comps := i.prepare r
          And limit := 0
          And color := w.reflected_color comps, limit
         Then color = Color[0, 0, 0]

    Scenario: The refracted color with an opaque surface

        Given w is the default world
          And shape := w.objects[0]
          And p := Point[0, 0, -5]
          And v := Vector[0, 0, 1]
          And r := Ray[p, v]
          And i0 := Intersection[4, shape]
          And i1 := Intersection[6, shape]
          And xs := Intersections[i0, i1]
         When comps := i0.prepare r, xs
          And c := w.refracted_color comps
         Then c = Color[0, 0, 0]

    Scenario: The refracted color at the maximum recursive depth

        Given w is the default world
          And shape := w.objects[0]
          And m := shape.material
          And m.transparency= 1.0
          And m.refractive_index= 1.5
          And p := Point[0, 0, -5]
          And v := Vector[0, 0, 1]
          And r := Ray[p, v]
          And i0 := Intersection[4, shape]
          And i1 := Intersection[6, shape]
          And xs := Intersections[i0, i1]
         When comps := i0.prepare r, xs
          And limit := 0
          And c := w.refracted_color comps, limit
         Then c = Color[0, 0, 0]

    Scenario: The refracted color under total internal reflection

        Given w is the default world
          And shape := w.objects[0]
          And m := shape.material
          And m.transparency= 1.0
          And m.refractive_index= 1.5
          And p := Point[0, 0, √2/2]
          And v := Vector[0, 1, 0]
          And r := Ray[p, v]
          And i0 := Intersection[-√2/2, shape]
          And i1 := Intersection[√2/2, shape]
          And xs := Intersections[i0, i1]
         When comps := i1.prepare r, xs
          And c := w.refracted_color comps
         Then c = Color[0, 0, 0]

    Scenario: The refracted color with a refracted ray

        Given w is the default world
          And a := w.objects[0]
          And ma := a.material
          And ma.ambient= 1.0
          And pt := TestPattern[]
          And ma.pattern= pt
          And b := w.objects[1]
          And mb := b.material
          And mb.transparency= 1.0
          And mb.refractive_index= 1.5
          And p := Point[0, 0, 0.1]
          And v := Vector[0, 1, 0]
          And r := Ray[p, v]
          And i0 := Intersection[-0.9899, a]
          And i1 := Intersection[-0.4899, b]
          And i2 := Intersection[0.4899, b]
          And i3 := Intersection[0.9899, a]
          And xs := Intersections[i0, i1, i2, i3]
         When comps := i2.prepare r, xs
          And c := w.refracted_color comps
         Then c = Color[0, 0.99887, 0.04722]

    Scenario: Shading a hit with a transparent material

        Given w is the default world
          And floor := Plane[]
          And floor.transform= Translation[0, -1, 0]
          And floor_material := floor.material
          And floor_material.transparency= 0.5
          And floor_material.refractive_index= 1.5
          And floor is added to w
          And ball := Sphere[]
          And ball_material := ball.material
          And ball_material.color= Color[1, 0, 0]
          And ball_material.ambient= 0.5
          And ball.transform= Translation[0, -3.5, -0.5]
          And ball is added to w
          And p := Point[0, 0, -3]
          And v := Vector[0, -√2/2, √2/2]
          And r := Ray[p, v]
          And i0 := Intersection[√2, floor]
          And xs := Intersections[i0]
         When comps := i0.prepare r, xs
          And color := w.shade_hit comps
         Then color = Color[0.93642, 0.68642, 0.68642]

    Scenario: Shading a hit with a reflective transparent material

        Given w is the default world
          And floor := Plane[]
          And floor.transform= Translation[0, -1, 0]
          And floor_material := floor.material
          And floor_material.reflective= 0.5
          And floor_material.transparency= 0.5
          And floor_material.refractive_index= 1.5
          And floor is added to w
          And ball := Sphere[]
          And ball_material := ball.material
          And ball_material.color= Color[1, 0, 0]
          And ball_material.ambient= 0.5
          And ball.transform= Translation[0, -3.5, -0.5]
          And ball is added to w
          And p := Point[0, 0, -3]
          And v := Vector[0, -√2/2, √2/2]
          And r := Ray[p, v]
          And i0 := Intersection[√2, floor]
          And xs := Intersections[i0]
         When comps := i0.prepare r, xs
          And color := w.shade_hit comps
         Then color = Color[0.93391, 0.69643, 0.69243]
@wip
    Scenario: Shading a hit behind a non-shadow casting object

        Given w := World[]
          And ceiling := Plane[]
          And ceiling.transform= Translation[0, 2, 0]
          And shadowing := false
          And ceiling.cast_shadows= shadowing
          And ceiling is added to w
          And floor := Plane[]
          And floor is added to w
          And p_light := Point[0, 5, 0]
          And light := PointLight[p_light]
          And w.light= light
          And p := Point[0, 1, 0]
          And v := Vector[0, -1, 0]
          And r := Ray[p, v]
          And i0 := Intersection[1, floor]
          And xs := Intersections[i0]
         When comps := i0.prepare r, xs
          And color := w.shade_hit comps
         Then color = Color[1.9, 1.9, 1.9]
