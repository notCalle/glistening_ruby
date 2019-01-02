# frozen_string_literal: true

require_relative 'base'

module GlisteningRuby
  module DSL
    # Shape builder DSL class
    class Shape < Base
      def material(name)
        @material = Material[name]
      end

      def rotate(**axes)
        axes.each do |axis, rotation|
          @transform = transform.send("rotate_#{axis}", rotation)
        end
      end

      def scale(*args)
        @transform = transform.scale(*args)
      end

      def translate(*args)
        @transform = transform.translate(*args)
      end

      def shear(*args)
        @transform = transform.shear(*args)
      end

      private

      def transform
        @transform || ::GlisteningRuby::Matrix::IDENTITY
      end
    end
  end
end
