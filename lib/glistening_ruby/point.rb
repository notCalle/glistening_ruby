# frozen_string_literal: true

require_relative 'tuple'

module GlisteningRuby
  # Helper for creating and identifying 3D Points as 4D Tuples, using
  # the convention that w = 1.0 for points
  module Point
    def self.[](x_axis, y_axis, z_axis)
      Tuple[x_axis, y_axis, z_axis, 1.0]
    end

    def self.===(obj)
      obj.is_a?(Tuple) && close?(obj.w, 1.0)
    end
  end

  Point::ZERO = Point[0, 0, 0]
end
