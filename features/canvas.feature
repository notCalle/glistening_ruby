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
