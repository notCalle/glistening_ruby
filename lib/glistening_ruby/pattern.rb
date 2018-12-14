# frozen_string_literal: true

require_relative 'transformable'

module GlisteningRuby
  # An abstract base pattern
  class Pattern < Transformable
    def color_at_object(object, point)
      object_point = object.inverse * point
      pattern_point = @inverse * object_point
      color_at(pattern_point)
    end
  end
end
