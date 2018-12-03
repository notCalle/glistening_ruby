Feature: Chaining transformations

    Background: We have a point, and some transformations

        Given p := Point[1, 0, 1]
          And A := RotationX[1/4]
          And B := Scaling[5, 5, 5]
          And C := Translation[10, 5, 7]

    Scenario: Individual transformations are applied in sequence

         # Apply rotation first
         When q := A * p
         Then q = Point[1, -1, 0]

         # Then apply scaling
         When r := B * q
         Then r := Point[5, -5, 0]

         # Finally, apply translation
         When s := C * r
         Then s = Point[15, 0, 7]

    Scenario: Chained transformations must be applied in reverse order

        When T := C * B * A
        Then T * p = Point[15, 0, 7]
