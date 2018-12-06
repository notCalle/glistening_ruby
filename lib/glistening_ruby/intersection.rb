# frozen_string_literal: true

module GlisteningRuby
  # An intersection between a ray and something
  class Intersection
    include Comparable

    def self.[](*args)
      new(*args)
    end

    def initialize(t_intersect, object)
      @t = t_intersect
      @object = object
    end

    attr_reader :object, :t

    # Negative intersections are further away than any positive intersection
    def <=>(other)
      return 1 if t.negative?
      return -1 if other.t.negative?

      t.<=>(other.t)
    end
  end
end
