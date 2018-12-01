Feature: Addition and subtraction of tuples, points, and vectors

    Scenario: Adding two tuples

        Given a := Tuple[3.0, -2.0, 5.0, 1.0]
          And b := Tuple[-2.0, 3.0, 1.0, 0.0]
         Then a + b = Tuple[1.0, 1.0, 6.0, 1.0]

    Scenario: Adding a vector to a point yields a point

        Given p := Point[3.0, 2.0, 1.0]
          And v := Vector[5.0, 6.0, 7.0]
         Then p + v = Point[8.0, 8.0, 8.0]

    Scenario: Adding a vector to a vector yields a vector

        Given u := Vector[3.0, 2.0, 1.0]
          And v := Vector[5.0, 6.0, 7.0]
         Then u + v = Vector[8.0, 8.0, 8.0]

    Scenario: Subtracting two points yields a vector

        Given p := Point[3.0, 2.0, 1.0]
          And q := Point[5.0, 6.0, 7.0]
         Then p - q = Vector[-2.0, -4.0, -6.0]

    Scenario: Subtracting a vector from a point yields a point

        Given p := Point[3.0, 2.0, 1.0]
          And v := Vector[5.0, 6.0, 7.0]
         Then p - v = Point[-2.0, -4.0, -6.0]

    Scenario: Subtracting two vectors yields a vector

        Given u := Vector[3.0, 2.0, 1.0]
          And v := Vector[5.0, 6.0, 7.0]
         Then u - v = Vector[-2.0, -4.0, -6.0]

    Scenario: Subtracting a vector from the zero vector

        Given zero := Vector[0.0, 0.0, 0.0]
          And v := Vector[1.0, -2.0, 3.0]
         Then zero - v = Vector[-1.0, 2.0, -3.0]

    Scenario: Negating a tuple

        Given a := Tuple[1.0, -2.0, 3.0, -4.0]
         Then -a = Tuple[-1.0, 2.0, -3.0, 4.0]
