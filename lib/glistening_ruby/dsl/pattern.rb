# frozen_string_literal: true

require_relative 'color'
require_relative 'transformable'
require_relative '../patterns'

module GlisteningRuby
  module DSL
    # Pattern builder DSL class
    class Pattern < Transformable
      include ColorSpace

      def color(color)
        color = Color[color] if color.is_a? Symbol
        pigments << color
      end

      def pattern(name, *args, &block)
        pigments << Pattern[name, *args, &block]
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

    # Perturbation pattern builder DSL class
    class Perturb < Pattern
      def instance
        super
        ::GlisteningRuby::Pattern::Perturb.new { |i| copy_ivars(i) }
      end
    end

    # Radial gradient pattern builder DSL class
    class Radial < Pattern
      def instance
        super
        ::GlisteningRuby::Pattern::Radial.new { |i| copy_ivars(i) }
      end
    end

    # Ring pattern builder DSL class
    class Ring < Pattern
      def instance
        super
        ::GlisteningRuby::Pattern::Ring.new { |i| copy_ivars(i) }
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
