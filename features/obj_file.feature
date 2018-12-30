Feature: Wavefront OBJ files
@wip
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
