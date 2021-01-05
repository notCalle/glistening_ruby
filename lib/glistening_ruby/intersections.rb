# frozen_string_literal: true

require 'forwardable'
require_relative 'base'
require_relative 'intersection'

module GlisteningRuby
  # A set of intersections
  class Intersections < Base
    extend Forwardable
    include Enumerable

    def self.for_object(object, *intersections)
      new(*intersections.map { |i| Intersection.new(i, object) })
    end

    def initialize(*intersections) # rubocop:disable Lint/MissingSuper
      @intersections = []
      @hit = nil
      self << intersections
    end

    def <<(intersections)
      intersections.each do |intersection|
        @intersections << intersection
        next unless intersection.positive?
        next if @hit && @hit < intersection

        @hit = intersection
      end
      @intersections.sort!
      self
    end

    attr_reader :hit

    def_delegators :@intersections, :each, :[], :empty?
  end
end
