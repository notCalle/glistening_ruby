# frozen_string_literal: true

module GlisteningRuby
  # Prepared computations for a ray at an intersection
  class Computations
    def initialize(intersection, ray)
      initialize_intersection(intersection)
      initialize_ray(ray)

      @inside = @normalv.dot(@eyev).negative?
      @normalv = -@normalv if @inside
      @point += @normalv * EPSILON
    end

    def inside?
      @inside
    end

    attr_reader :eyev, :normalv, :object, :point, :reflectv, :t

    private

    def initialize_intersection(intersection)
      @t = intersection.t
      @object = intersection.object
    end

    def initialize_ray(ray)
      @point = ray.position(@t)
      @eyev = -ray.direction
      @normalv = @object.normal_at(@point)
      @reflectv = ray.direction.reflect(@normalv)
    end
  end
end
