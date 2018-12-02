Feature: Matrix multiplication

    Scenario: Multiplying two matrices

        Given the following 4x4 matrix A:
            |   1 |   2 |   3 |   4 |
            |   5 |   6 |   7 |   8 |
            |   9 |   8 |   7 |   6 |
            |   5 |   4 |   3 |   2 |
          And the following 4x4 matrix B:
            |  -2 |   1 |   2 |   3 |
            |   3 |   2 |   1 |  -1 |
            |   4 |   3 |   6 |   5 |
            |   1 |   2 |   7 |   8 |
         Then A * B is the following 4x4 matrix:
            |  20 |  22 |  50 |  48 |
            |  44 |  54 | 114 | 108 |
            |  40 |  58 | 110 | 102 |
            |  16 |  26 |  46 |  42 |

    Scenario: Multiplying a matrix by a tuple

        Given the following 4x4 matrix A:
            |   1 |   2 |   3 |   4 |
            |   2 |   4 |   4 |   2 |
            |   8 |   6 |   4 |   1 |
            |   0 |   0 |   0 |   1 |
          And b := Tuple[1, 2, 3, 1]
         Then A * b = Tuple[18, 24, 33, 1]
