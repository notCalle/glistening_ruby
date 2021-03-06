# frozen_string_literal: true

require_relative 'point'
require_relative 'quadratic'
require_relative 'shape'

module GlisteningRuby
  # Sphere
  class Sphere < Shape
    include Quadratic

    def bounds
      [Point[-1, -1, -1],
       Point[1, 1, 1]]
    end

    private

    # O = ray.origin
    # D = ray.direction
    # C = sphere.origin = (0, 0, 0)
    # R = sphere.radius = 1.0
    #
    # |O + tD - C|^2 - R^2 = 0
    # |O + tD - 0|^2 - 1 = 0
    def intersections(ray)
      l = ray.origin - Point::ZERO
      d = ray.direction
      a = d.dot(d)
      b = 2 * d.dot(l)
      c = l.dot(l) - 1

      quadratic(a, b, c)
    end

    def object_normal(point, _hit)
      point - Point::ZERO
    end
  end
end
