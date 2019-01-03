# frozen_string_literal: true

require_relative 'color'
require_relative '../material'
require_relative '../pattern/blend'

module GlisteningRuby
  module DSL
    # Material builder DSL class
    class Material < Base
      include ColorSpace

      def instance
        super
        @pattern = if @pattern&.count&.> 1
                     ::GlisteningRuby::Pattern::Blend.new(*@pattern)
                   else
                     @pattern&.last
                   end
        ::GlisteningRuby::Material.new { |i| copy_ivars(i) }
      end

      def color(color)
        color = Color[color] if color.is_a? Symbol
        @color = color
      end

      def pattern(name = nil, &block)
        r = (@pattern ||= [])
        return dsl(PatternDSL) { |p| r << p } if name.nil?

        r << Pattern[name, &block]
      end

      def phong(specular, shininess = 200)
        specular = Color[specular] if specular.is_a? Symbol
        @specular = specular
        @shininess = shininess
      end

      def reflective(color_or_ratio)
        color_or_ratio = Color[color_or_ratio] if color_or_ratio.is_a? Symbol
        @reflective = color_or_ratio
      end

      def ambient(color_or_ratio)
        color_or_ratio = Color[color_or_ratio] if color_or_ratio.is_a? Symbol
        @ambient = color_or_ratio
      end

      def diffuse(color_or_ratio)
        color_or_ratio = Color[color_or_ratio] if color_or_ratio.is_a? Symbol
        @diffuse = color_or_ratio
      end

      def transparent(color_or_ratio, refractive_index = 1.0)
        color_or_ratio = Color[color_or_ratio] if color_or_ratio.is_a? Symbol
        @transparency = color_or_ratio
        @refractive_index = refractive_index
      end
    end
  end
end
