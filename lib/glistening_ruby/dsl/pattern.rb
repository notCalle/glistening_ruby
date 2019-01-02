# frozen_string_literal: true

require_relative 'color'
require_relative 'transformable'

module GlisteningRuby
  module DSL
    # Pattern builder DSL class
    class Pattern < Transformable
      def color(color)
        color = Color[color] if color.is_a? Symbol
        pigments << color
      end

      def rgb(*args)
        Color.rgb(*args)
      end

      private

      def pigments
        @pigments ||= []
      end
    end
  end
end
