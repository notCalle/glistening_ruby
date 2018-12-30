# frozen_string_literal: true

require_relative 'base'
module GlisteningRuby
  # Parse a Wavefront OBJ file
  class ObjFile < Base
    def initialize(input)
      @default_group = Group.new
      @ignored = 0
      @vertices = [nil]
      input.lines.map(&:strip).each { |line| parse(line) }
    end

    attr_reader :default_group, :ignored, :vertices

    private

    def parsers
      {
        /^v(?:\s+(?:-?\d+(?:\.\d+)?)){3}$/ =>
        ->(md) { @vertices << parse_vertex(md) },

        /^f(?:\s\d+){3}$/ =>
        ->(md) { @default_group << parse_triangle(md) }
      }
    end

    def parse(line)
      @ignored += 1 unless parsers.any? do |rex, f|
        if (m = rex.match(line))
          f.call(m)
        end
      end
    end

    def parse_vertex(matchdata)
      Point[*matchdata.to_s.split[1..3]]
    end

    def parse_triangle(matchdata)
      vertices = matchdata.to_s.split[1..3].map { |v| @vertices[v.to_i] }
      Triangle.new(*vertices)
    end
  end
end
