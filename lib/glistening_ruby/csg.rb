# frozen_string_literal: true

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

    # Abstract base class for CSG operations
    class Base < Shape
      def initialize(left, right)
        left.parent = self
        right.parent = self
        @left = left
        @right = right
        super()
      end

      attr_reader :left, :right
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
  end
end
