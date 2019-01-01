# frozen_string_literal: true

require_relative 'point'
require_relative 'quadratic'
require_relative 'shape'
require_relative 'vector'

module GlisteningRuby
  # A double-napped come
  class Cone < Shape
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
      xz_max = [@minimum.abs, @maximum.abs].max
      [Point[-xz_max, @minimum, -xz_max],
       Point[xz_max, @maximum, xz_max]]
    end

    def closed?
      @closed
    end

    def object_normal(point, _hit) # rubocop:disable Metrics/AbcSize
      return Vector[0, 1, 0] if point.y >= @maximum - EPSILON
      return Vector[0, -1, 0] if point.y <= @minimum + EPSILON

      y = Math.sqrt(point.x**2 + point.z**2)
      Vector[point.x, point.y.positive? ? -y : y, point.z]
    end

    private

    def intersections(ray)
      cone_intersections(ray).concat endcap_intersections(ray)
    end

    def cone_intersections(ray) # rubocop:disable Metrics/AbcSize
      o = ray.origin
      d = ray.direction
      a = d.x**2 - d.y**2 + d.z**2
      b = 2 * (o.x * d.x - o.y * d.y + o.z * d.z)
      return [] if close?(a, 0) && close?(b, 0)

      c = o.x**2 - o.y**2 + o.z**2
      return [-0.5 * c / b] if close?(a, 0)

      quadratic(a, b, c).select { |t| inside?(o.y + t * d.y) }
    end

    def endcap_intersections(ray) # rubocop:disable Metrics/AbcSize
      o = ray.origin
      d = ray.direction
      return [] if !closed? || close?(d.y, 0)

      xs = [@minimum, @maximum].map { |y| [y, (y - o.y) / d.y] }
      xs = xs.select { |y, t| (o.x + t * d.x)**2 + (o.z + t * d.z)**2 <= y**2 }
      xs.map { |_, t| t }
    end

    def inside?(y_c)
      y_c > @minimum && y_c < @maximum
    end
  end
end
