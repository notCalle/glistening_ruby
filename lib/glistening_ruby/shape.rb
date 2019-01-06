# frozen_string_literal: true

require_relative 'aabb'
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
      super
    end

    def include?(other)
      other == self
    end

    attr_accessor :cast_shadows

    attr_writer :material
    def material
      @material ||= @parent&.material || Material[]
    end

    def aabb
      cache[:aabb] ||= AABB.from_shape(self)
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

    # Find the normal at a point on the object
    #
    # :call-seq:
    #   normal_at(world_point) => world_vector
    #
    def normal_at(point, hit = nil)
      normal_to_world(object_normal(world_to_object(point), hit))
    end
  end
end
