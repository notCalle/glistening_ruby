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

    # Transform a point in outer space to local space
    #
    # :call-seq:
    #   to_local(outer_point) => local_point
    #
    def to_local(point)
      @inverse * point
    end

    # Transform a point in local space to outer space
    #
    # :call-seq:
    #   to_outer(local_point) => outer_point
    #
    def to_outer(point)
      @transform * point
    end
  end
end
