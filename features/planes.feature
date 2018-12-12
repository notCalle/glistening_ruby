Feature: Snakeless planes

    Scenario: The normal of a plane is constant everywhere

        Given s := Plane[]
          And p1 := Point[0, 0, 0]
          And p2 := Point[10, 0, -10]
          And p3 := Point[-5, 0, 150]
         When n1 := s.normal_at p1
          And n2 := s.normal_at p2
          And n3 := s.normal_at p3
         Then n1 = Vector[0, 1, 0]
          And n2 = Vector[0, 1, 0]
          And n3 = Vector[0, 1, 0]
