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

    Scenario: The default minimum and maximum for a cylinder

        Given cyl := Cylinder[]
          Then cyl.minimum = -1.0/0
           And cyl.maximum = 1.0/0

    Scenario Outline: Intersecting a constrained cylinder

        Given cyl := Cylinder[]
          And cyl.minimum= 1
          And cyl.maximum= 2
          And p := Point[<point>]
          And v := Vector[<direction>]
          And v := v.normalize
          And r := Ray[p, v]
         When xs := cyl.intersect r
         Then xs.count = <count>

    Examples:
        |   | point         | direction | count |
        | 1 | 0, 1.5, 0     | 0.1, 1, 0 | 0     |
        | 2 | 0, 3, -5      | 0, 0, 1   | 0     |
        | 3 | 0, 0, -5      | 0, 0, 1   | 0     |
        | 4 | 0, 2, -5      | 0, 0, 1   | 0     |
        | 5 | 0, 1, -5      | 0, 0, 1   | 0     |
        | 6 | 0, 1.5, -2    | 0, 0, 1   | 2     |

    Scenario: The default closedness of a cylinder

        Given cyl := Cylinder[]
         Then cyl is not closed

    Scenario Outline: Intersecting the caps of a closed cylinder

        Given cyl := Cylinder[]
          And cyl.minimum= 1
          And cyl.maximum= 2
          And capped := true
          And cyl.closed= capped
          And p := Point[<point>]
          And v := Vector[<direction>]
          And v := v.normalize
          And r := Ray[p, v]
         When xs := cyl.intersect r
         Then xs.count = <count>

    Examples:
        |   | point     | direction | count |
        | 1 | 0, 3, 0   | 0, -1, 0  | 2     |
        | 2 | 0, 3, -2  | 0, -1, 2  | 2     |
        | 3 | 0, 4, -2  | 0, -1, 1  | 2     |
        | 4 | 0, 0, -2  | 0, 1, 2   | 2     |
        | 5 | 0, -1, -2 | 0, 1, 1   | 2     |
@wip
    Scenario Outline: The normal vector on a cylinder's end caps

        Given cyl := Cylinder[]
          And cyl.minimum= 1
          And cyl.maximum= 2
          And capped := true
          And cyl.closed= capped
          And p := Point[<point>]
         When n := cyl.normal_at p
         Then n = Vector[<normal>]

    Examples:
        | point     | normal    |
        | 0, 1, 0   | 0, -1, 0  |
        | 0.5, 1, 0 | 0, -1, 0  |
        | 0, 1, 0.5 | 0, -1, 0  |
        | 0, 2, 0   | 0, 1, 0   |
        | 0.5, 2, 0 | 0, 1, 0   |
        | 0, 2, 0.5 | 0, 1, 0   |
