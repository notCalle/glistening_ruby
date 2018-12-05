# frozen_string_literal: true

require_relative 'matrix'

module GlisteningRuby
  # 4x4 Translation matrix for 3D vector space
  class Translation < Matrix
    def initialize(d_x, d_y, d_z)
      super(4) do
        self[0, 3] = d_x.to_f
        self[1, 3] = d_y.to_f
        self[2, 3] = d_z.to_f
      end
    end
  end
end
