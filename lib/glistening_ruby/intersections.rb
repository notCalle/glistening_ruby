# frozen_string_literal: true

require 'forwardable'
require_relative 'base'
require_relative 'intersection'

module GlisteningRuby
  # A set of intersections
  class Intersections < Base
    extend Forwardable
    include Enumerable

    def initialize(*intersections)
      @intersections = []
      @hit = nil
      self << intersections
    end

    def <<(intersections)
      intersections.each do |intersection|
        if intersection.positive?
          @hit = intersection unless @hit && @hit < intersection
        end
        @intersections << intersection
      end
      @intersections.sort!
    end

    attr_reader :hit

    def_delegators :@intersections, :each, :[]
  end
end
