Feature: Ray/Sphere Intersections

    Background: We have a sphere, and the direction of a ray

        Given s := Sphere[]
          And v := Vector[0, 0, 1]

    Scenario: A ray intersects a sphere at two points

        Given p := Point[0, 0, -5]
         When r := Ray[p, v]
          And xs := s.intersect r
         Then xs.count = 2
          And xs[0] = 4.0
          And xs[1] = 6.0

    Scenario: A ray intersects a sphere at a tangent

        Given p := Point[0, 1, -5]
         When r := Ray[p, v]
          And xs := s.intersect r
         Then xs.count = 2
          And xs[0] = 5.0
          And xs[1] = 5.0

    Scenario: A ray misses a sphere

        Given p := Point[0, 2, -5]
         When r := Ray[p, v]
          And xs := s.intersect r
         Then xs.count = 0

    Scenario: A ray originates inside a sphere

        Given p := Point[0, 0, 0]
         When r := Ray[p, v]
          And xs := s.intersect r
         Then xs.count = 2
          And xs[0] = -1.0
          And xs[1] = 1.0

    Scenario: A sphere is behind a ray

        Given p := Point[0, 0, 5]
         When r := Ray[p, v]
          And xs := s.intersect r
         Then xs.count = 2
          And xs[0] = -6.0
          And xs[1] = -4.0
@wip
    Scenario: An intersection encapsulates t and object

        Given t := 3.5
         When i := Intersection[t, s]
         Then i.t = t
          And i.object = s
@wip
    Scenario: Aggregating interections

        Given t1 := 1
          And t2 := 2
         When i1 := Intersection[t1, s]
          And i2 := Intersection[t2, s]
          And xs := Intersections[i1, i2]
         Then xs.count = 2
          And xs[0].t = t1
          And xs[1].t = t2
