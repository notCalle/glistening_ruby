Feature: Color Patterns

    Background: We have two colors

        Given black := Color[0, 0, 0]
          And white := Color[1, 1, 1]
@wip
    Scenario: Creating a stripe pattern

        Given pattern := StripePattern[white, black]
         Then pattern.a = white
          And pattern.b = black
