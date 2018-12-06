# frozen_string_literal: true

require_relative 'matrix'

module GlisteningRuby
  # 4x4 Shearing matrix for 3D vector space
  class Shearing < Matrix
    def initialize(x_y, x_z, # rubocop:disable Metrics/ParameterLists
                   y_x, y_z,
                   z_x, z_y)
      super(4) do
        self[0, 1] = x_y.to_f
        self[0, 2] = x_z.to_f
        self[1, 0] = y_x.to_f
        self[1, 2] = y_z.to_f
        self[2, 0] = z_x.to_f
        self[2, 1] = z_y.to_f
      end
    end
  end
end
