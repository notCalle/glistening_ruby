Feature: Smooth triangles, with interpolated normals

    Background:

        Given p1 := Point[0, 1, 0]
          And p2 := Point[-1, 0, 0]
          And p3 := Point[1, 0, 0]
          And n1 := Vector[0, 1, 0]
          And n2 := Vector[-1, 0, 0]
          And n3 := Vector[1, 0, 0]
         When tri := SmoothTriangle[p1, p2, p3, n1, n2, n3]

    Scenario: Constructing a smooth triangle

        Then tri.v1 = p1
         And tri.v2 = p2
         And tri.v3 = p3
         And tri.n1 = n1
         And tri.n2 = n2
         And tri.n3 = n3

    Scenario: An intersection with a smooth triangle stores u/v

        When p := Point[-0.2, 0.3, -2]
         And v := Vector[0, 0, 1]
         And r := Ray[p, v]
         And xs := tri.intersect r
        Then xs[0].u = 0.45
         And xs[0].v = 0.25
@wip
    Scenario: A smooth triangle uses u/v to interpolate the normal

        When i := Intersection[1, tri, 0.45, 0.25]
         And p := Point[0, 0, 0]
         And n := tri.normal_at p, i
        Then n = Vector[-0.5547, 0.83205, 0]
