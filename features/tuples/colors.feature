Feature: Represent colors with tuples

    Scenario: Colors are (r, g, b) tuples

        Given c := Color[-0.5, 0.4, 1.7]
         Then c.r = -0.5
          And c.g = 0.4
          And c.b = 1.7
