Feature: Triangles

    Background: We have a triangle

        Given p1 := Point[0, 1, 0]
          And p2 := Point[-1, 0, 0]
          And p3 := Point[1, 0, 0]
          And t := Triangle[p1, p2, p3]

    Scenario: Constructing a triangle

         Then t.v1 = p1
          And t.v2 = p2
          And t.v3 = p3
          And t.e1 = Vector[-1, -1, 0]
          And t.e2 = Vector[1, -1, 0]
          And t.normal = Vector[0, 0, -1]

    Scenario Outline: Finding the normal on a triangle

         When np := Point[<point>]
          And n := t.normal_at np
         Then t.normal = n

    Examples:
        | point         |
        | 0, 0.5, 0     |
        | -0.5, 0.75, 0 |
        | 0.5, 0.25, 0  |

    Scenario: Intersecting a ray parallel to a triangle

        Given p := Point[0, -1, -2]
          And v := Vector[0, 1, 0]
          And r := Ray[p, v]
         When xs := t.intersect r
         Then xs is empty

    Scenario: A ray misses the v1:v3 edge

        Given p := Point[1, 1, -2]
          And v := Vector[0, 0, 1]
          And r := Ray[p, v]
         When xs := t.intersect r
         Then xs is empty

    Scenario: A ray misses the v1:v2 edge

        Given p := Point[-1, 1, -2]
          And v := Vector[0, 0, 1]
          And r := Ray[p, v]
         When xs := t.intersect r
         Then xs is empty

    Scenario: A ray misses the v2:v3 edge

        Given p := Point[0, -1, -2]
          And v := Vector[0, 0, 1]
          And r := Ray[p, v]
         When xs := t.intersect r
         Then xs is empty
@wip
    Scenario: A ray hits a triangles

        Given p := Point[0, 0.5, -2]
          And v := Vector[0, 0, 1]
          And r := Ray[p, v]
         When xs := t.intersect r
         Then xs.count = 1
          And xs[0].t = 2
