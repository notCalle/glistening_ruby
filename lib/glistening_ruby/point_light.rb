# frozen_string_literal: true

require_relative 'base'
require_relative 'color'

module GlisteningRuby
  # A point light source
  class PointLight < Base
    def initialize(position, intensity = Color::WHITE)
      @position = position
      @intensity = intensity
      super
    end

    def direction(point)
      point_to_light(point).normalize
    end

    def distance(point)
      point_to_light(point).magnitude
    end

    attr_reader :intensity, :position

    private

    def point_to_light(point)
      position - point
    end
  end
end
