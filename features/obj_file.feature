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
