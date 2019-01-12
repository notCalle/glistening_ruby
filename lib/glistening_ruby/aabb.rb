# frozen_string_literal: true

require_relative 'point'
require_relative 'base'

module GlisteningRuby
  # An axis aligned bounding box
  class AABB < Base # rubocop:disable Metrics/ClassLength
    def self.from_shape(shape)
      new(shape.bounds).transform!(shape.transform)
    end

    def self.from_shapes(shapes)
      new(shapes.flat_map { |shape| shape.aabb.bounds })
    end

    def initialize(points)
      points = [Point::ZERO] if points.empty?

      super
      initialize_minmax(points)
    end

    def area
      cache[:area] ||= lambda do
        x = @x_max - @x_min
        y = @y_max - @y_min
        z = @z_max - @z_min
        2 * (x * y + x * z + y * z)
      end.call
    end

    def bounds
      cache[:bounds] ||= [Point[@x_min, @y_min, @z_min],
                          Point[@x_max, @y_max, @z_max]]
    end

    def center
      cache[:center] ||= lambda do
        center = [
          (@x_min + @x_max) / 2,
          (@y_min + @y_max) / 2,
          (@z_min + @z_max) / 2
        ].map { |c| c.nan? ? 0 : c }
        Point[*center]
      end.call
    end

    def largest_axis
      cache[:largest_axis] ||= lambda do
        xyz = (Point[*@max] - Point[*@min]).xyz
        max = xyz.max
        %i[x y z].zip(xyz).find { |_, v| v == max }[0]
      end.call
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

    def intersect_bounds?(ray)
      !intersections(ray).empty?
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

    private

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/CyclomaticComplexity
    # rubocop:disable Metrics/MethodLength
    def initialize_minmax(points)
      reset_cache
      x_min = Float::INFINITY
      x_max = -Float::INFINITY
      y_min = Float::INFINITY
      y_max = -Float::INFINITY
      z_min = Float::INFINITY
      z_max = -Float::INFINITY
      points.each do |p|
        x, y, z = p.xyz
        x_min = x if x < x_min
        x_max = x if x > x_max
        y_min = y if y < y_min
        y_max = y if y > y_max
        z_min = z if z < z_min
        z_max = z if z > z_max
      end
      @x_min = x_min
      @x_max = x_max
      @y_min = y_min
      @y_max = y_max
      @z_min = z_min
      @z_max = z_max
      @min = [x_min, y_min, z_min]
      @max = [x_max, y_max, z_max]
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/CyclomaticComplexity
    # rubocop:enable Metrics/MethodLength

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
