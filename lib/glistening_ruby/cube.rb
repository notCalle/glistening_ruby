# frozen_string_literal: true

require_relative 'aabb'
require_relative 'vector'

module GlisteningRuby
  # An axis aligned unit Cube
  class Cube < AABB
    def initialize
      super [Point[-1, -1, -1], Point[1, 1, 1]]
    end

    private

    def object_normal(point, _hit) # rubocop:disable Metrics/AbcSize
      max = point.map(&:abs).max
      return Vector[point.x, 0, 0] if close?(point.x.abs, max)
      return Vector[0, point.y, 0] if close?(point.y.abs, max)
      return Vector[0, 0, point.z] if close?(point.z.abs, max)
    end
  end
end
