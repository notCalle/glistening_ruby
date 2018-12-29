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
      @cast_shadows = true
      @parent = nil
      super
    end

    attr_accessor :cast_shadows, :material
    attr_reader :parent

    def cast_shadows?
      @cast_shadows
    end

    def intersect(ray)
      Intersections.for_object(self, *intersections(ray.transform(@inverse)))
    end

    def normal_at(world_point)
      object_point = @inverse * world_point
      (@inverse_transpose * object_normal(object_point)).normalize
    end

    def world_to_object(world_point)
      world_point = parent.world_to_object(world_point) unless parent.nil?
      @inverse * world_point
    end

    protected

    attr_writer :parent
  end
end
