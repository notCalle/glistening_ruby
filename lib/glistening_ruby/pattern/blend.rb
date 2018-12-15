# frozen_string_literal: true

require_relative 'stripe'

module GlisteningRuby
  module Pattern
    # A cubic checkers pattern
    class Blend < Base
      def initialize(*)
        self.mode = :arithmetic
        super
      end

      def mode=(method)
        method = BlendMode[method] unless method.is_a? Proc
        @method = method
      end

      def color_at(point)
        point = to_local(point)
        colors = @pigments[0..-2].map { |p| p.color_at(point) }
        @method.call(colors)
      end
    end

    # Module with blend mode methods for the blending pattern
    module BlendMode
      def self.[](method)
        instance_method(method).bind(self)
      end

      # Arithmetic mean of the blended colors
      def arithmetic(colors)
        colors.reduce(&:+) / colors.count
      end

      # Geometric mean of the blended colors
      def geometric(colors)
        colors.reduce(&:*)**(1.0 / colors.count)
      end

      # Quadratic mean of the blended colors
      def quadratic(colors)
        (colors.map { |p| p**2 }.reduce(&:+) / colors.count)**0.5
      end
    end
  end
end
