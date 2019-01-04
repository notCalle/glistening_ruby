# frozen_string_literal: true

require_relative '../color'

Module.new do
  extend GlisteningRuby::DSL::ColorSpace
  {
    white: grey(1),
    black: grey(0),
    red: rgb(1, 0, 0),
    green: rgb(0, 1, 0),
    yellow: rgb(1, 1, 0),
    blue: rgb(0, 0, 1),
    magenta: rgb(1, 0, 1),
    cyan: rgb(0, 1, 1)
  }.each do |name, color|
    GlisteningRuby::DSL::Color.define(name) { @color = color }
  end
end
