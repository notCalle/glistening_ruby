Feature: Groups of shapes
@wip
    Scenario: Creating a new group

        Given g := Group[]
         Then g.transform is the identity matrix
          And g is empty
