# frozen_string_literal: true

require_relative 'base'

module GlisteningRuby
  module DSL
    # Camera builder DSL class
    class Camera < Base
      def instance
        ::GlisteningRuby::Camera.new(*@size, @fov) do |i|
          position = @position || Point[0, 0, -2]
          look_at = @look_at || Point[0, 0, 0]
          up = @up || Vector[0, 1, 0]
          i.transform = ViewTransform.new(position, look_at, up)
        end
      end

      def canvas(width, height, fov = '1/8'.to_r)
        @size = [width, height]
        @fov = fov
      end

      def position(p_x, p_y, p_z)
        @position = Point[p_x, p_y, p_z]
      end

      def look_at(p_x, p_y, p_z)
        @look_at = Point[p_x, p_y, p_z]
      end

      def up(v_x, v_y, v_z)
        @up = Vector[v_x, v_y, v_z]
      end
    end
  end
end
