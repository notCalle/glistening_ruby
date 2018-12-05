# frozen_string_literal: true

require 'delegate'
require_relative 'intersection'

module GlisteningRuby
  # A set of intersections
  class Intersections < SimpleDelegator
    def self.[](*args)
      new(*args)
    end

    def initialize(*intersections)
      super(intersections)
    end

    def hit
      result = min
      return result unless result&.t&.negative?
    end
  end
end
