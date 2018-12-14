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

    Scenario: Pattern with an object transformation

        Given shape := Sphere[]
          And shape.transform= Scaling[2, 2, 2]
          And pattern := TestPattern[]
          And p := Point[2, 3, 4]
         When c := pattern.color_at_object shape, p
         Then c = Color[1, 1.5, 2]

    Scenario: Pattern with a pattern transformation

        Given shape := Sphere[]
          And pattern := TestPattern[]
          And pattern.transform= Scaling[2, 2, 2]
          And p := Point[2, 3, 4]
         When c := pattern.color_at_object shape, p
         Then c = Color[1, 1.5, 2]

    Scenario: Pattern with both an object and a pattern transformation

        Given shape := Sphere[]
          And shape.transform= Scaling[2, 2, 2]
          And pattern := TestPattern[]
          And pattern.transform= Translation[0.5, 1, 1.5]
          And p := Point[2.5, 3, 3.5]
         When c := pattern.color_at_object shape, p
         Then c = Color[0.75, 0.5, 0.25]

    Scenario: The default pattern transformation

        Given pattern := TestPattern[]
         Then pattern.transform is the identity matrix

    Scenario: Assigning a transformation

        Given pattern := TestPattern[]
         When pattern.transform= Translation[1, 2, 3]
         Then pattern.transform = Translation[1, 2, 3]
@wip
    Scenario Outline: A gradient linearly interpolates between colors

        Given pattern := GradientPattern[white, black]
          And point := Point[<point>]
         When color := pattern.color_at point
         Then color := Color[<color>]

    Examples:
        | point         | color             |
        | 0, 0, 0       | 1.0, 1.0, 1.0     |
        | 0.25, 0, 0    | 0.75, 0.75, 0.75  |
        | 0.5, 0, 0     | 0.5, 0.5, 0.5     |
        | 0.75, 0, 0    | 0.25, 0.25, 0.25  |
