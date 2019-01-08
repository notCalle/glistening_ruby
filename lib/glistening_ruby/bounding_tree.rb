# frozen_string_literal: true

require_relative 'aabb'
require_relative 'intersections'

module GlisteningRuby
  # A binary tree of contained axis-aligned bounding boxes
  class BoundingTree
    def initialize(shapes)
      shapes = shapes.select { |s| s.respond_to? :bounds }
      @aabb = AABB.new(shapes.flat_map do |s|
        AABB.from_shape(s).bounds
      end)
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

    def split(shapes, &axis)
      return shapes if shapes.count <= 2

      shapes = sort_by_axis(shapes, axis)
      l = shapes.count / 2
      [0..(l - 1), l..-1].map { |i| self.class.new(shapes[i]) }
    end

    def sort_by_axis(shapes, axis)
      shapes.sort do |a, b|
        a_axis = axis.call a.aabb.center
        b_axis = axis.call b.aabb.center
        a_axis <=> b_axis
      end
    end
  end
end
