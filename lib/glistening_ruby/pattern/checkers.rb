# frozen_string_literal: true

require_relative 'stripe'

module GlisteningRuby
  module Pattern
    # A cubic checkers pattern
    class Checkers < Base
      private

      def grade(point)
        point.xyz.map(&:floor).reduce(&:+).floor
      end
    end
  end
end
