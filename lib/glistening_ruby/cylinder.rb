# frozen_string_literal: true

require_relative 'quadratic'
require_relative 'shape'

module GlisteningRuby
  # A cylinder
  class Cylinder < Shape
    include Quadratic

    private

    def intersections(ray) # rubocop:disable Metrics/AbcSize
      o = ray.origin
      d = ray.direction
      a = d.x**2 + d.z**2
      return [] if close?(a, 0)

      b = 2 * (o.x * d.x + o.z * d.z)
      c = o.x**2 + o.z**2 - 1
      quadratic(a, b, c)
    end

    def object_normal(point)
      Vector[point.x, 0, point.z]
    end
  end
end
