Feature: Cubes - Axis Aligned Bounding Boxes

    Scenario Outline: A ray intersects a cube

        Given c := Cube[]
          And p := Point[<origin>]
          And v := Vector[<direction>]
          And r := Ray[p, v]
         When xs := c.intersect r
         Then xs.count = 2
          And xs[0].t = <t0>
          And xs[1].t = <t1>

    Examples:
        |           | origin        | direction | t0    | t1    |
        | +x        | 5, 0.5, 0     | -1, 0, 0  | 4     | 6     |
        | -x        | -5, 0.5, 0    | 1, 0, 0   | 4     | 6     |
        | +y        | 0.5, 5, 0     | 0, -1, 0  | 4     | 6     |
        | -y        | 0.5, -5, 0    | 0, 1, 0   | 4     | 6     |
        | +z        | 0.5, 0, 5     | 0, 0, -1  | 4     | 6     |
        | -z        | 0.5, 0, -5    | 0, 0, 1   | 4     | 6     |
        | inside    | 0, 0.5, 0     | 0, 0, 1   | -1    | 1     |

    Scenario Outline: A ray misses a cube

        Given c := Cube[]
          And p := Point[<origin>]
          And v := Vector[<direction>]
          And r := Ray[p, v]
         When xs := c.intersect r
         Then xs.count = 0

    Examples:
        | origin    | direction                 |
        | -2, 0, 0  | 0.2673, 0.5345, 0.8018    |
        | 0, -2, 0  | 0.8018, 0.2673, 0.5345    |
        | 0, 0, -2  | 0.5345, 0.8018, 0.2673    |
        | 2, 0, 2   | 0, 0, -1                  |
        | 0, 2, 2   | 0, -1, 0                  |
        | 2, 2, 0   | -1, 0, 0                  |

