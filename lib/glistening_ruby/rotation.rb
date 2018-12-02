# frozen_string_literal: true

require_relative 'matrix'

module GlisteningRuby
  # 4x4 X axis rotation matrix for 3D vector space
  class RotationX < Matrix
    def initialize(tau)
      tau *= TAU
      sin = Math.sin(tau)
      cos = Math.cos(tau)
      super(4) do
        self[1, 1] = cos
        self[1, 2] = -sin
        self[2, 1] = sin
        self[2, 2] = cos
      end
    end
  end
end
