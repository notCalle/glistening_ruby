Feature: Color Patterns

    Background: We have two colors

        Given black := Color[0, 0, 0]
          And blue := Color[0.2, 0.5, 0.8]
          And gray := Color[0.5, 0.5, 0.5]
          And pink := Color[0.8, 0.3, 0.4]
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

    Scenario Outline: A ring should extend in both X and Z

        Given pattern := RingPattern[white, black]
          And point := Point[<point>]
         When color := pattern.color_at point
         Then color = <color>

    Examples:
        | point             | color |
        | 0, 0, 0           | white |
        | 1, 0, 0           | black |
        | 0, 0, 1           | black |
        | 0.807, 0, 0.708   | black |

    Scenario Outline: Checkers repeat in all axes

        Given pattern := CheckersPattern[white, black]
          And point := Point[<point>]
         When color := pattern.color_at point
         Then color = <color>

    Examples: repeating in X
        | point         | color |
        | 0, 0, 0       | white |
        | 0.99, 0, 0    | white |
        | 1.01, 0, 0    | black |

    Examples: repeating in Y
        | point         | color |
        | 0, 0, 0       | white |
        | 0, 0.99, 0    | white |
        | 0, 1.01, 0    | black |

    Examples: repeating in Z
        | point         | color |
        | 0, 0, 0       | white |
        | 0, 0, 0.99    | white |
        | 0, 0, 1.01    | black |

    Scenario Outline: A tri-color pattern

          And pattern := StripePattern[white, gray, black]
          And point := Point[<point>]
         When color := pattern.color_at point
         Then color = <color>

    Examples:
        | point     | color |
        | 0.5, 0, 0 | white |
        | 1.5, 0, 0 | gray  |
        | 2.5, 0, 0 | black |

    Scenario Outline: A radial gradient pattern

        Given pattern := RadialPattern[white, black]
          And point := Point[<point>]
         When color := pattern.color_at point
         Then color = Color[<color>]

    Examples:
        | point         | color                     |
        | 0, 0, 0       | 1, 1, 1                   |
        | 1, 0, 0       | 0, 0, 0                   |
        | 0, 0, 1       | 0, 0, 0                   |
        | 0.5, 0, 0     | 0.5, 0.5, 0.5             |
        | -0.5, 0, -0.5 | 0.29289, 0.29289, 0.29289 |

    Scenario Outline: Nesting patterns within patterns

        Given pattern1 := StripePattern[white, black]
          And pattern1.transform= Scaling[1/2, 1/2, 1/2]
          And pattern2 := StripePattern[blue, pink]
          And pattern2.transform= Scaling[1/2, 1/2, 1/2]
          And composite := CheckersPattern[pattern1, pattern2]
          And shape := Sphere[]
          And point := Point[<point>]
         When color := composite.color_at_object shape, point
         Then color = <color>

    Examples:
        | point     | color |
        | 0, 0, 0   | white |
        | 0.5, 0, 0 | black |
        | 1, 0, 0   | blue  |
        | 0.5, 0, 1 | pink  |

    Scenario Outline: Blending patterns

        Given pattern1 := StripePattern[white, black]
          And pattern1.transform= RotationY[1/4]
          And pattern2 := StripePattern[white, gray]
          And blend := BlendPattern[pattern1, pattern2]
          And blend.mode= "<blend mode>"
          And point := Point[<point>]
         When color := blend.color_at point
         Then color = Color[<color>]

    Examples: Arithmetic mean blends the colors linearly
        | blend mode    | point     | color             |
        | arithmetic    | 0, 0, 0   | 1, 1, 1           |
        | arithmetic    | 1, 0, 0   | 0.75, 0.75, 0.75  |
        | arithmetic    | 0, 0, 1   | 0.5, 0.5, 0.5     |
        | arithmetic    | 1, 0, 1   | 0.25, 0.25, 0.25  |

    Examples: Geometric mean blends the colors geometrically
        | blend mode    | point     | color                     |
        | geometric     | 0, 0, 0   | 1, 1, 1                   |
        | geometric     | 1, 0, 0   | 0.70711, 0.70711, 0.70711 |
        | geometric     | 0, 0, 1   | 0, 0, 0                   |
        | geometric     | 1, 0, 1   | 0, 0, 0                   |
@wip
    Examples: Quadratic mean blends the colors quadratically
        | blend mode    | point     | color                     |
        | quadratic     | 0, 0, 0   | 1, 1, 1                   |
        | quadratic     | 1, 0, 0   | 0.79057, 0.79057, 0.79057 |
        | quadratic     | 0, 0, 1   | 0.70711, 0.70711, 0.70711 |
        | quadratic     | 1, 0, 1   | 0.35355, 0.35355, 0.35355 |
