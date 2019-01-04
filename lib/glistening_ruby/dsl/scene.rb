# frozen_string_literal: true

require_relative 'base'
require_relative 'camera'
require_relative 'light'
require_relative 'shape'
require_relative '../shape_dsl'

module GlisteningRuby
  module DSL
    # Scene builder DSL class
    class Scene < Base
      alias instance itself

      def camera(&block)
        @camera = Camera.setup(&block)
      end

      def light(&block)
        world << Light.setup(&block)
      end

      def shape(name = nil, *args, &block)
        w = world
        return dsl(ShapeDSL) { |s| w << s } if name.nil?

        w << Shape[name, *args, &block]
      end

      def render(*args, verbose: false, **kwargs)
        @t0 = Time.now
        @camera.progress = progress_proc(verbose)
        @canvas = @camera.render(world, *args, **kwargs)
        puts "Rendering time: #{Time.now - @t0} s" if verbose
      end

      def save(filename)
        File.open(filename, 'w') do |file|
          @canvas.to_ppm(file)
        end
      end

      private

      def progress_proc(verbose) # rubocop:disable Metrics/AbcSize
        return unless verbose

        h = @camera.h
        w = @camera.w
        lambda do |x, y|
          pct = Rational(y * w + x, w * h)
          next @t1 = Time.now if pct.zero?

          t2 = Time.now
          STDOUT << "#{(pct * 100).to_i}% done, "
          STDOUT << "#{((t2 - @t1) * (1.0 - pct) / pct).to_i} s to go.  \r"
        end
      end

      def world
        @world ||= World.new
      end
    end
  end
end
