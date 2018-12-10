# frozen_string_literal: true

require_relative 'base'
require_relative 'intersection'
require_relative 'intersections'
require_relative 'matrix'
require_relative 'material'
require_relative 'point'
require_relative 'quadratic'

module GlisteningRuby
  # Sphere
  class Sphere < Base
    include Quadratic

    def initialize
      @transform = Matrix::IDENTITY
      @inverse = Matrix::IDENTITY
      @inverse_transpose = Matrix::IDENTITY
      @material = Material[]
      super
    end

    attr_accessor :material
    attr_reader :transform

    def transform=(transform)
      @transform = transform
      @inverse = transform.inverse
      @inverse_transpose = transform.submatrix(3, 3).inverse.transpose
    end

    def intersect(ray)
      Intersections.new(*intersections(ray.transform(@inverse)))
    end

    def normal_at(world_point)
      object_point = @inverse * world_point
      object_normal = object_point - Point::ZERO
      world_normal = @inverse_transpose * object_normal
      world_normal.normalize
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
