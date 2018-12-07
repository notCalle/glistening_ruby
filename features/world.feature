Feature: A scene world

    Scenario: Creating a world

        Given w := World[]
         Then w contains no objects
          And w has no light source

    # @wip
    # Scenario: The default world
    #
    #     Given point := Point[-10, 10, -10]
    #       And light := PointLight[point]
    #       And s1 := Sphere[] with:
    #           | material.color      | [0.8, 1.0, 0.6]   |
    #           | material.diffuse    | 0.7               |
    #           | material.specular   | 0.2               |
    #       And s2 := Sphere[] with:
    #           | transform           | Scaling[0.5, 0.5, 0.5] |
    #      When w is the default world
    #      Then w.light = light
    #       And w contains s1
    #       And w contains s2

    Scenario: Intersect a world with a ray

        Given w is the default world
          And p := Point[0, 0, -5]
          And v := Vector[0, 0, 1]
         When r := Ray[p, v]
          And xs := w.intersect r
         Then xs.count = 4
          And xs[0].t = 4
          And xs[1].t = 4.5
          And xs[2].t = 5.5
          And xs[3].t = 6
