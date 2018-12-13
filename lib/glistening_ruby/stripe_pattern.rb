# frozen_string_literal: true

module GlisteningRuby
  # A striped pattern
  class StripePattern < Base
    def initialize(color_a, color_b)
      @a = color_a
      @b = color_b
      super
      freeze
    end

    attr_reader :a, :b

    def color_at(point)
      (point.x.floor % 2).zero? ? @a : @b
    end
  end
end
