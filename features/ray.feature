Feature: Rays to be cast into the world

    Scenario: Creating and querying a ray

        Given origin := Point[1, 2, 3]
          And direction := Vector[4, 5, 6]
         When r := Ray[origin, direction]
         Then r.origin = origin
          And r.direction = direction

    Scenario: Computing a point from a distance

        Given p := Point[2, 3, 4]
          And v := Vector[1, 0, 0]
         When r := Ray[p, v]
         Then r.position 0 = Point[2, 3, 4]
          And r.position 1 = Point[3, 3, 4]
          And r.position -1 = Point[1, 3, 4]
          And r.position 2.5 = Point[4.5, 3, 4]

    Scenario: Translating a ray

        Given p := Point[1, 2, 3]
          And v := Vector[0, 1, 0]
          And M := Translation[3, 4, 5]
         When r := Ray[p, v]
          And r2 := r.transform M
         Then r2.origin = Point[4, 6, 8]
          And r2.direction = Vector[0, 1, 0]

    Scenario: Scaling a ray

        Given p := Point[1, 2, 3]
          And v := Vector[0, 1, 0]
          And M := Scaling[2, 3, 4]
         When r := Ray[p, v]
          And r2 := r.transform M
         Then r2.origin = Point[2, 6, 12]
          And r2.direction = Vector[0, 3, 0]
