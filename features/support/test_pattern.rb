# frozen_string_literal: true

require 'glistening_ruby/intersections'
require 'glistening_ruby/pattern/base'

# Test subclass of pattern
class TestPattern < GlisteningRuby::Pattern::Base
  def color_at(point)
    Color[*point.xyz]
  end
end
