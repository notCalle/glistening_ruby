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
      @normals = [nil]
      @vertices = [nil]
      input.each_line { |line| parse(line.strip) }
      super()
    end

    attr_reader :ignored, :normals, :vertices

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
        /^vn(?:\s+(?:-?\d+(?:\.\d+)?)){3}$/ => :parse_normal,
        %r{^f(?:\s+\d+(?:/\d*){0,2}){3,}$} => :parse_polygon,
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

    def parse_normal(matchdata)
      @normals << Vector[*matchdata.to_s.split[1..3]]
    end

    def parse_polygon(matchdata)
      face = match_to_faceinfo(matchdata)
      v1 = face[0][0]
      n1 = face[0][2]
      1.upto(face.size - 2) do |n|
        @current_group << face_to_triangle(face, v1, n1, n)
      end
    end

    def face_to_triangle(face, vtx1, nml1, step) # rubocop:disable Metrics/AbcSize
      f2 = face[step]
      f3 = face[step + 1]
      if nml1.nil? || nml1.zero?
        Triangle[@vertices[vtx1], @vertices[f2[0]], @vertices[f3[0]]]
      else
        SmoothTriangle[@vertices[vtx1], @vertices[f2[0]], @vertices[f3[0]],
                       @normals[nml1], @normals[f2[2]], @normals[f3[2]]]
      end
    end

    # 1/2/3 => [1, 2, 3]
    def match_to_faceinfo(matchdata)
      matchdata.to_s.split[1..].map { |v| v.split('/').map(&:to_i) }
    end
  end
end
