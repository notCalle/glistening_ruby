Feature: Tuples, points and vectors

    Scenario: A tuple with w = 1.0 is a point

        Given a := Tuple[4.3, -4.2, 3.1, 1.0]
        Then a.x = 4.3
         And a.y = -4.2
         And a.z = 3.1
         And a.w = 1.0
         And a is a Point
         But a is not a Vector

    Scenario: A tuple with w = 1.0 is a point

        Given a := Tuple[4.3, -4.2, 3.1, 0.0]
        Then a.x = 4.3
         And a.y = -4.2
         And a.z = 3.1
         And a.w = 0.0
         And a is a Vector
         But a is not a Point

    Scenario: Point[] creates tuples with w = 1.0

        Given p := Point[4.3, -4.2, 3.1]
         Then p = Tuple[4.3, -4.2, 3.1, 1.0]

    Scenario: Vector[] creates tuples with w = 0.0

        Given v := Vector[4.3, -4.2, 3.1]
         Then v = Tuple[4.3, -4.2, 3.1, 0.0]

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
