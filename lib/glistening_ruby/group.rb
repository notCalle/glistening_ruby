# frozen_string_literal: true

require 'forwardable'
require_relative 'shape'

module GlisteningRuby
  # A group of shapes
  class Group < Shape
    extend Forwardable

    def initialize(*)
      @shapes = Set[]
      super
    end

    def <<(other)
      raise "#{other} already has a parent" unless other.parent.nil?

      @shapes << other
      other.parent = self
    end

    def_delegators :@shapes, :empty?, :include?
  end
end
