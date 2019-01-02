# frozen_string_literal: true

require_relative 'base'
require_relative '../color'

module GlisteningRuby
  module DSL
    # Color builder DSL class
    class Color < Base
      def self.rgb(red, green, blue)
        ::GlisteningRuby::Color.new(red, green, blue)
      end

      def instance
        ::GlisteningRuby::Color.new(@red, @green, @blue)
      end

      def rgb(red, green, blue)
        @red = red.to_f
        @green = green.to_f
        @blue = blue.to_f
      end
    end
  end
end
