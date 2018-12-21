Feature: Ray / object intersections

    Scenario: Precomputing the state of an intersection

        Given p := Point[0, 0, -5]
          And v := Vector[0, 0, 1]
          And r := Ray[p, v]
          And shape := Sphere[]
          And i := Intersection[4, shape]
         When comps := i.prepare r
         Then comps.t = i.t
          And comps.object = i.object
          And comps.point = Point[0, 0, -1.00001]
          And comps.eyev = Vector[0, 0, -1]
          And comps.normalv = Vector[0, 0, -1]

    Scenario: The hit, when an intersection occurs on the outside

        Given p := Point[0, 0, -5]
          And v := Vector[0, 0, 1]
          And r := Ray[p, v]
          And shape := Sphere[]
          And i := Intersection[4, shape]
         When comps := i.prepare r
         Then comps is not inside

    Scenario: The hit, when an intersection occurs on the inside

        Given p := Point[0, 0, 0]
          And v := Vector[0, 0, 1]
          And r := Ray[p, v]
          And shape := Sphere[]
          And i := Intersection[1, shape]
         When comps := i.prepare r
         Then comps.point = Point[0, 0, 1]
          And comps.eyev = Vector[0, 0, -1]
          And comps is inside
              # Normal is inverted on the inside!
          And comps.normalv = Vector[0, 0, -1]

    Scenario: Shading an intersection

        Given w is the default world
          And p := Point[0, 0, -5]
          And v := Vector[0, 0, 1]
          And r := Ray[p, v]
          And shape := w.objects[0]
          And i := Intersection[4, shape]
         When comps := i.prepare r
          And c := w.shade_hit comps
         Then c = Color[0.38066, 0.47583, 0.2855]

    Scenario: Shading an intersection from the inside

        Given w is the default world
          And p := Point[0, 0.25, 0]
          And l := PointLight[p]
          And w.light= l
          And p := Point[0, 0, 0]
          And v := Vector[0, 0, 1]
          And r := Ray[p, v]
          And shape := w.objects[1]
          And i := Intersection[0.5, shape]
         When comps := i.prepare r
          And c := w.shade_hit comps
         Then c = Color[0.90498, 0.90498, 0.90498]

    Scenario: The color when a ray misses

        Given w is the default world
          And p := Point[0, 0, -5]
          And v := Vector[0, 1, 0]
          And r := Ray[p, v]
         When c := w.color_at r
         Then c = Color[0, 0, 0]

    Scenario: The color when a ray hits

        Given w is the default world
          And p := Point[0, 0, -5]
          And v := Vector[0, 0, 1]
          And r := Ray[p, v]
         When c := w.color_at r
         Then c = Color[0.38066, 0.47583, 0.2855]

    Scenario: The color with an intersection behind the ray

        Given w is the default world
          And outer := w.objects[0]
          And outer_material := outer.material
          And outer_material.ambient= 1
          And inner := w.objects[1]
          And inner_material := inner.material
          And inner_material.ambient= 1
          And p := Point[0, 0, 0.75]
          And v := Vector[0, 0, -1]
          And r := Ray[p, v]
         When c := w.color_at r
         Then c = inner_material.color

    Scenario: The hit should offset the point

        Given p := Point[0, 0, -5]
          And v := Vector[0, 0, 1]
          And r := Ray[p, v]
          And shape := Sphere[]
          And T := Translation[0, 0, 1]
          And shape.transform= T
          And i := Intersection[5, shape]
         When comps := i.prepare r
          And point := comps.point
         Then point.z is less than -EPSILON÷2

    Scenario: Precomputing the reflection vector

        Given shape := Plane[]
          And p := Point[0, 1, -1]
          And v := Vector[0, -√2/2, √2/2]
          And r := Ray[p, v]
          And i := Intersection[√2, shape]
         When comps := i.prepare r
         Then comps.reflectv = Vector[0, √2/2, √2/2]

    Scenario Outline: Finding n1 and n2 at various intersections

        Given a := GlassSphere[]
          And a.transform= Scaling[2, 2, 2]
          And a.material.refractive_index= 1.5
          And b := GlassSphere[]
          And b.transform= Translation[0, 0, -0.25]
          And b.material.refractive_index= 2.0
          And c := GlassSphere[]
          And c.transform= Translation[0, 0, 0.25]
          And c.material.refractive_index= 2.5
          And p := Point[0, 0, -4]
          And v := Vector[0, 0, 1]
          And r := Ray[p, v]
          And i0 := Intersection[2, a]
          And i1 := Intersection[2.75, b]
          And i2 := Intersection[3.25, c]
          And i3 := Intersection[4.75, b]
          And i4 := Intersection[5.25, c]
          And i5 := Intersection[6, a]
          And xs := Intersections[i0, i1, i2, i3, i4, i5]
         When comps := i<index>.prepare r, xs
         Then comps.n1 = <n1>
          And comps.n2 = <n2>

    Examples:
        | index | n1    | n2    |
        | 0     | 1.0   | 1.5   |
        | 1     | 1.5   | 2.0   |
        | 2     | 2.0   | 2.5   |
        | 3     | 2.5   | 2.5   |
        | 4     | 2.5   | 1.5   |
        | 5     | 1.5   | 1.0   |

    Scenario: The under point is offset below the surface

        Given p := Point[0, 0, -5]
          And v := Vector[0, 0, 1]
          And r := Ray[p, v]
          And shape := GlassSphere[]
          And shape.transform= Translation[0, 0, 1]
          And i := Intersection[5, shape]
          And xs := Intersections[i]
         When comps := i.prepare r, xs
          And up := comps.under_point
         Then up.z is greater than EPSILON÷2

    Scenario: The Schlick approximation under total internal reflection

        Given shape := GlassSphere[]
          And p := Point[0, 0, √2/2]
          And v := Vector[0, 1, 0]
          And r := Ray[p, v]
          And i0 := Intersection[-√2/2, shape]
          And i1 := Intersection[√2/2, shape]
          And xs := Intersections[i0, i1]
         When comps := i1.prepare r, xs
          And reflectance := comps.schlick
         Then reflectance = 1.0
