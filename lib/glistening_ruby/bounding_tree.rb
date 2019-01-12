# frozen_string_literal: true

require_relative 'aabb'
require_relative 'intersections'

module GlisteningRuby
  # A binary tree of contained axis-aligned bounding boxes
  class BoundingTree
    def initialize(shapes)
      @aabb = AABB.from_shapes(shapes)
      @axis = @aabb.largest_axis
      @bounds = @aabb.bounds
      @left, @right = split(shapes, &@axis.to_proc)
    end

    attr_reader :bounds

    def intersect(ray)
      return Intersections.new unless @aabb.intersect_bounds?(ray)
      return Intersections.new if @left.nil?
      return @left.intersect(ray) if @right.nil?

      @left.intersect(ray) << @right.intersect(ray)
    end

    private

    def split(shapes, &_axis)
      return shapes if shapes.count <= 2

      shapes = shapes.sort_by { |s| yield s.aabb.center }
      l = shapes.count / 2
      [0..(l - 1), l..-1].map { |i| self.class.new(shapes[i]) }
    end
  end
end
