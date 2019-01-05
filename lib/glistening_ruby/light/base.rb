# frozen_string_literal: true

require_relative '../transformable'
require_relative '../color'

module GlisteningRuby
  module Light
    # An abstract light source
    class Base < Transformable
      def initialize(intensity = Color::WHITE)
        @intensity = intensity
        super
      end

      def direction(_point)
        raise NotImplementedError
      end

      def intensity(_point)
        raise NotImplementedError
      end
    end
  end
end
