@wip
Feature: Reflection

    Scenario: Reflecting a vector approaching at 45°

        Given v := Vector[1, -1, 0]
          And n := Vector[0, 1, 0]
         When r := v.reflect n
         Then r = Vector[1, 1, 0]

    Scenario: Reflecting a vector off a slanted surface

        Given v := Vector[0, -1, 0]
          And n := Vector[√2/2, √2/2, 0]
         When r := v.reflect n
         Then r = Vector[1, 0, 0]
