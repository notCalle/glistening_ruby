# frozen_string_literal: true

require_relative 'stripe'

module GlisteningRuby
  module Pattern
    # A cubic checkers pattern
    class Checkers < Stripe
      private

      def grade(point)
        point.xyz.map(&:floor).reduce(&:+)
      end
    end
  end
end
