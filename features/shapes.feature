Feature: Abstract shapes

    Background: We have a test shape

        Given s := TestShape[]
          And v := Vector[0, 0, 1]

    Scenario: A shape's default transformation

        Then s.transform is the identity matrix

    Scenario: Changing a shape's transformation

        Given M := Translation[2, 3, 4]
         When s.transform= M
         Then s.transform = M

    Scenario: A shape has a default material

        When m := s.material
        Then m = Material[]

    Scenario: A shape may be assigned a material

        Given m := Material[]
          And m.ambient= 1
         When s.material= m
         Then m = s.material

    Scenario: Intersecting a scaled shape with a ray

        Given p := Point[0, 0, -5]
          And M := Scaling[2, 2, 2]
         When r := Ray[p, v]
          And s.transform= M
          And xs := s.intersect r
          And lr := s.local_ray
         Then lr.origin = Point[0, 0, -2.5]
          And lr.direction = Vector[0, 0, 0.5]

    Scenario: Intersecting a translated shape with a ray

        Given p := Point[0, 0, -5]
          And M := Translation[5, 0, 0]
         When r := Ray[p, v]
          And s.transform= M
          And xs := s.intersect r
          And lr := s.local_ray
         Then lr.origin = Point[-5, 0, -5]
          And lr.direction = Vector[0, 0, 1]

    Scenario: Computing the normal on a translated shape

        Given M := Translation[0, 1, 0]
          And p := Point[0, 1.70711, -0.70711]
         When s.transform= M
          And n := s.normal_at p
         Then n = Vector[0, 0.70711, -0.70711]

    Scenario: Computing the normal on a transformed shape

        Given S := Scaling[1, 0.5, 1]
          And R := RotationZ[1/10]
          And p := Point[0, √2/2, -√2/2]
         When M := S * R
          And s.transform= M
          And n := s.normal_at p
         When n = Vector[0, 0.97014, -0.24254]

    Scenario: By default, a shape casts shadows

         Then s does cast_shadows

    Scenario: A shape can have shadow casting disabled

        Given bool := false
          And s.cast_shadows= bool
         Then s does not cast_shadows
