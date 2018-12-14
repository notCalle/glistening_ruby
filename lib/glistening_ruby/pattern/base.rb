# frozen_string_literal: true

require_relative '../transformable'

module GlisteningRuby
  # Common name space for patterns
  module Pattern
    # An abstract base class for patterns
    class Base < Transformable
      def initialize(*pigments)
        @pigments = pigments.map { |p| p.is_a?(Tuple) ? p : Color[*p] }
        @pigments << @pigments[0]
        @a, @b = @pigments[0..1]
        super
      end

      attr_reader :a, :b

      def color_at(point)
        g = grade(point)
        c = @pigments.count - 1
        p = g.floor % c
        a, b = @pigments[p..p + 1]
        a.interpolate(b, constrain(g - p))
      end

      def color_at_object(object, point)
        object_point = object.inverse * point
        pattern_point = @inverse * object_point
        color_at(pattern_point)
      end

      private

      # Grade a point for color interpolation
      #
      # :call-seq:
      #    grade(point) => scalar
      #
      def grade(point)
        point.x
      end

      # Constrain a value 0 <= constrain(value) <= 1
      #
      # :call-seq:
      #    constrain(scalar) => scalar
      def constrain(_value)
        raise NotImplementedError
      end
    end
  end
end
