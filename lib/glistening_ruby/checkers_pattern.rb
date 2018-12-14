# frozen_string_literal: true

require_relative 'stripe_pattern'

module GlisteningRuby
  # A cubic checkers pattern
  class CheckersPattern < StripePattern
    def color_at(point)
      super Point[point.xyz.map(&:floor).reduce(&:+), 0, 0]
    end
  end
end
