# frozen_string_literal: true

require_relative 'pattern'

module GlisteningRuby
  module DSL
    # Checkers pattern builder DSL class
    class Checkers < Pattern
      def instance
        super
        ::GlisteningRuby::Pattern::Checkers.new { |i| copy_ivars(i) }
      end
    end
  end
end
