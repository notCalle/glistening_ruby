# frozen_string_literal: true

require_relative 'shape'

module GlisteningRuby
  module DSL
    # Mesh builder DSL class
    class Cube < Shape
      def instance
        super
        ::GlisteningRuby::Cube.new { |i| copy_ivars(i) }
      end
    end
  end
end
