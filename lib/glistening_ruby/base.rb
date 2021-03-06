# frozen_string_literal: true

# Namespace module for everything
module GlisteningRuby
  # Base class for everything
  class Base
    class << self
      alias [] new
    end

    def initialize(*)
      yield self if block_given?
    end

    def close?(this, that, epsilon = EPSILON)
      this == that || (this - that).abs < epsilon
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
