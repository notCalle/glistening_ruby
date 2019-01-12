# frozen_string_literal: true

require_relative 'base'
require_relative 'camera'
require_relative 'light'
require_relative 'shape'
require_relative '../light_dsl'
require_relative '../shape_dsl'

module GlisteningRuby
  module DSL
    # Scene builder DSL class
    class Scene < Base
      def initialize(&block)
        @block = block
      end

      alias instance itself

      def camera(&block)
        @camera = Camera.setup(&block)
      end

      def light(name = nil, *args, &block)
        w = world
        return dsl(LightDSL) { |l| w << l } if name.nil?

        w << Light[name, *args, &block]
      end

      def shape(name = nil, *args, &block)
        w = world
        return dsl(ShapeDSL) { |s| w << s } if name.nil?

        w << Shape[name, *args, &block]
      end

      def render(*args, verbose: false, **kwargs) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Metrics/LineLength
        @world = nil
        @t0 = Time.now
        instance_exec(*args, &@block)
        @world.lights
        @world.objects.bounds
        @t1 = Time.now
        puts " Setup time: #{@t1 - @t0} s" if verbose
        @camera.progress = progress_proc(verbose)
        @canvas = @camera.render(world, **kwargs)
        @t2 = Time.now
        puts "Render time: #{@t2 - @t1} s" if verbose
        puts " Total time: #{@t2 - @t0} s" if verbose
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
          next if pct.zero?

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
