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
      normal_to_world(object_normal(world_to_object(world_point)))
    end

    def world_to_object(world_point)
      world_point = parent.world_to_object(world_point) unless parent.nil?
      @inverse * world_point
    end

    def normal_to_world(normal)
      normal = (@inverse_transpose * normal).normalize
      return normal if parent.nil?

      parent.normal_to_world(normal)
    end

    protected

    attr_writer :parent
  end
end
