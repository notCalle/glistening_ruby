# frozen_string_literal: true

require_relative 'color'

module GlisteningRuby
  # A drawable canvas
  class Canvas
    def self.[](*args)
      new(*args)
    end

    def initialize(width, height)
      @w = width.to_i
      @h = height.to_i
      @pixels = Array.new(width * height, Color[0, 0, 0])
    end

    attr_reader :w, :h

    def [](x_pos, y_pos)
      @pixels[x_pos + y_pos * @w]
    end

    def []=(x_pos, y_pos, color)
      @pixels[x_pos + y_pos * @w] = color
    end

    def each
      x = y = 0
      @pixels.each do |pixel|
        yield pixel, x, y
        x += 1
        if x == @w
          y += 1
          x = 0
        end
      end
    end

    def to_ppm
      "P3\n#{@w} #{@h}\n255\n"
    end
  end
end
