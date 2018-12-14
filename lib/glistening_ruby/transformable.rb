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
  end
end
