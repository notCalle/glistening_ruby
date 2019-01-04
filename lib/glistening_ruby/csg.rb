# frozen_string_literal: true

require_relative 'intersections'
require_relative 'shape'

module GlisteningRuby
  # Constructive Solid Geometry
  module CSG
    def self.[](operation, left, right)
      send(operation, left, right)
    end

    def self.union(left, right)
      Union.new(left, right)
    end

    def self.intersection(left, right)
      Intersection.new(left, right)
    end

    def self.difference(left, right)
      Difference.new(left, right)
    end

    # Abstract base class for CSG operations
    class Base < Shape
      def initialize(left, right)
        left.parent = self
        right.parent = self
        @left = left
        @right = right
        super()
      end

      def include?(other)
        super || @left.include?(other) || @right.include?(other)
      end

      attr_reader :left, :right

      def intersect(ray)
        ray = ray.transform(@inverse)
        select_intersections(@left.intersect(ray) << @right.intersect(ray))
      end

      def select_intersections(intersections)
        inl = false
        inr = false

        intersections.each.with_object(Intersections.new) do |i, result|
          lhit = @left.include? i.object
          result << [i] if allow_intersection?(lhit, inl, inr)
          inl = !inl if lhit
          inr = !inr unless lhit
        end
      end
    end

    # Concrete CSG Union
    class Union < Base
      def operation
        'union'
      end

      def allow_intersection?(left_hit, in_left, in_right)
        (left_hit && !in_right) || (!left_hit && !in_left)
      end
    end

    # Concrete CSG Intersection
    class Intersection < Base
      def operation
        'intersection'
      end

      def allow_intersection?(left_hit, in_left, in_right)
        (left_hit && in_right) || (!left_hit && in_left)
      end
    end

    # Concrete CSG Difference
    class Difference < Base
      def operation
        'difference'
      end

      def allow_intersection?(left_hit, in_left, in_right)
        (left_hit && !in_right) || (!left_hit && in_left)
      end
    end
  end
end
