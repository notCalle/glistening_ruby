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

    Scenario: Rotating a point around the Y axis

        Given p := Point[0, 0, 1]
          And H := RotationY[1/8]
          And F := RotationY[1/4]
         Then H * p = Point[√2/2, 0, √2/2]
          And F * p = Point[1, 0, 0]

    Scenario: Rotating a point around the Z axis

        Given p := Point[0, 1, 0]
          And H := RotationZ[1/8]
          And F := RotationZ[1/4]
         Then H * p = Point[-√2/2, √2/2, 0]
          And F * p = Point[-1, 0, 0]
