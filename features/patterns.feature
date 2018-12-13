Feature: Color Patterns

    Background: We have two colors

        Given black := Color[0, 0, 0]
          And white := Color[1, 1, 1]

    Scenario: Creating a stripe pattern

        Given pattern := StripePattern[white, black]
         Then pattern.a = white
          And pattern.b = black
@wip
    Scenario Outline: A stripe pattern versus axis translation

        Given pattern := StripePattern[white, black]
          And p := Point[<point>]
         When c := pattern.stripe_at p
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

