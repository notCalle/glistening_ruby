# frozen_string_literal: true

require 'forwardable'
require_relative 'base'
require_relative 'computations'

module GlisteningRuby
  # An intersection between a ray and something
  class Intersection < Base
    include Comparable
    extend Forwardable

    def initialize(t_intersect, object)
      @t = t_intersect
      @object = object
    end

    attr_reader :object, :t

    def <=>(other)
      @t.<=>other.t
    end

    def prepare(ray)
      Computations.new(self, ray)
    end

    def_delegators :@t, :positive?, :negative?, :zero?
  end
end
