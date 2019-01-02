# frozen_string_literal: true

require 'glistening_ruby'
require_relative 'dsl/material'
require_relative 'dsl/mesh'
require_relative 'dsl/scene'
require_relative 'dsl/shape'

module GlisteningRuby
  # Top level Domain Speficic Language module
  module BaseDSL
    def color(name, &block)
      DSL::Color.define(name, &block)
    end

    def material(name, &block)
      DSL::Material.define(name, &block)
    end

    def scene
      SceneDSL
    end

    def shape
      ShapeDSL
    end
  end

  # Top level shape DSL module
  module ShapeDSL
    def self.mesh(name, &block)
      DSL::Mesh.define(name, klass: DSL::Shape, &block)
    end
  end

  # Top level scene DSL module
  module SceneDSL
    def self.pry(&block)
      ::Pry.start DSL::Scene.setup(&block)
    end
  end
end

include GlisteningRuby::BaseDSL # rubocop:disable Style/MixinUsage
