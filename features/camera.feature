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

    Scenario: Constructing a ray through the center of the canvas

        Given c := Camera[201, 101, 1/4]
         When r := c.ray_for_pixel 100, 50
         Then r.origin = Point[0, 0, 0]
          And r.direction = Vector[0, 0, -1]

    Scenario: Constructing a ray through a corner of the canvas

        Given c := Camera[201, 101, 1/4]
         When r := c.ray_for_pixel 0, 0
         Then r.origin = Point[0, 0, 0]
          And r.direction = Vector[0.66519, 0.33259, -0.66851]

    Scenario: Constructing a ray when the camera is transformed

        Given c := Camera[201, 101, 1/4]
          And R := RotationY[1/8]
          And T := Translation[0, -2, 5]
          And M := R * T
         When c.transform= M
          And r := c.ray_for_pixel 100, 50
         Then r.origin = Point[0, 2, -5]
          And r.direction = Vector[√2/2, 0, -√2/2]
@wip
    Scenario: Rendering a world with a camera

        Given w is the default world
          And c := Camera[11, 11, 1/4]
          And origin := Point[0, 0, -5]
          And lookat := Point[0, 0, 0]
          And up := Vector[0, 1, 0]
          And T := ViewTransform[origin, lookat, up]
          And c.transform= T
         When image := c.render w
          And color := Color[0.38066, 0.47583, 0.28550]
         Then image[5, 5] = color
