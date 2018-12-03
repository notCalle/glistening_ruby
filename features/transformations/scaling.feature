Feature: Scaling matrices

    Background: We have a scaling matrix

        Given T := Scaling[2, 3, 4]

    Scenario: A scaling matrix applied to a point

        Given p := Point[-4, 6, 8]
         Then T * p = Point[-8, 18, 32]

    Scenario: A scaling matrix applied to a vector

        Given v := Vector[-4, 6, 8]
         Then T * v = Vector[-8, 18, 32]

    Scenario: Multiplying by the inverse of a scaling matrix

        Given v := Vector[-4, 6, 8]
         When S := T.inverse
         Then S * v = Vector[-2, 2, 2]

    Scenario: Reflection is scaling by a negative value

        Given R := Scaling[-1, 1, 1]
          And p := Point[2, 3, 4]
         Then R * p = Point[-2, 3, 4]
