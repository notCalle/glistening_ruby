Feature: Matrix inversion

    Scenario: Calculating the determinant of a 2x2 matrix

        Given the following 2x2 matrix A:
            |  1 |  5 |
            | -3 |  2 |
         Then A.determinant = 17

    Scenario: A submatrix of a 3x3 matrix is a 2x2 matrix

        Given the following 3x3 matrix A:
            |  1 |  5 |  0 |
            | -3 |  2 |  7 |
            |  0 |  6 | -3 |
         Then A.submatrix 0, 2 is the following 2x2 matrix:
            | -3 |  2 |
            |  0 |  6 |

    Scenario: A submatrix of a 4x4 matrix is a 3x3 matrix

        Given the following 4x4 matrix A:
            | -6 |  1 |  1 |  6 |
            | -8 |  5 |  8 |  6 |
            | -1 |  0 |  8 |  2 |
            | -7 |  1 | -1 |  1 |
         Then A.submatrix 2, 1 is the following 3x3 matrix:
            | -6 |  1 |  6 |
            | -8 |  8 |  6 |
            | -7 | -1 |  1 |

    Scenario: Calculating a minor of a 3x3 matrix

        Given the following 3x3 matrix A:
            |  3 |  5 |  0 |
            |  2 | -1 | -7 |
            |  6 | -1 |  5 |
          And B := A.submatrix 1, 0
         Then B.determinant = 25
          And A.minor 1, 0 = 25

    Scenario: Calculating a cofactor of a 3x3 matrix

        Given the following 3x3 matrix A:
            |  3 |  5 |  0 |
            |  2 | -1 | -7 |
            |  6 | -1 |  5 |
         Then A.minor 0, 0 = -12
          And A.cofactor 0, 0 = -12
          And A.minor 1, 0 = 25
          And A.cofactor 1, 0 = -25

    Scenario: Calculating the determinant of a 3x3 matrix

        Given the following 3x3 matrix A:
            |  1 |  2 |  6 |
            | -5 |  8 | -4 |
            |  2 |  6 |  4 |
         Then A.cofactor 0, 0 = 56
          And A.cofactor 0, 1 = 12
          And A.cofactor 0, 2 = -46
          And A.determinant = -196

    Scenario: Calculating the determinant of a 4x4 matrix

        Given the following 4x4 matrix A:
            | -2 | -8 |  3 |  5 |
            | -3 |  1 |  7 |  3 |
            |  1 |  2 | -9 |  6 |
            | -6 |  7 |  7 | -9 |
         Then A.cofactor 0, 0 = 690
          And A.cofactor 0, 1 = 447
          And A.cofactor 0, 2 = 210
          And A.cofactor 0, 3 = 51
          And A.determinant = -4071
@wip
    Scenario: Testing an invertible matrix for invertibility

        Given the following 4x4 matrix A:
            |  6 |  4 |  4 |  4 |
            |  5 |  5 |  7 |  6 |
            |  4 | -9 |  3 | -7 |
            |  9 |  1 |  7 | -6 |
         Then A.determinant = -2120
          And A is invertible
@wip
    Scenario: Testing a non-invertible matrix for invertibility

        Given the following 4x4 matrix A:
            | -4 |  2 | -2 | -3 |
            |  9 |  6 |  2 |  6 |
            |  0 | -5 |  1 | -5 |
            |  0 |  0 |  0 |  0 |
         Then A.determinant = 0
          And A is not invertible
