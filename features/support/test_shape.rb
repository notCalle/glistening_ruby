# frozen_string_literal: true

require 'glistening_ruby/intersections'
require 'glistening_ruby/shape'

# Test subclass of shape
class TestShape < GlisteningRuby::Shape
  attr_reader :local_ray

  private

  def intersections(ray)
    @local_ray = ray
    Intersections.new
  end
end
