# frozen_string_literal: true

require_relative '../vector'
require_relative 'base'

module GlisteningRuby
  module Light
    # A spherically radiating point light source
    class Spherical < Base
      def initialize(*)
        super
        @falloff ||= 0.0
        @radius ||= 0.0
      end

      def direction(point)
        point_to_light(point).normalize
      end

      def distance(point)
        point_to_light(point).magnitude
      end

      attr_accessor :falloff, :radius

      def intensity(point)
        return @intensity if @falloff.zero?

        d = distance(point)
        @intensity * (@falloff / (@falloff + d))**2
      end

      def position
        cache[:position] ||= object_to_world Point[0, 0, 0]
      end

      def visibility(point, world, ttl)
        return super if @radius.zero?

        samples = (3**ttl * @radius / distance(point)).ceil
        1.upto(samples).map { super }.sum / samples
      end

      private

      def point_to_light(point)
        (position - point)
      end

      def shadow_direction(point)
        unless @radius.zero?
          loop do
            offset = Vector.random
            next if offset.magnitude > 1.0

            break point += offset * @radius
          end
        end
        point_to_light(point).normalize
      end
    end
  end
end
