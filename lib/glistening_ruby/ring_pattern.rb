# frozen_string_literal: true

require_relative 'stripe_pattern'

module GlisteningRuby
  # A concentric pattern
  class RingPattern < StripePattern
    def color_at(point)
      super Point[Math.sqrt(point.x**2 + point.z**2), 0, 0]
    end
  end
end
