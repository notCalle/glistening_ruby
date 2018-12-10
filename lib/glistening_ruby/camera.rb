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
      initialize_half(width / height, fov)
      @pixel_size = (@half_width * 2) / width
      self.transform = Matrix::IDENTITY
      super
    end

    attr_reader :fov, :h, :pixel_size, :transform, :w

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
