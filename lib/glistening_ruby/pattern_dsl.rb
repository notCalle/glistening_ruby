# frozen_string_literal: true

require 'glistening_ruby'
require_relative 'dsl/pattern'

module GlisteningRuby
  # Top level pattern DSL module
  module PatternDSL
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
  end
end
