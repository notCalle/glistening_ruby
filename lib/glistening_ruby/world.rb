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
    RECURSION_LIMIT = 5

    def initialize
      @objects = []
      @lights = []
      super
    end

    attr_accessor :lights, :objects

    def <<(thing)
      if thing.is_a?(PointLight)
        @lights << thing
      else
        @objects << thing
      end
      self
    end

    def color_at(ray, ttl = RECURSION_LIMIT)
      hit = intersect(ray).hit
      return shade_hit(hit.prepare(ray), ttl) if hit

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

    def reflected_color(comps, ttl = RECURSION_LIMIT)
      reflective = comps.object.material.reflective
      return Color::BLACK if ttl.zero? || reflective.zero?

      reflect_ray = Ray.new(comps.point, comps.reflectv)
      color_at(reflect_ray, ttl - 1) * reflective
    end

    def refracted_color(comps, ttl = RECURSION_LIMIT)
      transparency = comps.object.material.transparency
      return Color::BLACK if ttl.zero? || transparency.zero?
    end

    def shade_hit(comps, ttl = RECURSION_LIMIT)
      eyev = comps.eyev
      point = comps.point
      object = comps.object
      material = object.material
      normalv = comps.normalv
      @lights.reduce(reflected_color(comps, ttl)) do |color, light|
        shadow = shadowed?(point, light)
        color + material.lighting(object, light, point, eyev, normalv, shadow)
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
