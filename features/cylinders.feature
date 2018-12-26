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
