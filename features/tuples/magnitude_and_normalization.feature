Feature: Magnitude, and normalization of vectors

    Scenario Outline: Computing the magnitude of vectors

        Given v := Vector[<vector>]
         Then v.magnitude = <magnitude>

    Examples:
        | vector        | magnitude |
        | 1, 0, 0       | 1         |
        | 0, 1, 0       | 1         |
        | 0, 0, 1       | 1         |
        | 1, 2, 3       | √14       |
        | -1, -2, -3    | √14       |

    Scenario Outline: Normalizing vectors gives unit vectors

        Given v := Vector[<vector>]
          And u := Vector[<unit vector>]
         Then v.normalize = u
          And u.magnitude = 1

    Examples:
        | vector    | unit vector               |
        | 4, 0, 0   | 1, 0, 0                   |
        | 1, 2, 3   | 0.26726, 0.53452, 0.80178 | 1/√14, 2/√14, 3/√14
