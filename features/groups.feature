Feature: Groups of shapes

    Scenario: Creating a new group

        Given g := Group[]
         Then g.transform is the identity matrix
          And g is empty

    Scenario: Adding a child to a group

        Given g := Group[]
          And s := TestShape[]
         When s is added to g
         Then g is not empty
          And g includes s
          And s.parent = g
@wip
    Scenario: Intersecting a ray with an empty group

        Given g := Group[]
          And p := Point[0, 0, 0]
          And v := Vector[0, 0, 1]
          And r := Ray[p, v]
         When xs := g.intersect r
         Then xs is empty
@wip
    Scenario: Intersecting a ray with a non-empty group

        Given g := Group[]
          And s1 := Sphere[]
          And s2 := Sphere[]
          And s2.transform= Translation[0, 0, -3]
          And s3 := Sphere[]
          And s3.transform= Translation[5, 0, 0]
          And s1 is added to g
          And s2 is added to g
          And s3 is added to g
         When p := Point[0, 0, -5]
          And v := Vector[0, 0, 1]
          And r := Ray[p, v]
          And xs := g.intersect r
         Then xs.count = 4
          And xs[0].object = s2
          And xs[1].object = s2
          And xs[2].object = s1
          And xs[3].object = s1
