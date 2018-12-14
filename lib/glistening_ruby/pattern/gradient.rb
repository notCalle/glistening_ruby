# frozen_string_literal: true

require_relative 'base'

module GlisteningRuby
  module Pattern
    # A gradient pattern
    class Gradient < Base
      private

      def grade(point)
        point.x
      end
    end
  end
end
