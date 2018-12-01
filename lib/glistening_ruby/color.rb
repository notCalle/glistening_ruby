# frozen_string_literal: true

require_relative 'tuple'

module GlisteningRuby
  # Helper for creating and identifying RGB Colors as 4D Tuples
  module Color
    def self.[](red, green, blue)
      Tuple[red, green, blue, 0.0]
    end
  end
end
