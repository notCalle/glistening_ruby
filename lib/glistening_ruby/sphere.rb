# frozen_string_literal: true

module GlisteningRuby
  # Sphere
  class Sphere
    def self.[](*args)
      new(*args)
    end

    def initialize
      @origin = Point[0, 0, 0]
      @radius = 1.0
    end

    def to_s
      "#<#{self.class}: ·#{@origin} r=#{@radius}>"
    end

    attr_reader :origin, :radius

    def intersect(_ray)
      raise NotImplementedError
    end
  end
end
