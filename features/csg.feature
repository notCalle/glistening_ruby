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
