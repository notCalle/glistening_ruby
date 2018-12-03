# frozen_string_literal: true

require 'glistening_ruby/canvas'
require 'glistening_ruby/color'
require 'glistening_ruby/matrix'
require 'glistening_ruby/point'
require 'glistening_ruby/ray'
require 'glistening_ruby/rotation'
require 'glistening_ruby/scaling'
require 'glistening_ruby/shearing'
require 'glistening_ruby/sphere'
require 'glistening_ruby/translation'
require 'glistening_ruby/tuple'
require 'glistening_ruby/vector'
require 'glistening_ruby/version'

# Glistening Ruby is my implementation of the Raytracer described in the
# book [The Raytracer Challenge]()
module GlisteningRuby
  EPSILON = 0.00001
  TAU = 6.283185307179586

  def close?(this, that)
    (this - that).abs < EPSILON
  end

  def identity
    Matrix::IDENTITY
  end
end
