# frozen_string_literal: true

require_relative 'base'
require_relative 'color'
require_relative 'intersections'
require_relative 'point'
require_relative 'point_light'
require_relative 'sphere'

module GlisteningRuby
  # The whole world
  class World < Base
    def initialize
      @objects = []
      @lights = []
      super
    end

    attr_accessor :lights, :objects

    def intersect(ray)
      @objects.each.with_object(Intersections.new) do |object, intersections|
        intersections << object.intersect(ray)
      end
    end
  end

  World::DEFAULT = World.new do |w|
    w.objects << Sphere.new do |s|
      s.material.color = [0.8, 1.0, 0.6]
      s.material.diffuse = 0.7
      s.material.specular = 0.2
    end
    w.objects << Sphere.new { |s| s.transform = Scaling.new(0.5, 0.5, 0.5) }
    w.lights << PointLight.new(Point[-10, 10, -10], Color::WHITE)
  end
end
