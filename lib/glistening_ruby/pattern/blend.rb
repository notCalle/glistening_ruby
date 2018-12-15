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
        pigments = @pigments[0..-2].map { |p| p.color_at(point) }
        @method.call(pigments)
      end
    end

    # Module with blend mode methods for the blending pattern
    module BlendMode
      def self.[](method)
        instance_method(method).bind(self)
      end

      # Arithmetic mean of the blended pigments
      def arithmetic(pigments)
        pigments.reduce(&:+) / pigments.count
      end

      # Geometric mean of the blended pigments
      def geometric(pigments)
        pigments.reduce(&:*)**(1.0 / pigments.count)
      end
    end
  end
end
