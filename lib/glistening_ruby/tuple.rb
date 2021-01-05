# frozen_string_literal: true

require_relative 'base'

module GlisteningRuby
  # This is a 4D tuple, used for representing points and vectors
  class Tuple < Base # rubocop:disable Metrics/ClassLength
    include Enumerable

    def initialize(x_axis = 0, y_axis = 0, z_axis = 0, w_axis = 0) # rubocop:disable Lint/MissingSuper
      @x = x_axis
      @y = y_axis
      @z = z_axis
      @w = w_axis
    end

    def each
      return to_enum(__method__) { 4 } unless block_given?

      yield @x
      yield @y
      yield @z
      yield @w
    end

    def to_s
      "(#{@x}, #{@y}, #{@z}, #{@w})"
    end
    alias inspect to_s

    attr_reader :x, :y, :z, :w
    alias r x
    alias g y
    alias b z

    def xy
      [@x, @y]
    end

    def xyz
      [@x, @y, @z]
    end

    def xyzw
      [@x, @y, @z, @w]
    end

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
      x2, y2, z2, w2 = other.xyzw
      close?(@x, x2) &&
        close?(@y, y2) &&
        close?(@z, z2) &&
        close?(@w, w2)
    end

    def +(other)
      x2, y2, z2, w2 = other.xyzw
      self.class.new(@x + x2, @y + y2, @z + z2, @w + w2)
    end

    def -(other)
      x2, y2, z2, w2 = other.xyzw
      self.class.new(@x - x2, @y - y2, @z - z2, @w - w2)
    end

    def *(other)
      if other.is_a?(Tuple)
        x2, y2, z2, w2 = other.xyzw
      else
        x2 = y2 = z2 = w2 = other
      end
      self.class.new(@x * x2, @y * y2, @z * z2, @w * w2)
    end

    def /(other)
      self.class.new(@x / other, @y / other, @z / other, @w / other)
    end

    def **(other)
      self.class.new(@x**other, @y**other, @z**other, @w**other)
    end

    def -@
      self.class.new(-@x, -@y, -@z, -@w)
    end

    def dot(other)
      x2, y2, z2, w2 = other.xyzw
      @x * x2 + @y * y2 + @z * z2 + @w * w2
    end

    def dot_a(x_2 = 0, y_2 = 0, z_2 = 0, w_2 = 0)
      @x * x_2 + @y * y_2 + @z * z_2 + @w * w_2
    end

    def cross(other)
      x2, y2, z2 = other.xyz
      Tuple.new(@y * z2 - @z * y2,
                @z * x2 - @x * z2,
                @x * y2 - @y * x2,
                0)
    end

    def interpolate(other, fraction)
      self + (other - self) * fraction
    end

    def magnitude
      (@x * @x + @y * @y + @z * @z + @w * @w)**0.5
    end

    def normalize
      self / magnitude
    end

    def reflect(normal)
      self - normal * (2 * dot(normal))
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
