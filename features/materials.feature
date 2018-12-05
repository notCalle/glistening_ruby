Feature: Surface materials

    Scenario: The default material

        Given m := Material[]
         Then m.color = Color[1, 1, 1]
          And m.ambient = 0.1
          And m.diffuse = 0.9
          And m.specular = 0.9
          And m.shininess = 200
