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
@wip
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
