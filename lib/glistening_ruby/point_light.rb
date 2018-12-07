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

    attr_reader :intensity, :position
  end
end
