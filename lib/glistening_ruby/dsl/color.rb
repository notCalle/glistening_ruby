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

      def grey(intensity)
        rgb(intensity, intensity, intensity)
      end
    end

    # Color builder DSL class
    class Color < Base
      extend ColorSpace

      def instance
        @color
      end

      def method_missing(name, *args)
        return super unless respond_to_missing?(name)

        @color = self.class.send(name, *args)
      end

      def respond_to_missing?(name, include_all = false)
        self.class.respond_to?(name, include_all) || super
      end
    end
  end
end
