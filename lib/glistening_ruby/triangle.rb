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
      super
    end

    attr_reader :e1, :e2, :normal, :v1, :v2, :v3

    private

    def object_normal(_point)
      @normal
    end

    def intersections(ray)
      ray_x_e2 = ray.direction.cross @e2
      determinant = @e1.dot ray_x_e2
      return [] if close?(determinant, 0)

      f = 1.0 / determinant
      v1_to_origin = ray.origin - @v1
      u = f * (v1_to_origin.dot ray_x_e2)
      return [] unless u.between?(0, 1)

      [0] # fake
    end
  end
end
