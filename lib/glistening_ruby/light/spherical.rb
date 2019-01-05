# frozen_string_literal: true

require_relative 'base'

module GlisteningRuby
  module Light
    # A spherically radiating point light source
    class Spherical < Base
      def initialize(*)
        super
        @falloff ||= 0.0
      end

      def direction(point)
        point_to_light(point).normalize
      end

      def distance(point)
        point_to_light(point).magnitude
      end

      attr_accessor :falloff

      def intensity(point)
        return @intensity if falloff.zero?

        d = point_to_light(point)
        @intensity / (1 + d.dot(d) * falloff)
      end

      def position
        cache[:position] ||= transform * Point[0, 0, 0]
      end

      private

      def point_to_light(point)
        (position - point)
      end
    end
  end
end
