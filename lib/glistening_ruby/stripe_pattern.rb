# frozen_string_literal: true

module GlisteningRuby
  # A striped pattern
  class StripePattern < Base
    def initialize(color_a, color_b)
      @a = color_a.is_a?(Tuple) ? color_a : Color[*color_a]
      @b = color_b.is_a?(Tuple) ? color_b : Color[*color_b]
      @transform = @inverse = Matrix::IDENTITY
      super
    end

    attr_reader :a, :b, :transform

    def transform=(matrix)
      @transform = matrix
      @inverse = matrix.inverse
    end

    def color_at(point)
      (point.x.floor % 2).zero? ? @a : @b
    end

    def color_at_object(object, point)
      object_point = object.inverse * point
      pattern_point = @inverse * object_point
      color_at(pattern_point)
    end
  end
end
