# frozen_string_literal: true

require_relative 'point'
require_relative 'quadratic'
require_relative 'shape'
require_relative 'vector'

module GlisteningRuby
  # A cylinder
  class Cylinder < Shape
    include Quadratic

    def initialize(*)
      @minimum = -Float::INFINITY
      @maximum = Float::INFINITY
      @closed = false
      super
    end

    attr_accessor :maximum, :minimum
    attr_writer :closed

    def bounds
      [Point[-1, @minimum, -1],
       Point[1, @maximum, 1]]
    end

    def closed?
      @closed
    end

    private

    def intersections(ray)
      cylinder_intersections(ray).concat endcap_intersections(ray)
    end

    def cylinder_intersections(ray) # rubocop:disable Metrics/AbcSize
      o = ray.origin
      d = ray.direction
      a = d.x**2 + d.z**2
      return [] if close?(a, 0)

      b = 2 * (o.x * d.x + o.z * d.z)
      c = o.x**2 + o.z**2 - 1
      quadratic(a, b, c).select { |t| inside?(o.y + t * d.y) }
    end

    def endcap_intersections(ray) # rubocop:disable Metrics/AbcSize
      o = ray.origin
      d = ray.direction
      return [] if !closed? || close?(d.y, 0)

      xs = [@minimum, @maximum].map { |y| (y - o.y) / d.y }
      xs.select { |t| (o.x + t * d.x)**2 + (o.z + t * d.z)**2 <= 1 }
    end

    def object_normal(point)
      return Vector[0, 1, 0] if point.y >= @maximum - EPSILON
      return Vector[0, -1, 0] if point.y <= @minimum + EPSILON

      Vector[point.x, 0, point.z]
    end

    def inside?(y_c)
      y_c > @minimum && y_c < @maximum
    end
  end
end
