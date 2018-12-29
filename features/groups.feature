Feature: Groups of shapes

    Scenario: Creating a new group

        Given g := Group[]
         Then g.transform is the identity matrix
          And g is empty
@wip
    Scenario: Adding a child to a group

        Given g := Group[]
          And s := TestShape[]
         When s is added to g
         Then g is not empty
          And g includes s
          And s.parent = g
