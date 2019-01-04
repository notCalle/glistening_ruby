Feature: Constructive Solid Geometry

    Scenario: CSG is created with an operation and two shapes

        Given s1 := Sphere[]
          And s2 := Cube[]
         When c := CSG["union", s1, s2]
         Then c.operation = "union"
          And c.left = s1
          And c.right = s2
          And s1.parent = c
          And s2.parent = c

    Scenario Outline: Evaluating the rule for a CSG operation

        Given s1 := Sphere[]
          And s2 := Sphere[]
         When c := CSG["<operation>", s1, s2]
         Then c <allow> allow_intersection <lhit>, <inl>, <inr>

    Examples: CSG union operations
        | operation | lhit  | inl   | inr   | allow     |
        | union     | true  | true  | true  | does not  |
        | union     | true  | true  | false | does      |
        | union     | true  | false | true  | does not  |
        | union     | true  | false | false | does      |
        | union     | false | true  | true  | does not  |
        | union     | false | true  | false | does not  |
        | union     | false | false | true  | does      |
        | union     | false | false | false | does      |
@wip
    Examples: CSG intersection operations
        | operation     | lhit  | inl   | inr   | allow     |
        | intersection  | true  | true  | true  | does      |
        | intersection  | true  | true  | false | does not  |
        | intersection  | true  | false | true  | does      |
        | intersection  | true  | false | false | does not  |
        | intersection  | false | true  | true  | does      |
        | intersection  | false | true  | false | does      |
        | intersection  | false | false | true  | does not  |
        | intersection  | false | false | false | does not  |
