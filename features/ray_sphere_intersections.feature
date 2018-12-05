Feature: Ray/Sphere Intersections

    Background: We have a sphere, and the direction of a ray

        Given s := Sphere[]
          And v := Vector[0, 0, 1]

    Scenario: A ray intersects a sphere at two points

        Given p := Point[0, 0, -5]
         When r := Ray[p, v]
          And xs := s.intersect r
         Then xs.count = 2
          And xs[0].t = 4.0
          And xs[1].t = 6.0

    Scenario: A ray intersects a sphere at a tangent

        Given p := Point[0, 1, -5]
         When r := Ray[p, v]
          And xs := s.intersect r
         Then xs.count = 2
          And xs[0].t = 5.0
          And xs[1].t = 5.0

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
          And xs[0].t = -1.0
          And xs[1].t = 1.0

    Scenario: A sphere is behind a ray

        Given p := Point[0, 0, 5]
         When r := Ray[p, v]
          And xs := s.intersect r
         Then xs.count = 2
          And xs[0].t = -6.0
          And xs[1].t = -4.0

    Scenario: An intersection encapsulates t and object

        Given t := 3.5
         When i := Intersection[t, s]
         Then i.t = t
          And i.object = s

    Scenario: Aggregating interections

        Given t1 := 1
          And t2 := 2
         When i1 := Intersection[t1, s]
          And i2 := Intersection[t2, s]
          And xs := Intersections[i1, i2]
         Then xs.count = 2
          And xs[0].t = t1
          And xs[1].t = t2

    Scenario: Intersect sets the object on the intersection

        Given p := Point[0, 0, -5]
         When r := Ray[p, v]
          And xs := s.intersect r
         Then xs.count = 2
          And xs[0].object = s
          And xs[1].object = s
@wip
    Scenario: The hit, when all intersections have positive t

        Given i1 := Intersection[1, s]
          And i2 := Intersection[2, s]
          And xs := Intersections[i2, i1]
         When i := xs.hit
         Then i = i1
@wip
    Scenario: The hit, when some intersections have negative t

        Given i1 := Intersection[-1, s]
          And i2 := Intersection[1, s]
          And xs := Intersections[i2, i1]
         When i := xs.hit
         Then i = i2
@wip
    Scenario: The hit, when all intersections have negative t

        Given i1 := Intersection[-2, s]
          And i2 := Intersection[-1, s]
          And xs := Intersections[i2, i1]
         When i := xs.hit
         Then i is nothing
@wip
    Scenario: The hit is always the lowest non-negative intersection

        Given i1 := Intersection[5, s]
          And i2 := Intersection[7, s]
          And i3 := Intersection[-3, s]
          And i4 := Intersection[2, s]
          And xs := Intersections[i1, i2, i3, i4]
         When i := xs.hit
         Then i = i4
