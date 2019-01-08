# frozen_string_literal: true

require 'glistening_ruby'
require_relative 'dsl/light'

module GlisteningRuby
  # Top level light DSL module
  module LightDSL
    # Named object factory definition
    def self.parallel(name, &block)
      DSL::ParallelLight.define(name, klass: DSL::Light, &block)
    end

    def self.spherical(name, &block)
      DSL::SphericalLight.define(name, klass: DSL::Light, &block)
    end

    # Anonymous object creation
    def parallel(*args, &block)
      callback DSL::ParallelLight.setup(*args, &block)
    end

    def spherical(*args, &block)
      callback DSL::SphericalLight.setup(*args, &block)
    end
  end
end
