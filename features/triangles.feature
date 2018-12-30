Feature: Triangles

    Scenario: Constructing a triangle

        Given p1 := Point[0, 1, 0]
          And p2 := Point[-1, 0, 0]
          And p3 := Point[1, 0, 0]
          And t := Triangle[p1, p2, p3]
         Then t.v1 = p1
          And t.v2 = p2
          And t.v3 = p3
          And t.e1 = Vector[-1, -1, 0]
          And t.e2 = Vector[1, -1, 0]
          And t.normal = Vector[0, 0, -1]

    Scenario Outline: Finding the normal on a triangle

        Given p1 := Point[0, 1, 0]
          And p2 := Point[-1, 0, 0]
          And p3 := Point[1, 0, 0]
          And t := Triangle[p1, p2, p3]
         When np := Point[<point>]
          And n := t.normal_at np
         Then t.normal = n

    Examples:
        | point         |
        | 0, 0.5, 0     |
        | -0.5, 0.75, 0 |
        | 0.5, 0.25, 0  |
