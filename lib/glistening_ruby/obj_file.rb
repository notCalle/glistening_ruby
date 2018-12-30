# frozen_string_literal: true

require_relative 'group'

module GlisteningRuby
  # Parse a Wavefront OBJ file
  class ObjFile < Group
    def self.open(filename)
      new(File.open(filename))
    end

    def initialize(input)
      @current_group = self
      @shapes = []
      @groups = {}
      @ignored = 0
      @vertices = [nil]
      input.each_line { |line| parse(line.strip) }
      super()
    end

    attr_reader :ignored, :vertices

    def [](index)
      return super if index.is_a? Integer

      @groups[index.to_sym]
    end

    alias to_group itself
    alias default_group itself

    private

    def parsers
      {
        /^v(?:\s+(?:-?\d+(?:\.\d+)?)){3}$/ => :parse_vertex,
        %r{^f(?:\s+\d+(?:/\d+){0,2}){3}$} => :parse_triangle,
        %r{^f(?:\s+\d+(?:/\d+){0,2}){4,}$} => :parse_polygon,
        /^g\s+(.+)$/ => :parse_group
      }
    end

    def parse(line)
      @ignored += 1 unless parsers.any? do |rex, f|
        if (m = rex.match(line))
          send(f, m)
        end
      end
    end

    def parse_group(matchdata)
      @current_group = @groups[matchdata[1].to_sym] ||= Group.new
      self << @current_group
    end

    def parse_vertex(matchdata)
      @vertices << Point[*matchdata.to_s.split[1..3]]
    end

    def parse_triangle(matchdata)
      vertices = match_to_vertices(matchdata)
      @current_group << Triangle.new(*vertices)
    end

    def parse_polygon(matchdata)
      vertices = match_to_vertices(matchdata)
      v1 = vertices[0]
      1.upto(vertices.size - 2) do |n|
        @current_group << Triangle[v1, vertices[n], vertices[n + 1]]
      end
    end

    def match_to_vertices(matchdata)
      matchdata.to_s.split[1..-1].map { |v| @vertices[v.to_i] }
    end
  end
end
