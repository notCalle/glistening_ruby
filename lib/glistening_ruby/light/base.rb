# frozen_string_literal: true

require_relative '../color'
require_relative '../intersections'
require_relative '../transformable'

module GlisteningRuby
  module Light
    # An abstract light source
    class Base < Transformable
      def initialize(intensity = Color::WHITE)
        @intensity = intensity
        super
      end

      def intersect(_ray)
        Intersections.new
      end

      def visibility(point, world, _samples)
        t = world.intersect(ShadowRay[point, shadow_direction(point)]).hit&.t
        in_shadow = t&.< distance(point)
        in_shadow ? 0.0 : 1.0
      end

      private

      def shadow_direction(point)
        direction(point)
      end
    end
  end
end
