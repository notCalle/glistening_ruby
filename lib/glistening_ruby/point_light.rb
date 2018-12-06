# frozen_string_literal: true

module GlisteningRuby
  # A point light source
  class PointLight
    def self.[](*args)
      new(*args)
    end

    def initialize(position, intensity)
      @position = position
      @intensity = intensity
    end

    attr_reader :intensity, :position
  end
end
