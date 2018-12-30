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
        /^v(?:\s+(?:-?\d+(?:\.\d+)?)){3}$/ => :parse_vertex,
        /^f(?:\s\d+){3}$/ => :parse_triangle,
        /^f(?:\s\d+){4,}$/ => :parse_polygon
      }
    end

    def parse(line)
      @ignored += 1 unless parsers.any? do |rex, f|
        if (m = rex.match(line))
          send(f, m)
        end
      end
    end

    def parse_vertex(matchdata)
      @vertices << Point[*matchdata.to_s.split[1..3]]
    end

    def parse_triangle(matchdata)
      vertices = match_to_vertices(matchdata)
      @default_group << Triangle.new(*vertices)
    end

    def parse_polygon(matchdata)
      vertices = match_to_vertices(matchdata)
      v1 = vertices[0]
      1.upto(vertices.size - 2) do |n|
        @default_group << Triangle[v1, vertices[n], vertices[n + 1]]
      end
    end

    def match_to_vertices(matchdata)
      matchdata.to_s.split[1..-1].map { |v| @vertices[v.to_i] }
    end
  end
end
