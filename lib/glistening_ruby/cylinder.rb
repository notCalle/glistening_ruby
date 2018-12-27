# frozen_string_literal: true

require_relative 'quadratic'
require_relative 'shape'

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
      quadratic(a, b, c).select do |t|
        y = o.y + t * d.y
        y > @minimum && y < @maximum
      end
    end

    def endcap_intersections(ray) # rubocop:disable Metrics/AbcSize
      o = ray.origin
      d = ray.direction
      return [] if !closed? || close?(d.y, 0)

      xs = [@minimum, @maximum].map { |y| (y - o.y) / d.y }
      xs.select { |t| (o.x + t * d.x)**2 + (o.z + t * d.z)**2 <= 1 }
    end

    def object_normal(point)
      Vector[point.x, 0, point.z]
    end
  end
end
