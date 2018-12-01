Feature: Represent colors with tuples

    Scenario: Colors are (r, g, b) tuples

        Given c := Color[-0.5, 0.4, 1.7]
         Then c.r = -0.5
          And c.g = 0.4
          And c.b = 1.7

    Scenario: Adding colors

        Given c := Color[0.9, 0.6, 0.75]
          And d := Color[0.7, 0.1, 0.25]
         Then c + d = Color[1.6, 0.7, 1.0]

    Scenario: Subtracting colors

        Given c := Color[0.9, 0.6, 0.75]
          And d := Color[0.7, 0.1, 0.25]
         Then c - d = Color[0.2, 0.5, 0.5]

    Scenario: Multiplying a color by a scalar

        Given c := Color[0.2, 0.3, 0.4]
          And s := 2
         Then c * s = Color[0.4, 0.6, 0.8]

    Scenario: Multiplying a color by a color

        Given c := Color[1, 0.2, 0.4]
          And d := Color[0.9, 1, 0.1]
         Then c * d = Color[0.9, 0.2, 0.04]
