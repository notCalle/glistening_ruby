# frozen_string_literal: true

require_relative 'base'

module GlisteningRuby
  # Abstract transformable object
  class Transformable < Base
    def initialize(*)
      super
    end

    def transform
      @transform ||= Matrix::IDENTITY
    end

    def transform=(transform)
      reset_cache
      @transform = transform
    end

    def inverse
      cache[:inverse] ||= transform.inverse
    end

    def inverse_transpose
      cache[:inverse_transpose] ||= transform.submatrix(3, 3).inverse.transpose
    end

    # Transform a point in outer space to local space
    #
    # :call-seq:
    #   to_local(outer_point) => local_point
    #
    def to_local(point)
      inverse * point
    end

    # Transform a point in local space to outer space
    #
    # :call-seq:
    #   to_outer(local_point) => outer_point
    #
    def to_outer(point)
      transform * point
    end
  end
end
