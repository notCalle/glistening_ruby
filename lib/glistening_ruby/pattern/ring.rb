# frozen_string_literal: true

require_relative 'stripe'

module GlisteningRuby
  module Pattern
    # A concentric ring pattern
    class Ring < Stripe
      private

      def grade(point)
        Math.sqrt(point.x**2 + point.z**2)
      end
    end
  end
end
