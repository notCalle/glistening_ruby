# frozen_string_literal: true

require_relative 'base'
module GlisteningRuby
  # Parse a Wavefront OBJ file
  class ObjFile < Base
    def initialize(input)
      @ignored = 0
      input.lines.map(&:strip).each { |line| parse(line) }
    end

    attr_reader :ignored

    private

    def parse(_line)
      @ignored += 1
    end
  end
end
