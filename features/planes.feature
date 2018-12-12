Feature: Snakeless planes

    Scenario: The normal of a plane is constant everywhere

        Given s := Plane[]
          And p1 := Point[0, 0, 0]
          And p2 := Point[10, 0, -10]
          And p3 := Point[-5, 0, 150]
         When n1 := s.normal_at p1
          And n2 := s.normal_at p2
          And n3 := s.normal_at p3
         Then n1 = Vector[0, 1, 0]
          And n2 = Vector[0, 1, 0]
          And n3 = Vector[0, 1, 0]

    Scenario: Intersecting with a ray parallel to the plane

        Given s := Plane[]
          And p := Point[0, 10, 0]
          And v := Vector[0, 0, 1]
          And r := Ray[p, v]
         When xs := s.intersect r
         Then xs is empty

    Scenario: Intersecting with a coplanar ray

        Given s := Plane[]
          And p := Point[0, 0, 0]
          And v := Vector[0, 0, 1]
          And r := Ray[p, v]
         When xs := s.intersect r
         Then xs is empty
@wip
    Scenario: A ray intersecting a plane from above

        Given s := Plane[]
          And p := Point[0, 1, 0]
          And v := Vector[0, -1, 0]
          And r := Ray[p, v]
         When xs := s.intersect r
         Then xs.count = 1
          And xs[0].t = 1
          And xs[0].object = s
@wip
    Scenario: A ray intersecting a plane from below

        Given s := Plane[]
          And p := Point[0, -1, 0]
          And v := Vector[0, 1, 0]
          And r := Ray[p, v]
         When xs := s.intersect r
         Then xs.count = 1
          And xs[0].t = 1
          And xs[0].object = s
