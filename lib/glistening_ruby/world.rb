# frozen_string_literal: true

require_relative 'base'
require_relative 'color'
require_relative 'container'
require_relative 'intersections'
require_relative 'lights'
require_relative 'point'
require_relative 'point_light'
require_relative 'sphere'

module GlisteningRuby
  # The whole world
  class World < Base
    RECURSION_LIMIT = 5

    def initialize
      @objects = []
      super
    end

    attr_accessor :objects
    attr_writer :light

    def lights
      cache[:lights] ||= find_lights
    end

    def <<(thing)
      reset_cache
      @objects << thing
      self
    end

    def color_at(ray, ttl = RECURSION_LIMIT)
      hit = intersect(ray).hit
      return shade_hit(hit.prepare(ray), ttl) if hit

      Color::BLACK
    end

    def intersect(ray)
      @objects.each.with_object(Intersections.new) do |object, result|
        result << object.intersect(ray)
      end
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
      return Color::BLACK if comps.total_internal_reflection?

      refract_ray = Ray.new(comps.under_point, comps.refractv)
      color_at(refract_ray, ttl - 1) * transparency
    end

    def phong_shaded_color(comps)
      eyev = comps.eyev
      point = comps.point
      object = comps.object
      material = object.material
      normalv = comps.normalv
      lights.reduce(Color::BLACK) do |color, light|
        shadow = shadowed?(point, light)
        color + material.lighting(object, light, point, eyev, normalv, shadow)
      end
    end

    def shade_hit(comps, ttl = RECURSION_LIMIT)
      surface = phong_shaded_color(comps)
      reflected = reflected_color(comps, ttl)
      refracted = refracted_color(comps, ttl)
      return surface + reflected + refracted unless comps.fresnel?

      reflectance = comps.schlick
      transmittance = 1 - reflectance
      surface + reflected * reflectance + refracted * transmittance
    end

    def shadowed?(point, light = lights[0])
      distance = light.distance(point)
      direction = light.direction(point)

      intersect(ShadowRay[point, direction]).hit&.t&.< distance
    end

    def self.default
      World.new do |w|
        w << Sphere.new do |s|
          s.material.color = [0.8, 1.0, 0.6]
          s.material.diffuse = 0.7
          s.material.specular = 0.2
        end
        w << Sphere.new { |s| s.transform = Scaling.new(0.5, 0.5, 0.5) }
        w << PointLight.new(Point[-10, 10, -10], Color::WHITE)
      end
    end

    private

    def find_lights(group = @objects)
      return [@light] unless @light.nil?

      queue = group.dup
      queue.each.with_object([]) do |object, result|
        queue.concat object.to_a if object.respond_to? :to_a
        result << object if object.is_a? Light::Base
      end
    end
  end
end
