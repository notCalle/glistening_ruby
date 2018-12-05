# frozen_string_literal: true

require_relative 'color'

module GlisteningRuby
  # A Phong material
  class Material
    def self.[](*args)
      new(*args)
    end

    def initialize
      @ambient = 0.1
      @color = Color[1, 1, 1]
      @diffuse = 0.9
      @shininess = 200
      @specular = 0.9
    end

    attr_accessor :ambient, :color, :diffuse, :shininess, :specular

    def ==(other)
      @ambient == other.ambient &&
        @color == other.color &&
        @diffuse == other.diffuse &&
        @shininess == other.shininess &&
        @specular == other.specular
    end

    def lighting(light, point, eyev, normalv)
      effective_color = @color * light.intensity
      lightv = (light.position - point).normalize
      ambient = effective_color * @ambient
      light_dot_normal = lightv.dot normalv
      return ambient if light_dot_normal.negative?

      ambient +
        diffuse_lighting(effective_color, light_dot_normal) +
        specular_lighting(light, lightv, normalv, eyev)
    end

    private

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
