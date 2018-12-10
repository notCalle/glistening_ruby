# frozen_string_literal: true

# Namespace module for everything
module GlisteningRuby
  # Base class for everything
  class Base
    def self.[](*args)
      new(*args)
    end

    def initialize(*)
      yield self if block_given?
    end

    def close?(this, that)
      (this - that).abs < EPSILON
    end

    def identity
      Matrix::IDENTITY
    end
  end
end
