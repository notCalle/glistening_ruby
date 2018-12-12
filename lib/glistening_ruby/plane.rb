# frozen_string_literal: true

require_relative 'shape'

module GlisteningRuby
  # A snakeless plane
  class Plane < Shape
    private

    def object_normal(_point)
      Vector[0, 1, 0]
    end
  end
end
