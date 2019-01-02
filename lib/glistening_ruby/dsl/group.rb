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

      def shape(name)
        shapes << Shape[name]
      end

      private

      def shapes
        @shapes ||= []
      end
    end
  end
end
