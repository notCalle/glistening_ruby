# frozen_string_literal: true

module GlisteningRuby
  # An intersection between a ray and something
  class Intersection
    def self.[](*args)
      new(*args)
    end

    def initialize(t_intersect, object)
      @t = t_intersect
      @object = object
    end

    attr_reader :object, :t
  end
end
