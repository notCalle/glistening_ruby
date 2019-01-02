# frozen_string_literal: true

require_relative 'transformable'

module GlisteningRuby
  module DSL
    # Shape builder DSL class
    class Shape < Transformable
      def material(name)
        @material = Material[name]
      end
    end
  end
end
