# frozen_string_literal: true

require_relative 'tuple'

module GlisteningRuby
  # Helper for creating and identifying 3D Vectors as 4D Tuples, using
  # the convention that w = 0.0 for vectors
  module Vector
    def self.[](x_axis, y_axis, z_axis)
      Tuple[x_axis, y_axis, z_axis, 0.0]
    end

    def self.===(obj)
      obj.is_a?(Tuple) && close?(obj.w, 0.0)
    end
  end
end
