# frozen_string_literal: true

require_relative 'intersection'
require_relative 'intersections'
require_relative 'matrix'
require_relative 'material'
require_relative 'point'
require_relative 'shape'

module GlisteningRuby
  # An axis aligned unit Cube
  class Cube < Shape
    private

    def intersections(ray)
      t_min = -Float::INFINITY
      t_max = Float::INFINITY

      ray.origin.zip(ray.direction).each do |origin, direction|
        min, max = axis_intersections(origin, direction)
        t_min = min if min > t_min
        t_max = max if max < t_max
        return [] if t_min > t_max
      end

      [t_min, t_max].map { |t| Intersection.new(t, self) }
    end

    def axis_intersections(origin, direction)
      [nonan_div(-1 - origin, direction),
       nonan_div(1 - origin, direction)].sort
    end

    def nonan_div(numerator, denominator)
      return numerator / denominator unless numerator.zero? && denominator.zero?

      Float::INFINITY
    end

    def object_normal(point) # rubocop:disable Metrics/AbcSize
      max = point.map(&:abs).max
      return Vector[point.x, 0, 0] if close?(point.x.abs, max)
      return Vector[0, point.y, 0] if close?(point.y.abs, max)
      return Vector[0, 0, point.z] if close?(point.z.abs, max)
    end
  end
end
