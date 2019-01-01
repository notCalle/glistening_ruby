# frozen_string_literal: true

require_relative 'point'
require_relative 'triangle'

module GlisteningRuby
  # A triangle
  class SmoothTriangle < Triangle
    def initialize(vertex1, vertex2, vertex3, *normals)
      @n1, @n2, @n3 = normals
      super(vertex1, vertex2, vertex3)
    end

    attr_reader :n1, :n2, :n3

    def object_normal(_point, hit)
      @n2 * hit.u + @n3 * hit.v + @n1 * (1 - hit.u - hit.v)
    end

    def uv
      [@u, @v]
    end
  end
end
