# frozen_string_literal: true

require_relative 'quadratic'

module GlisteningRuby
  # Sphere
  class Sphere
    include Quadratic

    def self.[](*args)
      new(*args)
    end

    def initialize
      @origin = Point[0, 0, 0]
      @radius = 1.0
      @radius_squared = @radius * @radius
    end

    def to_s
      "#<#{self.class}: ·#{@origin} r=#{@radius}>"
    end

    attr_reader :origin, :radius

    # O = ray.origin
    # D = ray.direction
    # C = sphere.origin
    # R = sphere.radius
    #
    # |O + tD - C|^2 - R^2 = 0
    def intersect(ray)
      sphere_to_ray = ray.origin - @origin
      a = ray.direction.dot(ray.direction)
      b = 2 * ray.direction.dot(sphere_to_ray)
      c = sphere_to_ray.dot(sphere_to_ray) - @radius_squared

      intersections = quadratic(a, b, c).map { |t| Intersection.new(t, self) }
      Intersections.new(*intersections)
    end
  end
end
