# frozen_string_literal: true

require 'glistening_ruby'
require_relative 'dsl/pattern'

module GlisteningRuby
  # Top level pattern DSL module
  module PatternDSL
    # Named object factory definition
    def self.blend(name, &block)
      DSL::Blend.define(name, klass: DSL::Pattern, &block)
    end

    def self.checkers(name, &block)
      DSL::Checkers.define(name, klass: DSL::Pattern, &block)
    end

    def self.gradient(name, &block)
      DSL::Gradient.define(name, klass: DSL::Pattern, &block)
    end

    def self.stripe(name, &block)
      DSL::Stripe.define(name, klass: DSL::Pattern, &block)
    end

    # Anonymous object creation
    def blend(*args, &block)
      callback DSL::Blend.setup(*args, &block)
    end

    def checkers(*args, &block)
      callback DSL::Checkers.setup(*args, &block)
    end

    def gradient(*args, &block)
      callback DSL::Gradient.setup(*args, &block)
    end

    def stripe(*args, &block)
      callback DSL::Stripe.setup(*args, &block)
    end
  end
end
