Feature: Wavefront OBJ files

    Scenario: Ignoring unrecognized lines

        Given gibberish containing:
            """
            There was a young lady named Bright
            who traveled much faster than light.
            She set out one day
            in a relative way,
            and came back the previous night.
            """
         When parser := ObjFile[gibberish]
         Then parser.ignored = 5

    Scenario: Parsing vertex records

        Given file containing:
            """
            v -1 1 0
            v -1.0000 0.5000 0.0000
            v 1 0 0
            v 1 1 0
            """
         When parser := ObjFile[file]
         Then parser.vertices[1] = Point[-1, 1, 0]
          And parser.vertices[2] = Point[-1, 0.5, 0]
          And parser.vertices[3] = Point[1, 0, 0]
          And parser.vertices[4] = Point[1, 1, 0]

    Scenario: Parsing triangle faces

        Given file containing:
            """
            v -1 1 0
            v -1 0 0
            v 1 0 0
            v 1 1 0

            f 1 2 3
            f 1 3 4
            """
         When parser := ObjFile[file]
          And g := parser.default_group
          And t1 := g[0]
          And t2 := g[1]
         Then t1.v1 = parser.vertices[1]
          And t1.v2 = parser.vertices[2]
          And t1.v3 = parser.vertices[3]
          And t2.v1 = parser.vertices[1]
          And t2.v2 = parser.vertices[3]
          And t2.v3 = parser.vertices[4]
@wip
    Scenario: Triangulating polygons

        Given file containing:
            """
            v -1 1 0
            v -1 0 0
            v 1 0 0
            v 1 1 0
            v 0 2 0

            f 1 2 3 4 5
            """
         When parser := ObjFile[file]
          And g := parser.default_group
          And t1 := g[0]
          And t2 := g[1]
          And t3 := g[2]
         Then t1.v1 = parser.vertices[1]
          And t1.v2 = parser.vertices[2]
          And t1.v3 = parser.vertices[3]
          And t2.v1 = parser.vertices[1]
          And t2.v2 = parser.vertices[3]
          And t2.v3 = parser.vertices[4]
          And t3.v1 = parser.vertices[1]
          And t3.v2 = parser.vertices[4]
          And t3.v3 = parser.vertices[5]
