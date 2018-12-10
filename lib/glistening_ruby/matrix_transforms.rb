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

    def scale(s_x, s_y = s_x, s_z = s_x)
      Scaling.new(s_x, s_y, s_z) * self
    end

    def shear(*args)
      Shearing.new(*args) * self
    end

    def translate(d_x, d_y = 0, d_z = 0)
      Translation.new(d_x, d_y, d_z) * self
    end

    def view(origin, look_at, upish)
      ViewTransform.new(origin, look_at, upish) * self
    end
  end
end
