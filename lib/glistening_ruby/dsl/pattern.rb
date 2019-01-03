# frozen_string_literal: true

require_relative 'color'
require_relative 'transformable'

module GlisteningRuby
  module DSL
    # Pattern builder DSL class
    class Pattern < Transformable
      include ColorSpace

      def color(color)
        color = Color[color] if color.is_a? Symbol
        pigments << color
      end

      def pattern(name, &block)
        pigments << Pattern[name, &block]
      end

      private

      def pigments
        @pigments ||= []
      end
    end

    # Blend pattern builder DSL class
    class Blend < Pattern
      def instance
        super
        ::GlisteningRuby::Pattern::Blend.new { |i| copy_ivars(i) }
      end
    end

    # Checkers pattern builder DSL class
    class Checkers < Pattern
      def instance
        super
        ::GlisteningRuby::Pattern::Checkers.new { |i| copy_ivars(i) }
      end
    end

    # Gradient pattern builder DSL class
    class Gradient < Pattern
      def instance
        super
        ::GlisteningRuby::Pattern::Gradient.new { |i| copy_ivars(i) }
      end
    end

    # Stripe pattern builder DSL class
    class Stripe < Pattern
      def instance
        super
        ::GlisteningRuby::Pattern::Stripe.new { |i| copy_ivars(i) }
      end
    end
  end
end
