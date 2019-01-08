# frozen_string_literal: true

require_relative '../lights'
require_relative 'color'
require_relative 'transformable'

module GlisteningRuby
  module DSL
    # Light builder DSL base class
    class Light < Transformable
      include ColorSpace

      def instance
        super
        @color ||= grey 1 # rubocop:disable Naming/MemoizedInstanceVariableName
      end

      def point(p_x, p_y, p_z)
        @point = ::GlisteningRuby::Point[p_x, p_y, p_z]
      end

      def color(color)
        color = Color[color] if color.is_a? Symbol
        @color = color
      end

      private

      def ivars
        instance_variables - %i[@color]
      end
    end

    # Parallel light builder DSL class
    class ParallelLight < Light
      def instance
        super
        ::GlisteningRuby::Light::Parallel.new(@color) { |i| copy_ivars(i) }
      end
    end

    # Spherical light builder DSL class
    class SphericalLight < Light
      def instance
        super
        ::GlisteningRuby::Light::Spherical.new(@color) { |i| copy_ivars(i) }
      end
    end
  end
end
