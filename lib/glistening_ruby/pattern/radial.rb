# frozen_string_literal: true

require_relative 'stripe'

module GlisteningRuby
  module Pattern
    # A radial gradient pattern
    class Radial < Base
      private

      def grade(point)
        Math.sqrt(point.x**2 + point.z**2)
      end
    end
  end
end
