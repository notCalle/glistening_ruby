# frozen_string_literal: true

require_relative 'base'
require_relative 'color'

module GlisteningRuby
  # A Phong material
  class Material < Base
    def initialize
      @ambient = 0.1
      @color = Color[1, 1, 1]
      @diffuse = 0.9
      @reflective = 0.0
      @refractive_index = 1.0
      @shininess = 200
      @specular = 0.9
      @transparency = 0.0
      super
    end

    attr_accessor :ambient, :diffuse, :pattern, :reflective
    attr_accessor :refractive_index, :shininess, :specular, :transparency

    attr_reader :color
    def color=(new_color)
      new_color = Color[*new_color] if new_color.is_a?(Array)
      @color = new_color
    end

    def ==(other)
      @ambient == other.ambient &&
        @color == other.color &&
        @diffuse == other.diffuse &&
        @shininess == other.shininess &&
        @specular == other.specular
    end

    def lighting(object, light, # rubocop:disable Metrics/ParameterLists
                 point, eyev, normalv, in_shadow = false)
      effective_color = color_at(object, point) * light.intensity
      ambient = effective_color * @ambient
      return ambient if in_shadow

      lightv = (light.position - point).normalize
      light_dot_normal = lightv.dot normalv
      return ambient if light_dot_normal.negative?

      ambient +
        diffuse_lighting(effective_color, light_dot_normal) +
        specular_lighting(light, lightv, normalv, eyev)
    end

    private

    def color_at(object, point)
      @pattern.nil? ? @color : @pattern.color_at_object(object, point)
    end

    def diffuse_lighting(effective_color, light_dot_normal)
      effective_color * @diffuse * light_dot_normal
    end

    def specular_lighting(light, lightv, normalv, eyev)
      reflectv = (-lightv).reflect(normalv)
      reflect_dot_eye = reflectv.dot eyev
      return Color::BLACK unless reflect_dot_eye.positive?

      light.intensity * @specular * reflect_dot_eye**@shininess
    end
  end
end
