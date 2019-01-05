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
      this == that || (this - that).abs < EPSILON
    end

    def identity
      Matrix::IDENTITY
    end

    private

    def cache
      @cache ||= {}
    end

    def reset_cache
      @cache = nil
    end
  end
end
