# frozen_string_literal: true

module GlisteningRuby
  # Prepared computations for a ray at an intersection
  class Computations
    def initialize(intersection, ray)
      @t = intersection.t
      @object = intersection.object
      @point = ray.position(@t)
      @eyev = -ray.direction
      @normalv = @object.normal_at(@point)
    end

    attr_accessor :eyev, :normalv, :object, :point, :t
  end
end
