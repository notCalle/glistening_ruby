# frozen_string_literal: true

require 'glistening_ruby/camera'
require 'glistening_ruby/canvas'
require 'glistening_ruby/color'
require 'glistening_ruby/cone'
require 'glistening_ruby/csg'
require 'glistening_ruby/cube'
require 'glistening_ruby/cylinder'
require 'glistening_ruby/group'
require 'glistening_ruby/intersection'
require 'glistening_ruby/intersections'
require 'glistening_ruby/lights'
require 'glistening_ruby/matrix'
require 'glistening_ruby/material'
require 'glistening_ruby/obj_file'
require 'glistening_ruby/patterns'
require 'glistening_ruby/plane'
require 'glistening_ruby/point'
require 'glistening_ruby/point_light'
require 'glistening_ruby/ray'
require 'glistening_ruby/rotation'
require 'glistening_ruby/scaling'
require 'glistening_ruby/shape'
require 'glistening_ruby/shearing'
require 'glistening_ruby/smooth_triangle'
require 'glistening_ruby/sphere'
require 'glistening_ruby/translation'
require 'glistening_ruby/triangle'
require 'glistening_ruby/tuple'
require 'glistening_ruby/vector'
require 'glistening_ruby/version'
require 'glistening_ruby/view_transform'
require 'glistening_ruby/world'

# Glistening Ruby is my implementation of the Raytracer described in the
# book [The Raytracer Challenge]()
module GlisteningRuby
  EPSILON = 0.00001
  TAU = 6.283185307179586
end
