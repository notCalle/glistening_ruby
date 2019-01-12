# frozen_string_literal: true

require 'yaml'
require_relative 'base'
require_relative 'matrix'

module GlisteningRuby
  # The camera that renders the world
  class Camera < Base
    def initialize(width, height, fov)
      @w = width
      @h = height
      @fov = fov
      aspect_ratio = Rational(width, height)
      initialize_half(aspect_ratio, fov)
      @pixel_size = (@half_width * 2) / width
      self.transform = Matrix::IDENTITY
      super
    end

    attr_reader :fov, :h, :pixel_size, :transform, :w
    attr_writer :progress

    def transform=(transform)
      @transform = transform
      @inverse = transform.inverse
    end

    def ray_for_pixel(px_x, px_y)
      offset_x = (px_x + 0.5) * @pixel_size
      offset_y = (px_y + 0.5) * @pixel_size
      world_point = Point[@half_width - offset_x, @half_height - offset_y, -1]
      pixel = @inverse * world_point
      origin = @inverse * Point::ZERO
      direction = (pixel - origin).normalize
      Ray.new(origin, direction)
    end

    def render(world, limit: World::RECURSION_LIMIT, threads: 1)
      return render_threaded(world, threads, limit) if threads > 1

      Canvas.new(@w, @h) do |canvas|
        canvas.each do |_, x, y|
          ray = ray_for_pixel(x, y)
          canvas[x, y] = world.color_at ray, limit
          @progress&.call(x, y)
        end
      rescue Interrupt
        canvas
      end
    end

    private

    def render_threaded(world, threads, limit) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Metrics/LineLength
      jobs = []
      Canvas.new(@w, @h) do |canvas|
        canvas.each_line do |l, y|
          file = Tempfile.new(["line-#{y}-", '.yaml'])
          pid = Process.fork do
            file.write render_line(world, @w, y, limit).to_yaml
            file.rewind
          end
          jobs[pid] = { file: file, line: l }
          next if y + 1 < threads

          pid, = Process.waitpid2
          job = jobs[pid]
          job[:line].replace YAML.safe_load(job[:file])
          job[:file].close!
          @progress&.call(@w - 1, y)
        end
      rescue Interrupt
        canvas
      ensure
        Process.waitall.each do |pid, _|
          job = jobs[pid]
          job[:line].replace YAML.safe_load(job[:file])
          job[:file].close!
        end
      end
    end

    def render_line(world, width, y_pos, limit)
      0.upto(width - 1).with_object([]) do |x, result|
        ray = ray_for_pixel(x, y_pos)
        result << world.color_at(ray, limit)
      end
    end

    def initialize_half(aspect, fov)
      half_view = Math.tan(fov * Math::PI)
      if aspect >= 1
        @half_width = half_view
        @half_height = half_view / aspect
      else
        @half_height = half_view
        @half_width = half_view * aspect
      end
    end
  end
end
