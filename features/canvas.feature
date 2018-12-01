Feature: Drawable canvas

    Scenario: Creating a canvas

        Given c := Canvas[10, 20]
         Then c.w = 10
          And c.h = 20
          And every pixel of c is Color[0, 0, 0]

    Scenario: Writing pizels to a canvas

        Given c := Canvas[10, 20]
          And red := Color[1, 0, 0]
         When c[2, 3] := red
         Then c[2, 3] = red

    Scenario: Constructing the PPM header

        Given c := Canvas[5, 3]
         When ppm := c.to_ppm
         Then lines 1 to 3 of ppm are
            """
            P3
            5 3
            255
            """

    Scenario: Constructing the PPM pixel data

        Given c := Canvas[5, 3]
          And c1 := Color[1.5, 0, 0]
          And c2 := Color[0, 0.5, 0]
          And c3 := Color[-0.5, 0, 1]
         When c[0, 0] := c1
          And c[2, 1] := c2
          And c[4, 2] := c3
          And ppm := c.to_ppm
         Then lines 4 to 6 of ppm are
            """
            255 0 0 0 0 0 0 0 0 0 0 0 0 0 0
            0 0 0 0 0 0 0 128 0 0 0 0 0 0 0
            0 0 0 0 0 0 0 0 0 0 0 0 0 0 255
            """
