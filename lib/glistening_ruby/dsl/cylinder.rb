# frozen_string_literal: true

require_relative 'shape'

module GlisteningRuby
  module DSL
    # Cylinder builder DSL class
    class Cylinder < Shape
      def instance
        super
        @minimum ||= 0
        @maximum ||= 1
        ::GlisteningRuby::Cylinder.new { |i| copy_ivars(i) }
      end

      def closed(maybe = true)
        @closed = maybe
      end

      def range(min_max)
        @minimum = min_max.min
        @maximum = min_max.max
      end
    end
  end
end
