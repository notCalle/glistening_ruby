Feature: Light sources

    Scenario: A point light has a position and intensity

        Given intensity := Color[1, 1, 1]
          And position := Point[0, 0, 0]
         When light := PointLight[position, intensity]
         Then light.position = position
          And light.intensity = intensity
