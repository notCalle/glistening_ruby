# frozen_string_literal: true

require_relative '../transformable'

module GlisteningRuby
  # Common name space for patterns
  module Pattern
    # An abstract base class for patterns
    class Base < Transformable
      def initialize(*pigments)
        @a, @b, = *pigments.map { |p| p.is_a?(Tuple) ? p : Color[*p] }
        super
      end

      attr_reader :a, :b

      def color_at(point)
        @a.interpolate(@b, constrain(grade(point)))
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
