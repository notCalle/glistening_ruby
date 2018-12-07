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
          And comps.point = Point[0, 0, -1]
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
@wip
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
@wip
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
