# frozen_string_literal: true

require_relative 'base'
require_relative 'color'

module GlisteningRuby
  # A drawable canvas
  class Canvas < Base
    def initialize(width, height)
      @w = width.to_i
      @h = height.to_i
      @pixels = Array.new(height) { Array.new(width, Color[0, 0, 0]) }
      super
    end

    attr_reader :w, :h

    def to_s
      "#<#{self.class}: #{@w} x #{@h}>"
    end
    alias inspect to_s

    def [](x_pos, y_pos)
      @pixels[y_pos][x_pos]
    end

    def []=(x_pos, y_pos, color)
      @pixels[y_pos][x_pos] = color
    end

    def each
      0.upto(@h - 1) do |y|
        0.upto(@w - 1) do |x|
          yield self[x, y], x, y
        end
      end
    end

    def to_ppm(output = +'')
      output << "P3\n#{@w} #{@h}\n255\n" << pixels_to_ppm
    end

    private

    def pixels_to_ppm
      0.upto(@h - 1).with_object(+'') do |y_pos, result|
        result << pixels_to_ppm_line(y_pos) << "\n"
      end
    end

    def pixels_to_ppm_line(y_pos)
      length = 0
      pixels_to_line_array(y_pos).each.with_object(+'') do |item, result|
        item, length = ppm_item(item, length)
        result << item
      end
    end

    def ppm_item(item, length)
      if length + item.length >= 70
        separator = +"\n"
        length = item.length
      else
        separator = length.zero? ? +'' : +' '
        length = length + item.length + 1
      end

      [separator << item, length]
    end

    def pixels_to_line_array(y_pos)
      0.upto(@w - 1).with_object([]) do |x_pos, line|
        line.concat color_to_str_a(self[x_pos, y_pos])
      end
    end

    def color_to_str_a(color)
      color.to_a[0..2].map { |c| (255 * c).round.clamp(0, 255).to_s }
    end
  end
end
