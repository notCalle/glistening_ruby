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

    def intersections(ray) # rubocop:disable Metrics/AbcSize
      t_min = -Float::INFINITY
      t_max = Float::INFINITY

      ray.origin.to_a.zip(ray.direction.to_a).each do |origin, direction|
        min, max = axis_intersections(origin, direction)
        t_min = min if min > t_min
        t_max = max if max < t_max
      end
      return [] if t_min > t_max

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
  end
end
