# frozen_string_literal: true

require_relative 'base'

module GlisteningRuby
  module Pattern
    # A gradient pattern
    class Gradient < Base
      private

      def constrain(value)
        value % 1
      end
    end
  end
end
