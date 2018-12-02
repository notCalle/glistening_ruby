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
