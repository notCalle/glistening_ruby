# frozen_string_literal: true

require_relative 'tuple'

module GlisteningRuby
  # Helper for creating and identifying RGB Colors as 4D Tuples
  module Color
    def self.[](red, green, blue)
      Tuple[red, green, blue, 0.0]
    end
  end

  Color::BLACK = Color[0, 0, 0]
  Color::WHITE = Color[1, 1, 1]
  Color::RED   = Color[1, 0, 0]
  Color::GREEN = Color[0, 1, 0]
  Color::BLUE  = Color[0, 0, 1]
end
