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

    Scenario: Triangles in groups

        Given file with contents of "triangles.obj"
         When parser := ObjFile[file]
          And g1 := parser["FirstGroup"]
          And g2 := parser["SecondGroup"]
          And t1 := g1[0]
          And t2 := g2[0]
         Then t1.v1 = parser.vertices[1]
          And t1.v2 = parser.vertices[2]
          And t1.v3 = parser.vertices[3]
          And t2.v1 = parser.vertices[1]
          And t2.v2 = parser.vertices[3]
          And t2.v3 = parser.vertices[4]

    Scenario: Converting an OBJ file to a group

        Given file with contents of "triangles.obj"
          And parser := ObjFile[file]
         When g := parser.to_group
          And g1 := parser["FirstGroup"]
          And g2 := parser["SecondGroup"]
         Then g includes g1
          And g includes g2

    Scenario: Vertex normal records

        Given file containing:
            """
            vn 0 0 1
            vn 0.707 0 -0.707
            vn 1 2 3
            """
         When parser := ObjFile[file]
         Then parser.normals[1] = Vector[0, 0, 1]
          And parser.normals[2] = Vector[0.707, 0, -0.707]
          And parser.normals[3] = Vector[1, 2, 3]
@wip
    Scenario: Faces with normals

        Given file containing:
            """
            v 0 1 0
            v -1 0 0
            v 1 0 0

            vn -1 0 0
            vn 1 0 0
            vn 0 1 0

            f 1//3 2//1 3//2
            f 1/0/3 2/102/1 3/14/2
            """
         When parser := ObjFile[file]
          And g := parser.default_group
          And t1 := g[0]
          And t2 := g[1]
         Then t1.v1 = parser.vertices[1]
          And t1.v2 = parser.vertices[2]
          And t1.v3 = parser.vertices[3]
          And t1.n1 = parser.normals[3]
          And t1.n2 = parser.normals[1]
          And t1.n3 = parser.normals[2]
          And t2 is identical to t1
