Feature: Scalar multiplication and division or tuples, points, and vectors

    Scenario: Multiplying a tuple by a scalar

        Given a := Tuple[1.0, -2.0, 3.0, -4.0]
          And s := 3.5
         Then a * s = Tuple[3.5, -7.0, 10.5, -14.0]

    Scenario: Multiplying a tuple by a fraction

        Given a := Tuple[1.0, -2.0, 3.0, -4.0]
          And s := 0.5
         Then a * s = Tuple[0.5, -1.0, 1.5, -2.0]

    Scenario: Dividing a tuple by a scalar

        Given a := Tuple[1.0, -2.0, 3.0, -4.0]
          And s := 2.0
         Then a / s = Tuple[0.5, -1.0, 1.5, -2.0]
