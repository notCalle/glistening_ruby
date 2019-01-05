# frozen_string_literal: true

require_relative 'intersections'
require_relative 'material'
require_relative 'point'
require_relative 'transformable'

module GlisteningRuby
  # Abstract base shape
  class Shape < Transformable
    def initialize(*)
      @material = nil
      @cast_shadows = true
      @parent = nil
      super
    end

    def include?(other)
      other == self
    end

    attr_accessor :cast_shadows
    attr_reader :parent

    attr_writer :material
    def material
      @material ||= @parent&.material || Material[]
    end

    def bounds
      raise NotImplementedError
    end

    def cast_shadows?
      @cast_shadows
    end

    def intersect(ray)
      Intersections.for_object(self, *intersections(ray.transform(inverse)))
    end

    def normal_at(world_point, hit = nil)
      normal_to_world(object_normal(to_local(world_point), hit))
    end

    def to_local(world_point)
      world_point = parent.to_local(world_point) unless parent.nil?
      super(world_point)
    end

    def normal_to_world(normal)
      normal = (inverse_transpose * normal).normalize
      return normal if parent.nil?

      parent.normal_to_world(normal)
    end

    protected

    attr_writer :parent
  end
end
