Feature: Basic of tuples, points and vectors

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
