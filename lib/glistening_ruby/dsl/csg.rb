# frozen_string_literal: true

require_relative 'shape'

module GlisteningRuby
  module DSL
    # Abstract base for CSG builder DSL classes
    class CSG < Shape
      def instance
        super
        @shapes.reduce do |left, right|
          ::GlisteningRuby::CSG.send(@op, left, right)
        end
      end

      def shape(name = nil, *args, &block)
        r = shapes
        return dsl(ShapeDSL) { |s| r << s } if name.nil?

        shapes << Shape[name, *args, &block]
      end

      private

      def shapes
        @shapes ||= []
      end
    end

    # CSG Difference builder DSL class
    class Difference < CSG
      def initialize
        @op = :difference
        super
      end
    end

    # CSG Intersection builder DSL class
    class Intersection < CSG
      def initialize
        @op = :intersection
        super
      end
    end

    # CSG Union builder DSL class
    class Union < CSG
      def initialize
        @op = :union
        super
      end
    end
  end
end
