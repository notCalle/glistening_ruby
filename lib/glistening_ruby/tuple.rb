# frozen_string_literal: true

require_relative 'base'

module GlisteningRuby
  # This is a 4D tuple, used for representing points and vectors
  class Tuple < Base # rubocop:disable Metrics/ClassLength
    include Enumerable

    def initialize(x_axis = 0, y_axis = 0, z_axis = 0, w_axis = 0)
      @x = x_axis
      @y = y_axis
      @z = z_axis
      @w = w_axis
      super
    end

    def each
      [@x, @y, @z, @w].each { |c| yield c }
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
      [x, y]
    end

    def xyz
      [x, y, z]
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
      close?(@x, other.x) &&
        close?(@y, other.y) &&
        close?(@z, other.z) &&
        close?(@w, other.w)
    end

    def +(other)
      self.class.new(@x + other.x, @y + other.y, @z + other.z, @w + other.w)
    end

    def -(other)
      self.class.new(@x - other.x, @y - other.y, @z - other.z, @w - other.w)
    end

    def *(other)
      if other.is_a?(Tuple)
        hadamard_product(other)
      else
        scalar_product(other)
      end
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
      @x * other.x + @y * other.y + @z * other.z + @w * other.w
    end

    def dot_a(ary)
      x2, y2, z2, w2 = ary
      @x * x2 + @y * y2 + @z * z2 + @w * w2
    end

    def cross(other) # rubocop:disable Metrics/AbcSize
      raise TypeError, 'Only valid for Vectors' unless vector?

      Vector[
        @y * other.z - @z * other.y,
        @z * other.x - @x * other.z,
        @x * other.y - @y * other.x
      ]
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

    def hadamard_product(other)
      self.class.new(@x * other.x, @y * other.y, @z * other.z, @w * other.w)
    end

    def scalar_product(other)
      self.class.new(@x * other, @y * other, @z * other, @w * other)
    end
  end
end
