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
         Then comps.point = Point[0, 0, 1.00001]
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
         Then c = Color[0.1, 0.1, 0.1]

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
