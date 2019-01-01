# frozen_string_literal: true

require 'glistening_ruby/intersections'
require 'glistening_ruby/shape'

# Test subclass of shape
class TestShape < GlisteningRuby::Shape
  attr_reader :local_ray

  def bounds
    [Point[-1, -1, -1],
     Point[0, 0, 0]]
  end

  private

  def intersections(ray)
    @local_ray = ray
    Intersections.new
  end

  def object_normal(point, _hit)
    point - Point::ZERO
  end
end
