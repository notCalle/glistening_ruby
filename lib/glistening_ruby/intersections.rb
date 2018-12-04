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
      raise TypeError unless intersections.all? { |i| i.is_a?(Intersection) }

      super(intersections)
    end
  end
end
