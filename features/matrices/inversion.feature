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

    Scenario: Testing an invertible matrix for invertibility

        Given the following 4x4 matrix A:
            |  6 |  4 |  4 |  4 |
            |  5 |  5 |  7 |  6 |
            |  4 | -9 |  3 | -7 |
            |  9 |  1 |  7 | -6 |
         Then A.determinant = -2120
          And A is invertible

    Scenario: Testing a non-invertible matrix for invertibility

        Given the following 4x4 matrix A:
            | -4 |  2 | -2 | -3 |
            |  9 |  6 |  2 |  6 |
            |  0 | -5 |  1 | -5 |
            |  0 |  0 |  0 |  0 |
         Then A.determinant = 0
          And A is not invertible

    Scenario: Calculating the inverse of a matrix

        Given the following 4x4 matrix A:
            | -5 |  2 |  6 | -8 |
            |  1 | -5 |  1 |  8 |
            |  7 |  7 | -6 | -7 |
            |  1 | -3 |  7 |  4 |
         And B := A.inverse
        Then A.determinant = 532
         And A.cofactor 2, 3 = -160
         And B[3,2] = -160/532
         And A.cofactor 3, 2 = 105
         And B[2,3] = 105/532
         And B is the following 4x4 matrix:
             |  0.21805 |  0.45113 |  0.24060 | -0.04511 |
             | -0.80827 | -1.45677 | -0.44361 |  0.52068 |
             | -0.07895 | -0.22368 | -0.05263 |  0.19737 |
             | -0.52256 | -0.81391 | -0.30075 |  0.30639 |

    Scenario: Calculating the inverse of another matrix

        Given the following 4x4 matrix A:
            |  8 | -5 |  9 |  2 |
            |  7 |  5 |  6 |  1 |
            | -6 |  0 |  9 |  6 |
            | -3 |  0 | -9 | -4 |
         Then A.inverse is the following 4x4 matrix:
            | -0.15385 | -0.15385 | -0.28205 | -0.53846 |
            | -0.07692 |  0.12308 |  0.02564 |  0.03077 |
            |  0.35897 |  0.35897 |  0.43590 |  0.92308 |
            | -0.69231 | -0.69231 | -0.76923 | -1.92308 |

    Scenario: Calculating the inverse of a third matrix

        Given the following 4x4 matrix A:
            |  9 |  3 |  0 |  9 |
            | -5 | -2 | -6 | -3 |
            | -4 |  9 |  6 |  4 |
            | -7 |  6 |  6 |  2 |
         Then A.inverse is the following 4x4 matrix:
            | -0.04074 | -0.07778 |  0.14444 | -0.22222 |
            | -0.07778 |  0.03333 |  0.36667 | -0.33333 |
            | -0.02901 | -0.14630 | -0.10926 |  0.12963 |
            |  0.17778 |  0.06667 | -0.26667 |  0.33333 |

    Scenario: Multiplying a product by its inverse

        Given the following 4x4 matrix A:
            |  3 | -9 |  7 |  3 |
            |  3 | -8 |  2 | -9 |
            | -4 |  4 |  4 |  1 |
            | -6 |  5 | -1 |  1 |
          And the following 4x4 matrix B:
            |  8 |  2 |  2 |  2 |
            |  3 | -1 |  7 |  0 |
            |  7 |  0 |  5 |  4 |
            |  6 | -2 |  0 |  5 |
          And C := A * B
         Then C * B.inverse = A
