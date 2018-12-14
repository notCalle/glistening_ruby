# frozen_string_literal: true

require_relative 'pattern'

module GlisteningRuby
  # A gradient pattern
  class GradientPattern < Pattern
    def initialize(color_a, color_b)
      @a = color_a.is_a?(Tuple) ? color_a : Color[*color_a]
      @b = color_b.is_a?(Tuple) ? color_b : Color[*color_b]
      super
    end

    attr_reader :a, :b

    def color_at(point)
      @a.interpolate(@b, point.x % 1)
    end
  end
end
