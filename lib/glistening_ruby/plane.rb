# frozen_string_literal: true

require_relative 'point'
require_relative 'shape'
require_relative 'vector'

module GlisteningRuby
  # A snakeless plane
  class Plane < Shape
    def bounds
      [Point[-Float::INFINITY, 0, Float::INFINITY],
       Point[Float::INFINITY, 0, Float::INFINITY]]
    end

    private

    def intersections(ray)
      return [] if close?(ray.direction.y, 0.0)

      [-ray.origin.y / ray.direction.y]
    end

    def object_normal(_point, _hit)
      Vector[0, 1, 0]
    end
  end
end
