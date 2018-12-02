@wip
Feature: Translation matrices

    Background: We have a translation matrix

        Given T := Translation[5, -3, 2]

    Scenario: Multiplying by a translation matrix

        Given p := Point[-3, 4, 5]
         Then T * p = Point[2, 1, 7]

    Scenario: Multiplying by the inverse of a translation matrix

        Given p := Point[-3, 4, 5]
         When S := T.inverse
         Then S * p = Point[-8, 7, 3]

    Scenario: Translation does not affect vectors

        Given v := Vector[-3, 4, 5]
         Then T * v = v
