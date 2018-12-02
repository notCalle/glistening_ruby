Feature: Matrix inversion
@wip
    Scenario: Calculating the determinant of a 2x2 matrix

        Given the following 2x2 matrix A:
            |  1 |  5 |
            | -3 |  2 |
         Then A.determinant = 17
