# frozen_string_literal: true

require 'forwardable'
require_relative 'computations'

module GlisteningRuby
  # An intersection between a ray and something
  class Intersection
    include Comparable
    extend Forwardable

    def self.[](*args)
      new(*args)
    end

    def initialize(t_intersect, object)
      @t = t_intersect
      @object = object
    end

    attr_reader :object, :t


    def <=>(other)
      @t.<=>other.t
    end

    def_delegators :@t, :positive?, :negative?, :zero?
  end
end
