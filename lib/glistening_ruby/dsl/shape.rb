# frozen_string_literal: true

require_relative 'transformable'

module GlisteningRuby
  module DSL
    # Shape builder DSL class
    class Shape < Transformable
      def material(name = nil, *args, &block)
        @material = if name.nil?
                      Material.setup(&block)
                    else
                      Material[name, *args, &block]
                    end
      end

      def shadows(maybe = true)
        @cast_shadows = maybe
      end
    end

    # Cube builder DSL class
    class Cube < Shape
      def instance
        super
        ::GlisteningRuby::Cube.new { |i| copy_ivars(i) }
      end
    end

    # Plane builder DSL class
    class Plane < Shape
      def instance
        super
        ::GlisteningRuby::Plane.new { |i| copy_ivars(i) }
      end
    end

    # Sphere builder DSL class
    class Sphere < Shape
      def instance
        super
        ::GlisteningRuby::Sphere.new { |i| copy_ivars(i) }
      end
    end
  end
end
