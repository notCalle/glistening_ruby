# frozen_string_literal: true

require_relative 'tuple'

module GlisteningRuby
  # Helper for creating and identifying RGB Colors as 4D Tuples
  class Color < Tuple
    def new(_red, _green, _blue, _alpha = 0.0)
      super
    end
    end
  end

  Color::BLACK = Color.new(0, 0, 0)
  Color::WHITE = Color.new(1, 1, 1)
  Color::RED   = Color.new(1, 0, 0)
  Color::GREEN = Color.new(0, 1, 0)
  Color::BLUE  = Color.new(0, 0, 1)
end
