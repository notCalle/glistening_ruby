# frozen_string_literal: true

require 'perlin'
require_relative 'stripe'

module GlisteningRuby
  module Pattern
    # A perturbing pattern
    class Perturb < Base
      def initialize(*)
        @seed = 1
        @persistence = 1.0
        @octaves = 1
        @magnitude = 0.1
        super
      end

      attr_accessor :magnitude
      attr_reader :octaves, :persistence, :seed

      def octaves=(octaves)
        @generator = nil
        @octaves = octaves
      end

      def persistence=(persistence)
        @generator = nil
        @persistence = persistence
      end

      def seed=(seed)
        @generator = nil
        @seed = seed
      end

      def generator
        @generator ||= Perlin::Generator.new @seed, @persistence, @octaves
      end

      def color_at(point)
        point = to_local(point)
        noise = generator.chunk(*point.xyz, 1, 1, 3, 1).flatten
        @a.color_at(point + Point[*noise] * @magnitude)
      end
    end
  end
end
