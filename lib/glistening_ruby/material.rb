# frozen_string_literal: true

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
  end
end
