# frozen_string_literal: true

require_relative 'quadratic'

module GlisteningRuby
  # Sphere
  class Sphere
    include Quadratic

    def self.[](*args)
      new(*args)
    end

    # O = ray.origin
    # D = ray.direction
    # C = sphere.origin = (0, 0, 0)
    # R = sphere.radius = 1.0
    #
    # |O + tD - C|^2 - R^2 = 0
    # |O + tD - 0|^2 - 1 = 0
    def intersect(ray)
      l = ray.origin - Point::ZERO
      d = ray.direction
      a = d.dot(d)
      b = 2 * d.dot(l)
      c = l.dot(l) - 1

      intersections = quadratic(a, b, c).map { |t| Intersection.new(t, self) }
      Intersections.new(*intersections)
    end
  end
end
