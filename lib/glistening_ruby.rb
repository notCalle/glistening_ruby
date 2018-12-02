# frozen_string_literal: true

require 'glistening_ruby/canvas'
require 'glistening_ruby/color'
require 'glistening_ruby/matrix'
require 'glistening_ruby/point'
require 'glistening_ruby/translation'
require 'glistening_ruby/tuple'
require 'glistening_ruby/vector'
require 'glistening_ruby/version'

# Glistening Ruby is my implementation of the Raytracer described in the
# book [The Raytracer Challenge]()
module GlisteningRuby
  EPSILON = 0.00001

  def close?(this, that)
    (this - that).abs < EPSILON
  end
end
