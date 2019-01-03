# frozen_string_literal: true

require_relative 'shape'

module GlisteningRuby
  module DSL
    # Group builder DSL class
    class Group < Shape
      def instance
        super
        ::GlisteningRuby::Group.new { |i| copy_ivars(i) }
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
  end
end
