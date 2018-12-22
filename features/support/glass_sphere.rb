# frozen_string_literal: true

require 'glistening_ruby/material'
require 'glistening_ruby/sphere'

# A glassy sphere
class GlassSphere < GlisteningRuby::Sphere
  def initialize
    super

    material.transparency = 1.0
    material.refractive_index = 1.5
  end
end
