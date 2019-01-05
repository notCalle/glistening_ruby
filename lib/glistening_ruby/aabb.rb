# frozen_string_literal: true

require_relative 'point'
require_relative 'shape'

module GlisteningRuby
  # An axis aligned bounding box
  class AABB < Shape
    def self.from_shape(shape)
      new(shape.bounds).transform!(shape.transform)
    end

    def self.from_shapes(*shapes)
      new(shapes.flat_map { |shape| from_shape(shape).bounds })
    end

    def initialize(points)
      points = [Point::ZERO] if points.empty?

      super
      initialize_minmax(points)
    end

    def bounds
      [Point[*@min], Point[*@max]]
    end

    def largest_axis
      xyz = (Point[*@max] - Point[*@min]).xyz
      max = xyz.max
      %i[x y z].zip(xyz).find { |_, v| v == max }[0]
    end

    def transform!(matrix)
      points = [[@x_min, @y_min, @z_min],
                [@x_max, @y_min, @z_min],
                [@x_min, @y_max, @z_min],
                [@x_max, @y_max, @z_min],
                [@x_min, @y_min, @z_max],
                [@x_max, @y_min, @z_max],
                [@x_min, @y_max, @z_max],
                [@x_max, @y_max, @z_max]].map { |p| matrix * Point[*p] }
      initialize_minmax(points)
      self
    end

    private

    def initialize_minmax(points)
      @x_min, @x_max = points.map(&:x).minmax
      @y_min, @y_max = points.map(&:y).minmax
      @z_min, @z_max = points.map(&:z).minmax
      @min = [@x_min, @y_min, @z_min]
      @max = [@x_max, @y_max, @z_max]
    end

    def intersections(ray)
      t_min = -Float::INFINITY
      t_max = Float::INFINITY

      axes = @min.zip(@max, ray.origin, ray.direction)
      t_axes = axes.map { |min, max, o, d| axis_intersections(min, max, o, d) }
      t_axes.each do |min, max|
        t_min = min if min > t_min
        t_max = max if max < t_max
        return [] if t_min > t_max
      end

      [t_min, t_max]
    end

    def axis_intersections(min, max, origin, direction)
      [nonan_div(min - origin, direction),
       nonan_div(max - origin, direction)].sort
    end

    def nonan_div(numerator, denominator)
      return numerator / denominator unless numerator.zero? && denominator.zero?

      Float::INFINITY
    end
  end
end
