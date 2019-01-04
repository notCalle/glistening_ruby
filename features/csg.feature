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

    Examples: CSG difference operations
        | operation     | lhit  | inl   | inr   | allow     |
        | difference    | true  | true  | true  | does not  |
        | difference    | true  | true  | false | does      |
        | difference    | true  | false | true  | does not  |
        | difference    | true  | false | false | does      |
        | difference    | false | true  | true  | does      |
        | difference    | false | true  | false | does      |
        | difference    | false | false | true  | does not  |
        | difference    | false | false | false | does not  |

    Scenario Outline: Filtering a list of intersections

        Given s1 := Sphere[]
          And s2 := Cube[]
          And c := CSG["<operation>", s1, s2]
          And i0 := Intersection[1, s1]
          And i1 := Intersection[2, s2]
          And i2 := Intersection[3, s1]
          And i3 := Intersection[4, s2]
          And xs := Intersections[i0, i1, i2, i3]
         When result := c.select_intersections xs
         Then result.count = 2
          And result[0] = xs[<x0>]
          And result[1] = xs[<x1>]

    Examples:
        | operation     | x0    | x1    |
        | union         | 0     | 3     |
        | intersection  | 1     | 2     |
        | difference    | 0     | 1     |
@wip
    Scenario: A ray misses a CSG object

        Given s1 := Sphere[]
          And s2 := Cube[]
          And c := CSG["union", s1, s2]
          And p := Point[0, 2, -5]
          And v := Vector[0, 0, 1]
          And r := Ray[p, v]
         When xs := c.intersect r
         Then xs is empty
@wip
    Scenario: A ray hits a CSG object

        Given s1 := Sphere[]
          And s2 := Sphere[]
          And s2.transform= Translation[0, 0, 0.5]
          And c := CSG["union", s1, s2]
          And p := Point[0, 0, -5]
          And v := Vector[0, 0, 1]
          And r := Ray[p, v]
         When xs := c.intersect r
         Then xs.count = 2
          And xs[0].t = 4
          And xs[0].object = s1
          And xs[1].t = 6.5
          And xs[1].object = s2
