# frozen_string_literal: true

require_relative 'intersection'
require_relative 'intersections'
require_relative 'matrix'
require_relative 'material'
require_relative 'point'
require_relative 'transformable'

module GlisteningRuby
  # Abstract base shape
  class Shape < Transformable
    def initialize
      @material = Material[]
      super
    end

    attr_accessor :material

    def intersect(ray)
      Intersections.new(*intersections(ray.transform(@inverse)))
    end

    def normal_at(world_point)
      object_point = @inverse * world_point
      (@inverse_transpose * object_normal(object_point)).normalize
    end
  end
end
