Feature: Spheres

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

    Scenario: The hit, when all intersections have positive t

        Given i1 := Intersection[1, s]
          And i2 := Intersection[2, s]
          And xs := Intersections[i2, i1]
         When i := xs.hit
         Then i = i1

    Scenario: The hit, when some intersections have negative t

        Given i1 := Intersection[-1, s]
          And i2 := Intersection[1, s]
          And xs := Intersections[i2, i1]
         When i := xs.hit
         Then i = i2

    Scenario: The hit, when all intersections have negative t

        Given i1 := Intersection[-2, s]
          And i2 := Intersection[-1, s]
          And xs := Intersections[i2, i1]
         When i := xs.hit
         Then i is nothing

    Scenario: The hit is always the lowest non-negative intersection

        Given i1 := Intersection[5, s]
          And i2 := Intersection[7, s]
          And i3 := Intersection[-3, s]
          And i4 := Intersection[2, s]
          And xs := Intersections[i1, i2, i3, i4]
         When i := xs.hit
         Then i = i4

    Scenario: Intersecting a scaled sphere with a ray

        Given p := Point[0, 0, -5]
          And M := Scaling[2, 2, 2]
         When r := Ray[p, v]
          And s.transform= M
          And xs := s.intersect r
         Then xs.count = 2
          And xs[0].t = 3
          And xs[1].t = 7

    Scenario: Intersecting a translated sphere with a ray

        Given p := Point[0, 0, -5]
          And M := Translation[5, 0, 0]
         When r := Ray[p, v]
          And s.transform= M
          And xs := s.intersect r
         Then xs.count = 0

    Scenario: The normal on a sphere at a point on the x axis

        Given p := Point[1, 0, 0]
         When n := s.normal_at p
         Then n = Vector[1, 0, 0]

    Scenario: The normal on a sphere at a point on the y axis

        Given p := Point[0, 1, 0]
         When n := s.normal_at p
         Then n = Vector[0, 1, 0]

    Scenario: The normal on a sphere at a point on the z axis

        Given p := Point[0, 0, 1]
         When n := s.normal_at p
         Then n = Vector[0, 0, 1]

    Scenario: The normal on a shpere at a non-axial point

        Given p := Point[√3/3, √3/3, √3/3]
         When n := s.normal_at p
         Then n = Vector[√3/3, √3/3, √3/3]

    Scenario: The normal is a normalized vector

        Given p := Point[√3/3, √3/3, √3/3]
         When n := s.normal_at p
         Then n = n.normalize

    Scenario: A helper for producing a sphere with a glassy material

        Given s := GlassSphere[]
         When m := s.material
         Then s.transform is the identity matrix
          And m.transparency = 1.0
          And m.refractive_index = 1.5
