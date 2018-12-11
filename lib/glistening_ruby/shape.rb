# frozen_string_literal: true

require_relative 'base'
require_relative 'intersection'
require_relative 'intersections'
require_relative 'matrix'
require_relative 'material'
require_relative 'point'

module GlisteningRuby
  # Abstrace base shape
  class Shape < Base
    def initialize
      @transform = Matrix::IDENTITY
      @inverse = Matrix::IDENTITY
      @inverse_transpose = Matrix::IDENTITY
      @material = Material[]
      super
    end

    attr_accessor :material
    attr_reader :transform

    def transform=(transform)
      @transform = transform
      @inverse = transform.inverse
      @inverse_transpose = transform.submatrix(3, 3).inverse.transpose
    end

    def intersect(ray)
      Intersections.new(*intersections(ray.transform(@inverse)))
    end

    def normal_at(world_point)
      object_point = @inverse * world_point
      (@inverse_transpose * object_normal(object_point)).normalize
    end
  end
end
