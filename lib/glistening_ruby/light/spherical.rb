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
        return @intensity if falloff.zero?

        d = point_to_light(point)
        @intensity / (1 + d.dot(d) * falloff)
      end

      def position
        cache[:position] ||= object_to_world Point[0, 0, 0]
      end

      def visibility(point, world, samples)
        samples = 1 if samples.zero? || @radius.zero?
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
