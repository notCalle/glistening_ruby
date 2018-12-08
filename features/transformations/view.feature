Feature: View transformations

    Scenario: The transformation matrix of the default orientation

        Given from := Point[0, 0, 0]
          And to := Point[0, 0, -1]
          And up := Vector[0, 1, 0]
         When T := ViewTransform[from, to, up]
         Then T is the identity matrix

    Scenario: The transformation matrixm looking in the positive z direction

        Given from := Point[0, 0, 0]
          And to := Point[0, 0, 1]
          And up := Vector[0, 1, 0]
         When T := ViewTransform[from, to, up]
         Then T = Scaling[-1, 1, -1]

    Scenario: The view transformation moves the world

        Given from := Point[0, 0, 8]
          And to := Point[0, 0, 0]
          And up := Vector[0, 1, 0]
         When T := ViewTransform[from, to, up]
         Then T = Translation[0, 0, -8]

    Scenario: An arbitrary transformation

        Given from := Point[1, 3, 2]
          And to := Point[4, -2, 8]
          And up := Vector[1, 1, 0]
         When T := ViewTransform[from, to, up]
         Then T is the following 4x4 matrix:
            | -0.50709 |  0.50709 |  0.67612 | -2.36643 |
            |  0.76772 |  0.60609 |  0.12122 | -2.82843 |
            | -0.35857 |  0.59761 | -0.71714 |  0.00000 |
            |  0.00000 |  0.00000 |  0.00000 |  1.00000 |
