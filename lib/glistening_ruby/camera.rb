# frozen_string_literal: true

require_relative 'base'
require_relative 'matrix'

module GlisteningRuby
  # The camera that renders the world
  class Camera < Base
    def initialize(width, height, fov)
      @w = width
      @h = height
      @fov = fov
      aspect_ratio = Rational(width, height)
      initialize_half(aspect_ratio, fov)
      @pixel_size = (@half_width * 2) / width
      self.transform = Matrix::IDENTITY
      super
    end

    attr_reader :fov, :h, :pixel_size, :transform, :w
    attr_writer :progress

    def transform=(transform)
      @transform = transform
      @inverse = transform.inverse
    end

    def ray_for_pixel(px_x, px_y)
      offset_x = (px_x + 0.5) * @pixel_size
      offset_y = (px_y + 0.5) * @pixel_size
      world_point = Point[@half_width - offset_x, @half_height - offset_y, -1]
      pixel = @inverse * world_point
      origin = @inverse * Point::ZERO
      direction = (pixel - origin).normalize
      Ray.new(origin, direction)
    end

    def render(world, limit: World::RECURSION_LIMIT)
      Canvas.new(@w, @h) do |canvas|
        canvas.each do |_, x, y|
          ray = ray_for_pixel(x, y)
          canvas[x, y] = world.color_at ray, limit
          @progress&.call(x, y)
        end
      rescue Interrupt
        canvas
      end
    end

    private

    def initialize_half(aspect, fov)
      half_view = Math.tan(fov * Math::PI)
      if aspect >= 1
        @half_width = half_view
        @half_height = half_view / aspect
      else
        @half_height = half_view
        @half_width = half_view * aspect
      end
    end
  end
end
