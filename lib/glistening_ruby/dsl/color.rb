# frozen_string_literal: true

require_relative 'base'
require_relative '../color'

module GlisteningRuby
  module DSL
    # Color space helper module
    module ColorSpace
      def rgb(red, green, blue)
        ::GlisteningRuby::Color.new(red, green, blue)
      end
    end

    # Color builder DSL class
    class Color < Base
      extend ColorSpace

      def instance
        @color
      end

      def rgb(*args)
        @color = self.class.rgb(args)
      end
    end
  end
end
