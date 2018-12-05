# frozen_string_literal: true

require_relative 'intersection'
require_relative 'intersections'
require_relative 'matrix'
require_relative 'point'
require_relative 'quadratic'

module GlisteningRuby
  # Sphere
  class Sphere
    include Quadratic

    def self.[](*args)
      new(*args)
    end

    def initialize
      @transform = Matrix::IDENTITY
    end

    attr_accessor :transform

    def intersect(ray)
      Intersections.new(*intersections(ray.transform(@transform.inverse)))
    end

    def normal_at(point)
      point - Point::ZERO
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

      quadratic(a, b, c).map { |t| Intersection.new(t, self) }
    end
  end
end
