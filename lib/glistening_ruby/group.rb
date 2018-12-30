# frozen_string_literal: true

require 'forwardable'
require_relative 'aabb'
require_relative 'intersections'
require_relative 'shape'

module GlisteningRuby
  # A group of shapes
  class Group < Shape
    extend Forwardable
    include Enumerable

    def initialize
      @shapes ||= []
      super
    end

    def <<(other)
      raise "#{other} already has a parent" unless other.parent.nil?

      @aabb = nil
      @shapes << other
      other.parent = self
    end

    def bounds
      aabb.bounds
    end

    def_delegators :@shapes, :empty?, :include?, :each, :[]

    def intersect(ray)
      ray = ray.transform(@inverse)
      return Intersections.new unless intersect_bounds?(ray)

      Intersections.new << flat_map { |s| s.intersect(ray).to_a }
    end

    private

    def aabb
      @aabb ||= AABB.new(flat_map { |s| AABB.from_shape(s).bounds })
    end

    def intersect_bounds?(ray)
      aabb.intersect(ray)
    end
  end
end
