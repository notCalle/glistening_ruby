# frozen_string_literal: true

require_relative '../transformable'

module GlisteningRuby
  # Common name space for patterns
  module Pattern
    # An abstract base class for patterns
    class Base < Transformable
      # :call-seq:
      #   new(pigment, ...) => Pattern
      #
      # A pigment must respond to #color_at(point) => Color
      #
      def initialize(*pigments)
        @pigments = []
        pigments.each { |p| self << p }
        super
        @pigments << @pigments[0]
        @a, @b = @pigments[0..1]
        @pigments.freeze
      end

      attr_reader :a, :b

      def <<(pigment)
        pigment = Color.new(*pigment) if pigment.is_a?(Array)
        @pigments << pigment
      end

      # Transform outside space to pattern space and find color
      #
      # :call-seq:
      #   color_at(object_point) => Color
      #
      def color_at(point)
        point = to_local(point)
        g = grade(point)
        c = @pigments.count - 1
        n = g.floor % c
        a, b = @pigments[n..n + 1].map { |p| p.color_at(point) }
        a.interpolate(b, g % 1)
      end

      # Tranform world reference to object reference and find color
      #
      # :call-seq:
      #   color_at_object(Shape, world_point) => Color
      #
      def color_at_object(object, point)
        color_at(object.to_local(point))
      end

      private

      # Grade a point for color interpolation
      #
      # :call-seq:
      #    grade(point) => scalar
      #
      def grade(_point)
        raise NotImplementedError
      end
    end
  end
end
