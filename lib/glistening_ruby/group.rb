# frozen_string_literal: true

require 'forwardable'
require_relative 'bounding_tree'
require_relative 'container'

module GlisteningRuby
  # A group of shapes
  class Group < Container
    def bounds
      bounding_tree.bounds
    end

    def intersect(ray)
      bounding_tree.intersect(ray.transform(inverse))
    end

    private

    def bounding_tree
      @bounding_tree ||= lambda do
        shapes = @shapes.select { |s| s.respond_to? :bounds }
        BoundingTree.new(shapes)
      end.call
    end
  end
end
