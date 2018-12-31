# frozen_string_literal: true

require 'forwardable'
require_relative 'bounding_tree'
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

      @bounding_tree = nil
      @shapes << other
      other.parent = self
    end

    def bounds
      bounding_tree.bounds
    end

    def_delegators :@shapes, :empty?, :include?, :each, :[]

    def intersect(ray)
      bounding_tree.intersect(ray.transform(@inverse))
    end

    private

    def bounding_tree
      @bounding_tree ||= BoundingTree.new(@shapes)
    end
  end
end
