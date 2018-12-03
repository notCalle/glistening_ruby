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

  # 4x4 Y axis rotation matrix for 3D vector space
  class RotationY < Matrix
    def initialize(tau)
      tau *= TAU
      sin = Math.sin(tau)
      cos = Math.cos(tau)
      super(4) do
        self[0, 0] = cos
        self[0, 2] = sin
        self[2, 0] = -sin
        self[2, 2] = cos
      end
    end
  end

  # 4x4 Z axis rotation matrix for 3D vector space
  class RotationZ < Matrix
    def initialize(tau)
      tau *= TAU
      sin = Math.sin(tau)
      cos = Math.cos(tau)
      super(4) do
        self[0, 0] = cos
        self[0, 1] = -sin
        self[1, 0] = sin
        self[1, 1] = cos
      end
    end
  end
end
