# frozen_string_literal: true

require 'glistening_ruby'
require_relative 'pattern_dsl'
require_relative 'shape_dsl'
require_relative 'dsl/color'
require_relative 'dsl/material'
require_relative 'dsl/scene'

module GlisteningRuby
  # Top level Domain Speficic Language module
  module BaseDSL
    def color(name, &block)
      DSL::Color.define(name, &block)
    end

    def material(name, &block)
      DSL::Material.define(name, &block)
    end

    def pattern
      PatternDSL
    end

    def scene
      SceneDSL
    end

    def shape
      ShapeDSL
    end

    def stdlib(submodule)
      "glistening_ruby/dsl/stdlib/#{submodule}"
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
