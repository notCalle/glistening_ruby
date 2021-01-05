# frozen_string_literal: true

require 'forwardable'
require_relative 'base'
require_relative 'computations'

module GlisteningRuby
  # An intersection between a ray and something
  class Intersection < Base
    include Comparable
    extend Forwardable

    def initialize(t_intersect, object, u = nil, v = nil) # rubocop:disable Lint/MissingSuper
      u, v = object.uv if u.nil? && object.respond_to?(:uv)
      @t = t_intersect
      @object = object
      @u = u
      @v = v
    end
    attr_reader :object, :t, :u, :v

    def <=>(other)
      @t.<=>other.t
    end

    def prepare(ray, intersections = [self])
      Computations.new(self, ray, intersections)
    end

    def_delegators :@t, :positive?, :negative?, :zero?
  end
end
