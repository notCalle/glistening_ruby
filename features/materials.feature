Feature: Surface materials

    Background:

        Given m := Material[]
          And c := Color[1, 1, 1]
          And position := Point[0, 0, 0]
          And normalv := Vector[0, 0, -1]

    Scenario: The default material

         Then m.color = Color[1, 1, 1]
          And m.ambient = 0.1
          And m.diffuse = 0.9
          And m.specular = 0.9
          And m.shininess = 200

    Scenario: Lighting with the eye between the light and the surface

        Given eyev := Vector[0, 0, -1]
          And p := Point[0, 0, -10]
         When light := PointLight[p, c]
          And result := m.lighting light, position, eyev, normalv
         Then result = Color[1.9, 1.9, 1.9]

    Scenario: Lighting with the eye between the light and surface, offset 45°

        Given eyev := Vector[0, √2/2, -√2/2]
          And p := Point[0, 0, -10]
         When light := PointLight[p, c]
          And result := m.lighting light, position, eyev, normalv
         Then result = Color[1.0, 1.0, 1.0]

    Scenario: Lighting with eye opposite surface, light offset 45°

        Given eyev := Vector[0, 0, -1]
          And p := Point[0, 10, -10]
         When light := PointLight[p, c]
          And result := m.lighting light, position, eyev, normalv
         Then result = Color[0.7364, 0.7364, 0.7364]

    Scenario: Lighting with eye opposite surface, light offset 45°

        Given eyev := Vector[0, -√2/2, -√2/2]
          And p := Point[0, 10, -10]
         When light := PointLight[p, c]
          And result := m.lighting light, position, eyev, normalv
         Then result = Color[1.6364, 1.6364, 1.6364]

    Scenario: Lighting with the light behind the surface

        Given eyev := Vector[0, 0, -1]
          And p := Point[0, 0, 10]
         When light := PointLight[p, c]
          And result := m.lighting light, position, eyev, normalv
         Then result = Color[0.1, 0.1, 0.1]
@wip
    Scenario: Lighting with the surface in shadow

        Given eyev := Vector[0, 0, -1]
          And normalv := Vector[0, 0, -1]
          And p := Point[0, 0, -10]
          And light := PointLight[p, c]
          And inshadow := true
         When result := m.lighting light, position, eyev, normalv, inshadow
         Then result = Color[0.1, 0.1, 0.1]
