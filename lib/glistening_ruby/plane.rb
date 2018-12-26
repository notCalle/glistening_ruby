# frozen_string_literal: true

require_relative 'shape'

module GlisteningRuby
  # A snakeless plane
  class Plane < Shape
    private

    def intersections(ray)
      return [] if close?(ray.direction.y, 0.0)

      [-ray.origin.y / ray.direction.y]
    end

    def object_normal(_point)
      Vector[0, 1, 0]
    end
  end
end
