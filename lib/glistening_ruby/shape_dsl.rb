# frozen_string_literal: true

require 'glistening_ruby'
require_relative 'dsl/cone'
require_relative 'dsl/cylinder'
require_relative 'dsl/group'
require_relative 'dsl/mesh'
require_relative 'dsl/shape'

module GlisteningRuby
  # Top level shape DSL module
  module ShapeDSL
    def self.cone(name, &block)
      DSL::Cone.define(name, klass: DSL::Shape, &block)
    end

    def self.cube(name, &block)
      DSL::Cube.define(name, klass: DSL::Shape, &block)
    end

    def self.cylinder(name, &block)
      DSL::Cylinder.define(name, klass: DSL::Shape, &block)
    end

    def self.group(name, &block)
      DSL::Group.define(name, klass: DSL::Shape, &block)
    end

    def self.mesh(name, &block)
      DSL::Mesh.define(name, klass: DSL::Shape, &block)
    end

    def self.plane(name, &block)
      DSL::Plane.define(name, klass: DSL::Shape, &block)
    end

    def self.sphere(name, &block)
      DSL::Sphere.define(name, klass: DSL::Shape, &block)
    end
  end
end
