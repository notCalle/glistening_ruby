# frozen_string_literal: true

require_relative 'matrix'

module GlisteningRuby
  # 4x4 Scaling matrix for 3D vector space
  class Scaling < Matrix
    def initialize(s_x, s_y, s_z)
      super(4) do
        self[0, 0] = s_x.to_f
        self[1, 1] = s_y.to_f
        self[2, 2] = s_z.to_f
      end
    end
  end
end
