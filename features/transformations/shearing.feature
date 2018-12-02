@wip
Feature: Shearing transformation matrices

    Background: We have a point to be sheared

        Given p := Point[2, 3, 4]

    Scenario: A shering transformation that moves X in proportion to Y

        Given S := Shearing[1, 0, 0, 0, 0, 0]
         Then S * p = Point[5, 3, 4]

    Scenario: A shering transformation that moves X in proportion to Z

        Given S := Shearing[0, 1, 0, 0, 0, 0]
         Then S * p = Point[6, 3, 4]

    Scenario: A shering transformation that moves Y in proportion to X

        Given S := Shearing[0, 0, 1, 0, 0, 0]
         Then S * p = Point[2, 5, 4]

    Scenario: A shering transformation that moves Y in proportion to Z

        Given S := Shearing[0, 0, 0, 1, 0, 0]
         Then S * p = Point[2, 7, 4]

    Scenario: A shering transformation that moves Z in proportion to X

        Given S := Shearing[0, 0, 0, 0, 1, 0]
         Then S * p = Point[2, 3, 6]

    Scenario: A shering transformation that moves Z in proportion to X

        Given S := Shearing[0, 0, 0, 0, 0, 1]
         Then S * p = Point[2, 3, 7]
