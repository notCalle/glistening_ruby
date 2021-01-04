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

    attr_accessor :ambient, :diffuse, :pattern, :reflective, :refractive_index, :shininess, :specular, :transparency

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

    def reflective?
      !reflective.zero?
    end

    def transparent?
      !transparency.zero?
    end

    def fresnel?
      reflective? && transparent?
    end

    # rubocop:disable Metrics/ParameterLists
    def lighting(object, light, point, eyev, normalv, lit = 1.0)
      effective_color = color_at(object, point) * light.intensity(point)
      color = effective_color * @ambient
      return color if lit.zero?

      lightv = light.direction(point)
      light_dot_normal = lightv.dot(normalv)
      return color if object.cast_shadows? && light_dot_normal.negative?

      color += diffuse_lighting(effective_color, light_dot_normal) * lit
      return color if light_dot_normal.negative?

      color + specular_lighting(point, light, lightv, normalv, eyev) * lit
    end
    # rubocop:enable Metrics/ParameterLists

    private

    def color_at(object, point)
      @pattern.nil? ? @color : @pattern.color_at_object(object, point)
    end

    def diffuse_lighting(effective_color, light_dot_normal)
      effective_color * @diffuse * light_dot_normal.abs
    end

    def specular_lighting(point, light, lightv, normalv, eyev)
      reflectv = (-lightv).reflect(normalv)
      reflect_dot_eye = reflectv.dot eyev
      return Color::BLACK unless reflect_dot_eye.positive?

      light.intensity(point) * @specular * reflect_dot_eye**@shininess
    end
  end
end
