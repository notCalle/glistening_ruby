# frozen_string_literal: true

require_relative 'base'

module GlisteningRuby
  module Pattern
    # A striped pattern
    class Stripe < Base
      private

      def constrain(value)
        value.floor % 2
      end
    end
  end
end
