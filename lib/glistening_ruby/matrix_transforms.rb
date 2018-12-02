# frozen_string_literal: true

module GlisteningRuby
  # Transformation methods for matrix
  module MatrixTransforms
    def rotate_x(tau)
      RotationX.new(tau) * self
    end

    def rotate_y(tau)
      RotationY.new(tau) * self
    end

    def rotate_z(tau)
      RotationZ.new(tau) * self
    end

    def scale(s_x, s_y = nil, s_z = nil)
      s_z = s_y = s_x unless s_y && s_z

      Scaling.new(s_x, s_y, s_z) * self
    end

    def shear(*args)
      Shearing.new(*args) * self
    end

    def translate(d_x, d_y, d_z)
      Translation.new(d_x, d_y, d_z) * self
    end
  end
end
