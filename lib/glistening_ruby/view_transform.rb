# frozen_string_literal: true

require_relative 'matrix'

module GlisteningRuby
  # 4x4 Translation matrix for 3D vector space
  class ViewTransform < Matrix
    def initialize(origin = Point[0, 0, 0], # rubocop:disable Lint/MissingSuper
                   look_at = Point[0, 0, -1],
                   upish = Vector[0, 1, 0])
      leftward, upward, backward = initialize_vectors(origin, look_at, upish)
      orientation = Matrix[leftward.to_a,
                           upward.to_a,
                           backward.to_a,
                           [0, 0, 0, 1]]
      @a = (orientation * Translation.new(*(-origin).xyz)).a
      @rows = @cols = 4
    end

    private

    def initialize_vectors(origin, look_at, upish)
      forward = (look_at - origin).normalize
      upish = upish.normalize
      leftward = forward.cross upish
      upward = leftward.cross forward
      [leftward, upward, -forward]
    end
  end
end
