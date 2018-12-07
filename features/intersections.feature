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
