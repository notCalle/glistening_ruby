Feature: Groups of shapes

    Scenario: Creating a new group

        Given g := Group[]
         Then g.transform is the identity matrix
          And g is empty
