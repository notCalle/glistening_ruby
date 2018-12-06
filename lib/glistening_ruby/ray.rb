# frozen_string_literal: true

module GlisteningRuby
  # A ray to be cast into the world
  class Ray
    def self.[](*args)
      new(*args)
    end

    def initialize(origin, direction)
      @origin = origin
      @direction = direction
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
end
