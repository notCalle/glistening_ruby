# frozen_string_literal: true

require_relative 'base'

module GlisteningRuby
  module Light
    # A distant parallelly radiating light source
    class Parallel < Base
      def direction(_point)
        cache[:direction] ||= object_to_world Vector[0, 0, -1]
      end

      def distance(_point)
        Float::INFINITY
      end

      def intensity(_point)
        @intensity
      end
    end
  end
end
