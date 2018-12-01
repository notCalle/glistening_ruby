Feature: Vector dot and cross products

    Scenario: Taking the dot product of two vectors

        Given u := Vector[1, 2, 3]
          And v := Vector[2, 3, 4]
         Then u · v = 20

    Scenario: The cross product of two vectors yield a vector

        Given u := Vector[1, 2, 3]
          And v := Vector[2, 3, 4]
         Then u X v = Vector[-1, 2, -1]
          And v X u = Vector[1, -2, 1]
