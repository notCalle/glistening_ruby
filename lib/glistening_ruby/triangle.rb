# frozen_string_literal: true

require_relative 'point'
require_relative 'shape'

module GlisteningRuby
  # A triangle
  class Triangle < Shape
    def initialize(vertex1, vertex2, vertex3)
      @v1 = vertex1
      @v2 = vertex2
      @v3 = vertex3
      @e1 = @v2 - @v1
      @e2 = @v3 - @v1
      @normal = (@e2.cross @e1).normalize
      initialize_bounds(@v1, @v2, @v3)
      super
    end

    attr_reader :bounds, :e1, :e2, :normal, :v1, :v2, :v3

    private

    def initialize_bounds(*points)
      x_min, x_max = points.map(&:x).minmax
      y_min, y_max = points.map(&:y).minmax
      z_min, z_max = points.map(&:z).minmax
      @bounds = [Point[x_min, y_min, z_min],
                 Point[x_max, y_max, z_max]]
    end

    def object_normal(_point, _hit)
      @normal
    end

    def intersections(ray) # rubocop:disable /AbcSize, Metrics/MethodLength, Metrics/
      ray_x_e2 = ray.direction.cross @e2
      determinant = @e1.dot ray_x_e2
      return [] if close?(determinant, 0)

      f = 1.0 / determinant
      v1_to_origin = ray.origin - @v1
      @u = f * (v1_to_origin.dot ray_x_e2)
      return [] unless @u.between?(0, 1)

      origin_x_e1 = v1_to_origin.cross @e1
      @v = f * (ray.direction.dot origin_x_e1)
      return [] if @v.negative? || (@u + @v) > 1

      [f * (@e2.dot origin_x_e1)]
    end
  end
end
