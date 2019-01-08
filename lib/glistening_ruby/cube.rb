# frozen_string_literal: true

require_relative 'aabb'
require_relative 'shape'
require_relative 'vector'

module GlisteningRuby
  # An axis aligned unit Cube
  class Cube < Shape
    def initialize
      @aabb = AABB.new([Point[-1, -1, -1], Point[1, 1, 1]])
      super
    end

    def bounds
      @aabb.bounds
    end

    attr_reader :aabb

    private

    def intersections(ray)
      @aabb.intersections(ray)
    end

    def object_normal(point, _hit) # rubocop:disable Metrics/AbcSize
      max = point.map(&:abs).max
      return Vector[point.x, 0, 0] if close?(point.x.abs, max)
      return Vector[0, point.y, 0] if close?(point.y.abs, max)
      return Vector[0, 0, point.z] if close?(point.z.abs, max)
    end
  end
end
