# frozen_string_literal: true

module GlisteningRuby
  # This is a 4D tuple, used for representing points and vectors
  class Tuple
    def self.[](*args)
      new(*args)
    end

    def initialize(x_axis = 0, y_axis = 0, z_axis = 0, w_axis = 0)
      @x = x_axis
      @y = y_axis
      @z = z_axis
      @w = w_axis
    end

    attr_accessor :x, :y, :z, :w

    def is_a?(kind)
      super ||
        case self
        when kind
          true
        else
          false
        end
    end
    alias kind_of? is_a?

    def ==(other)
      close?(@x, other.x) &&
        close?(@y, other.y) &&
        close?(@z, other.z) &&
        close?(@w, other.w)
    end

    def +(other)
      Tuple[@x + other.x, @y + other.y, @z + other.z, @w + other.w]
    end

    def -(other)
      Tuple[@x - other.x, @y - other.y, @z - other.z, @w - other.w]
    end

    def *(other)
      Tuple[@x * other, @y * other, @z * other, @w * other]
    end

    def /(other)
      Tuple[@x / other, @y / other, @z / other, @w / other]
    end

    def -@
      Tuple[-@x, -@y, -@z, -@w]
    end

    def dot(other)
      @x * other.x + @y * other.y + @z * other.z + @w * other.w
    end

    def cross(other) # rubocop:disable Metrics/AbcSize
      raise TypeError, 'Only valid for Vectors' unless vector?

      Vector[
        @y * other.z - @z * other.y,
        @z * other.x - @x * other.z,
        @x * other.y - @y * other.x
      ]
    end

    def magnitude
      (@x * @x + @y * @y + @z * @z + @w * @w)**0.5
    end

    def normalize
      self / magnitude
    end

    private

    def point?
      close?(@w, 1.0)
    end

    def vector?
      close?(@w, 0.0)
    end
  end
end