Feature: Basics of matrix creation and inspection

    Scenario: Constructing and inspecting a 4x4 matrix

        Given the following 4x4 matrix M:
            |  1   |  2   |  3   |  4   |
            |  5.5 |  6.5 |  7.5 |  8.5 |
            |  9   | 10   | 11   | 12   |
            | 13.5 | 14.5 | 15.5 | 16.5 |
         Then M[0,0] = 1
          And M[0,3] = 4
          And M[1,0] = 5.5
          And M[1,2] = 7.5
          And M[2,2] = 11
          And M[3,0] = 13.5
          And M[3,2] = 15.5

    Scenario: A 2x2 matrix ought to be representable

        Given the following 2x2 matrix M:
            | -3 |  5 |
            |  1 | -2 |
         Then M[0,0] = -3
          And M[0,1] = 5
          And M[1,0] = 1
          And M[1,1] = -2

    Scenario: A 3x3 matrix ought to be representable

        Given the following 3x3 matrix M:
            | -3 |  5 |  0 |
            |  1 | -2 | -7 |
            |  0 |  1 |  1 |
        Then M[0,0] = -3
         And M[1,1] = -2
         And M[2,2] = 1

    Scenario: Matrix equality with identical matrices

        Given the following 4x4 matrix A:
            | 1 | 2 | 3 | 4 |
            | 5 | 6 | 7 | 8 |
            | 9 | 8 | 7 | 6 |
            | 5 | 4 | 3 | 2 |
          And the following 4x4 matrix B:
            | 1 | 2 | 3 | 4 |
            | 5 | 6 | 7 | 8 |
            | 9 | 8 | 7 | 6 |
            | 5 | 4 | 3 | 2 |
         Then A = B

    Scenario: Matrix equality with different matrices

        Given the following 4x4 matrix A:
            | 1 | 2 | 3 | 4 |
            | 5 | 6 | 7 | 8 |
            | 9 | 8 | 7 | 6 |
            | 5 | 4 | 3 | 2 |
          And the following 4x4 matrix B:
            | 2 | 3 | 4 | 5 |
            | 6 | 7 | 8 | 9 |
            | 8 | 7 | 6 | 5 |
            | 4 | 3 | 2 | 1 |
         Then A != B

    Scenario: Transposing a matrix

        Given the following 4x4 matrix A:
            | 0 | 9 | 3 | 0 |
            | 9 | 8 | 0 | 8 |
            | 1 | 8 | 5 | 3 |
            | 0 | 0 | 5 | 8 |
         Then A.transpose is the following 4x4 matrix:
            | 0 | 9 | 1 | 0 |
            | 9 | 8 | 8 | 0 |
            | 3 | 0 | 5 | 5 |
            | 0 | 8 | 3 | 8 |

    Scenario: Transposing the identity matrix

        Given the identity matrix I
         Then I.transpose = I
