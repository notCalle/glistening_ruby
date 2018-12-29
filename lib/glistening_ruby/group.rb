# frozen_string_literal: true

require 'forwardable'
require_relative 'shape'

module GlisteningRuby
  # A group of shapes
  class Group < Shape
    extend Forwardable

    def initialize(*)
      @shapes = []
      super
    end

    def_delegators :@shapes, :empty?
  end
end
