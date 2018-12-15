# frozen_string_literal: true

require_relative 'stripe'

module GlisteningRuby
  module Pattern
    # A concentric ring pattern
    class Ring < Base
      private

      def grade(point)
        Math.sqrt(point.x**2 + point.z**2).floor
      end
    end
  end
end
