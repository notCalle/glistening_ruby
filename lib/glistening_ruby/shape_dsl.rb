# frozen_string_literal: true

require 'glistening_ruby'
require_relative 'dsl/cone'
require_relative 'dsl/csg'
require_relative 'dsl/cylinder'
require_relative 'dsl/group'
require_relative 'dsl/mesh'
require_relative 'dsl/shape'

module GlisteningRuby
  # Top level shape DSL module
  module ShapeDSL
    # Named object factory definition
    def self.cone(name, &block)
      DSL::Cone.define(name, klass: DSL::Shape, &block)
    end

    def self.cube(name, &block)
      DSL::Cube.define(name, klass: DSL::Shape, &block)
    end

    def self.cylinder(name, &block)
      DSL::Cylinder.define(name, klass: DSL::Shape, &block)
    end

    def self.difference(name, &block)
      DSL::Difference.define(name, klass: DSL::Shape, &block)
    end

    def self.group(name, &block)
      DSL::Group.define(name, klass: DSL::Shape, &block)
    end

    def self.intersection(name, &block)
      DSL::Intersection.define(name, klass: DSL::Shape, &block)
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

    def self.union(name, &block)
      DSL::Union.define(name, klass: DSL::Shape, &block)
    end

    # Anonymous object creation
    def cone(*args, &block)
      callback DSL::Cone.setup(*args, &block)
    end

    def cube(*args, &block)
      callback DSL::Cube.setup(*args, &block)
    end

    def cylinder(*args, &block)
      callback DSL::Cylinder.setup(*args, &block)
    end

    def difference(*args, &block)
      callback DSL::Difference.setup(*args, &block)
    end

    def group(*args, &block)
      callback DSL::Group.setup(*args, &block)
    end

    def intersection(*args, &block)
      callback DSL::Intersection.setup(*args, &block)
    end

    def mesh(*args, &block)
      callback DSL::Mesh.setup(*args, &block)
    end

    def plane(*args, &block)
      callback DSL::Plane.setup(*args, &block)
    end

    def sphere(*args, &block)
      callback DSL::Sphere.setup(*args, &block)
    end

    def union(*args, &block)
      callback DSL::Union.setup(*args, &block)
    end
  end
end
