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
      t_min = []
      t_max = []

      ray.origin.to_a.zip(ray.direction.to_a).each do |origin, direction|
        next if direction.zero?

        min, max = axis_intersections(origin, direction)
        t_min << min
        t_max << max
      end
      [t_min.max, t_max.min].map { |t| Intersection.new(t, self) }
    end

    def axis_intersections(origin, direction)
      [(-1 - origin) / direction, (1 - origin) / direction].sort
    end
  end
end
