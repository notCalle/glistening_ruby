Feature: Cones

    Scenario Outline: Intersecting a cone with a ray

        Given shape := Cone[]
          And p := Point[<origin>]
          And v := Vector[<direction>]
          And v := v.normalize
          And r := Ray[p, v]
         When xs := shape.intersect r
         Then xs.count = 2
          And xs[0].t = <t0>
          And xs[1].t = <t1>

    Examples:
        | origin    | direction     | t0        | t1        |
        | 0, 0, -5  | 0, 0, 1       | 5         | 5         |
        | 0, 0, -5  | 1, 1, 1       | 8.66025   | 8.66025   |
        | 1, 1, -5  | -0.5, -1, 1   | 4.55006   | 49.44994  |

    Scenario: Intersecting a cone with a ray parallel to one of its halves

        Given shape := Cone[]
          And p := Point[0, 0, -1]
          And v := Vector[0, √2/2, √2/2]
          And r := Ray[p, v]
         When xs := shape.intersect r
         Then xs.count = 1
          And xs[0].t = 0.35355
