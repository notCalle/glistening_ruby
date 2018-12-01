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
      count = 0
      header = +"P3\n#{@w} #{@h}\n255\n"
      @pixels.each.with_object(header) do |pixel, result|
        count += 1
        result << color_to_ppm(pixel) << ((count % @w).zero? ? "\n" : ' ')
      end
    end

    private

    def color_to_ppm(color)
      color.to_a[0..2].map { |c| (255 * c).round.clamp(0, 255) }.join(' ')
    end
  end
end
