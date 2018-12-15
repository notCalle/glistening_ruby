# frozen_string_literal: true

require_relative 'base'

module GlisteningRuby
  module Pattern
    # A striped pattern
    class Stripe < Base
      private

      def grade(point)
        point.x.floor
      end
    end
  end
end
