# frozen_string_literal: true

require_relative 'base'
require_relative 'color'

module GlisteningRuby
  module DSL
    # Light builder DSL class
    class Light < Base
      include ColorSpace

      def instance
        super
        @color ||= grey 1
        GlisteningRuby::PointLight.new(@point, @color)
      end

      def point(p_x, p_y, p_z)
        @point = ::GlisteningRuby::Point[p_x, p_y, p_z]
      end

      def color(color)
        color = Color[color] if color.is_a? Symbol
        @color = color
      end
    end
  end
end
