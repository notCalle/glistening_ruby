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

      def direction(_point)
        raise NotImplementedError
      end

      def intensity(_point)
        raise NotImplementedError
      end

      def intersect(_ray)
        Intersections.new
      end
    end
  end
end
