Feature: Rotation matrices

    Scenario: Rotating a point around the X axis

        Given p := Point[0, 1, 0]
          And H := RotationX[1/8]
          And F := RotationX[1/4]
         Then H * p = Point[0, √2/2, √2/2]
          And F * p = Point[0, 0, 1]

    Scenario: The inverse of an X-rotation rotates in the opposite direction

        Given p := Point[0, 1, 0]
          And H := RotationX[1/8]
          And R := H.inverse
         Then R * p = Point[0, √2/2, -√2/2]
