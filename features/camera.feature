Feature: View the world through a camera

    Scenario: Constructing a camera

        Given width := 160
          And height := 120
          And fov := 1/4
         When c := Camera[width, height, fov]
         Then c.w = 160
          And c.h = 120
          And c.fov = 1/4
          And c.transform is the identity matrix

    Scenario: The pixel size for a landscape canvas

        Given c := Camera[200, 125, 1/4]
         Then c.pixel_size = 0.01

    Scenario: The pixel size for a portrait canvas

        Given c := Camera[125, 200, 1/4]
         Then c.pixel_size = 0.01
