# frozen_string_literal: true

require_relative 'base'

module GlisteningRuby
  # Abstract transformable object
  class Transformable < Base
    def initialize(*)
      @transform = Matrix::IDENTITY
      @inverse = Matrix::IDENTITY
      @inverse_transpose = Matrix::IDENTITY
      super
    end

    attr_reader :transform, :inverse, :inverse_transpose

    def transform=(transform)
      @transform = transform
      @inverse = transform.inverse
      @inverse_transpose = transform.submatrix(3, 3).inverse.transpose
    end

    # Transform a point in world space to local space
    #
    # :call-seq:
    #   to_local(world_point) => local_point
    #
    def to_local(point)
      @inverse * point
    end

    # Transform a point in local space to world space
    #
    # :call-seq:
    #   to_local(local_point) => world_point
    #
    def to_world(point)
      @transform * point
    end
  end
end
