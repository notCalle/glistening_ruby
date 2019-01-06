# frozen_string_literal: true

require 'forwardable'
require_relative 'bounding_tree'
require_relative 'shape'

module GlisteningRuby
  # A container with shapes inside
  class Container < Shape
    extend Forwardable
    include Enumerable

    def initialize
      @shapes ||= []
      super
    end

    def include?(other)
      super || @shapes.any? { |s| s.include? other }
    end

    def <<(other)
      other.parent = self
    end

    def_delegators :@shapes, :empty?, :each, :[]

    def append(child)
      raise 'Can only append my children' unless child.parent == self

      reset_cache
      @shapes.append child
    end

    def delete(child)
      raise 'Can only delete my children' if child.parent == self

      reset_cache
      @shapes.delete child
      child.parent = nil
    end

    private

    def shapes=(shapes)
      shapes.each { |s| self << s }
    end
  end
end
