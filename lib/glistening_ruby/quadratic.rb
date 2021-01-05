# frozen_string_literal: true

module GlisteningRuby
  # Module for privately solving quadratic equations
  #
  # rubocop:disable Style/AsciiComments
  #
  # Solve f(x) = ax^2 + bx + c, f(x) = 0
  # -b ± √bb-4ac
  # ------------
  #      2a
  #
  # rubocop:enable Style/AsciiComments
  #
  # :call-seq:
  #   quadratic(a, b, c) => [x0, x1]
  #
  module Quadratic
    private

    def quadratic(a, b, c)
      discriminant = b * b - 4 * a * c
      return [] if discriminant.negative?
      return quadratic_one(a, b) if discriminant.zero?

      quadratic_two(a, b, discriminant)
    end

    def quadratic_one(a, b)
      x = -0.5 * b / a
      [x, x]
    end

    def quadratic_two(a, b, discriminant)
      d = Math.sqrt(discriminant)
      x0 = -0.5 * (b + d) / a
      x1 = -0.5 * (b - d) / a
      [x0, x1]
    end
  end
end
