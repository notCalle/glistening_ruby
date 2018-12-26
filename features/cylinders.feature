Feature: Cylinders

    Scenario Outline: A ray misses a cylinder

        Given cyl := Cylinder[]
          And p := Point[<origin>]
          And v := Vector[<direction>]
          And v := v.normalize
          And r := Ray[p, v]
         When xs := cyl.intersect r
         Then xs.count = 0

    Examples:
        | origin    | direction |
        | 1, 0, 0   | 0, 1, 0   |
        | 0, 0, 0   | 0, 1, 0   |
        | 0, 0, -5  | 1, 1, 1   |

    Scenario Outline: A ray hits a cylinder

        Given cyl := Cylinder[]
          And p := Point[<origin>]
          And v := Vector[<direction>]
          And v := v.normalize
          And r := Ray[p, v]
         When xs := cyl.intersect r
         Then xs.count = 2
          And xs[0].t = <t0>
          And xs[1].t = <t1>

    Examples:
        | origin        | direction | t0        | t1        |
        | 1, 0, -5      | 0, 0, 1   | 5         | 5         |
        | 0, 0, -5      | 0, 0, 1   | 4         | 6         |
        | 0.5, 0, -5    | 0.1, 1, 1 | 6.80798   | 7.08872   |

    Scenario Outline: Normal vectors on a cylinder

        Given cyl := Cylinder[]
          And p := Point[<point>]
         When n := cyl.normal_at p
         Then n = Vector[<normal>]

    Examples:
        | point     | normal    |
        | 1, 0, 0   | 1, 0, 0   |
        | 0, 5, -1  | 0, 0, -1  |
        | 0, -2, 1  | 0, 0, 1   |
        | -1, 1, 0  | -1, 0, 0  |
@wip
    Scenario: The default minimum and maximum for a cylinder

        Given cyl := Cylinder[]
          Then cyl.minimum = -1.0/0
           And cyl.maximum = 1.0/0