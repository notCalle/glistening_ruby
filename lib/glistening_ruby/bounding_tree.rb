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

    def split(shapes, &_axis) # rubocop:disable Metrics/AbcSize
      count = shapes.count
      return shapes if count <= 2

      shapes = shapes.sort_by { |s| yield s.aabb.center }
      sum = 0
      costs = shapes.map { |s| sum += s.aabb.area }
      median_cost = costs.last / 2
      l = costs.find_index { |c| c >= median_cost }.clamp(1, count - 2)

      [self.class.new(shapes[0..(l - 1)]), self.class.new(shapes[l..])]
    end
  end
end
