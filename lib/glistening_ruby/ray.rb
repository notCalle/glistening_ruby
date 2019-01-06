# frozen_string_literal: true

require_relative 'base'

module GlisteningRuby
  # A ray to be cast into the world
  class Ray < Base
    def initialize(origin, direction)
      @origin = origin
      @direction = direction
      super
      freeze
    end

    def to_s
      "#<#{self.class}: ·#{origin} →#{direction}>"
    end
    alias inspect to_s

    attr_reader :direction, :origin

    def position(time)
      @origin + @direction * time
    end

    def transform(matrix)
      self.class.new(matrix * @origin, matrix * @direction)
    end
  end

  class ShadowRay < Ray; end
end
