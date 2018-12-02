# frozen_string_literal: true

require_relative 'matrix'

module GlisteningRuby
  # 4x4 Shearing matrix for 3D vector space
  class Shearing < Matrix
    def initialize(x_y, x_z, # rubocop:disable Metrics/ParameterLists
                   y_x, y_z,
                   z_x, z_y)
      super(4) do
        self[0, 1] = x_y
        self[0, 2] = x_z
        self[1, 0] = y_x
        self[1, 2] = y_z
        self[2, 0] = z_x
        self[2, 1] = z_y
      end
    end
  end
end
