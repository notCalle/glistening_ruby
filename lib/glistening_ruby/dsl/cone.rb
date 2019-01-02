# frozen_string_literal: true

require_relative 'shape'

module GlisteningRuby
  module DSL
    # Cone builder DSL class
    class Cone < Shape
      def instance
        super
        @minimum ||= 0
        @maximum ||= 1
        ::GlisteningRuby::Cone.new { |i| copy_ivars(i) }
      end

      def closed(maybe = true)
        @closed = maybe
      end

      def range(min_max)
        @minimum = min_max.min
        @maxumum = min_max.max
      end
    end
  end
end
