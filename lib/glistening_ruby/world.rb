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

    def color_at(ray)
      hit = intersect(ray).hit
      return shade_hit(hit.prepare(ray)) if hit

      Color::BLACK
    end

    def intersect(ray)
      @objects.each.with_object(Intersections.new) do |object, intersections|
        intersections << object.intersect(ray)
      end
    end

    def light=(light)
      @lights = [light]
    end

    def shade_hit(comps)
      material = comps.object.material
      @lights.reduce(Color::BLACK) do |color, light|
        color + material.lighting(light, comps.point, comps.eyev, comps.normalv)
      end
    end

    def shadowed?(point, light = @lights[0])
      lightv = light.position - point
      distance = lightv.magnitude
      direction = lightv.normalize

      intersect(Ray[point, direction]).hit&.t&.< distance
    end

    def self.default # rubocop:disable Metrics/AbcSize
      World.new do |w|
        w.objects << Sphere.new do |s|
          s.material.color = [0.8, 1.0, 0.6]
          s.material.diffuse = 0.7
          s.material.specular = 0.2
        end
        w.objects << Sphere.new { |s| s.transform = Scaling.new(0.5, 0.5, 0.5) }
        w.lights << PointLight.new(Point[-10, 10, -10], Color::WHITE)
      end
    end
  end
end
