# frozen_string_literal: true

require_relative 'base'
module GlisteningRuby
  # Parse a Wavefront OBJ file
  class ObjFile < Base
    def initialize(input)
      @ignored = 0
      @vertices = [nil]
      input.lines.map(&:strip).each { |line| parse(line) }
    end

    attr_reader :ignored, :vertices

    private

    def parsers
      {
        /^v(?:\s+(?:-?\d+(?:\.\d+)?)){3}$/ =>
          ->(md) { @vertices << Point[*md.to_s.split[1..3]] }
      }
    end

    def parse(line)
      @ignored += 1 unless parsers.any? do |rex, f|
        if (m = rex.match(line))
          f.call(m)
        end
      end
    end
  end
end
