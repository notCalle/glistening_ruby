# frozen_string_literal: true

require_relative 'light/spherical'
require_relative 'color'
require_relative 'point'
require_relative 'translation'

module GlisteningRuby
  # A fake point light source without distance falloff
  class PointLight < Light::Spherical
    def initialize(position, intensity = Color::WHITE)
      self.transform = Translation.new(*position.xyz)
      super intensity
    end

    def intensity(point = Point::ZERO)
      super
    end
  end
end
