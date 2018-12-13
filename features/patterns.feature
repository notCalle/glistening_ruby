Feature: Color Patterns

    Background: We have two colors

        Given black := Color[0, 0, 0]
          And white := Color[1, 1, 1]

    Scenario: Creating a stripe pattern

        Given pattern := StripePattern[white, black]
         Then pattern.a = white
          And pattern.b = black

    Scenario Outline: A stripe pattern versus axis translation

        Given pattern := StripePattern[white, black]
          And p := Point[<point>]
         When c := pattern.color_at p
         Then c = <color>

    Examples: Constant in Y
        | point         | color |
        | 0, 0, 0       | white |
        | 0, 1, 0       | white |
        | 0, 2, 0       | white |

    Examples: Constant in Z
        | point         | color |
        | 0, 0, 0       | white |
        | 0, 0, 1       | white |
        | 0, 0, 2       | white |

    Examples: Alternates in X
        | point         | color |
        | 0, 0, 0       | white |
        | 0.9, 0, 0     | white |
        | 1, 0, 0       | black |
        | -0.1, 0, 0    | black |
        | -1.1, 0, 0    | white |
@wip
    Scenario: Stripes with an object transformation

        Given shape := Sphere[]
          And shape.transform= Scaling[2, 2, 2]
          And pattern := StripePattern[white, black]
          And p := Point[1.5, 0, 0]
         When c := pattern.color_at_object shape, p
         Then c = white
@wip
    Scenario: Stripes with a pattern transformation

        Given shape := Sphere[]
          And pattern := StripePattern[white, black]
          And pattern.transform= Scaling[2, 2, 2]
          And p := Point[1.5, 0, 0]
         When c := pattern.color_at_object shape, p
         Then c = white
@wip
    Scenario: Stripes with both an object and a pattern transformation

        Given shape := Sphere[]
          And shape.transform= Scaling[2, 2, 2]
          And pattern := StripePattern[white, black]
          And pattern.transform= Translation[0.5, 0, 0]
          And p := Point[2.5, 0, 0]
         When c := pattern.color_at_object shape, p
         Then c = white
