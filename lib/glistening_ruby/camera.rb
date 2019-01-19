# frozen_string_literal: true

require 'yaml'
require_relative 'base'
require_relative 'color'
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

    def render(world, threads: 1, **options)
      return render_threaded(world, threads, **options) if threads > 1

      Canvas.new(@w, @h) do |canvas|
        canvas.each do |_, x, y|
          canvas[x, y] = color_for_pixel(world, x, y, **options)
          @progress&.call(x, y)
        end
      rescue Interrupt
        canvas
      end
    end

    private

    # rubocop:disable Security/MarshalLoad
    def render_threaded(world, threads, **options) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Metrics/LineLength
      jobs = []
      Canvas.new(@w, @h) do |canvas|
        canvas.each_line do |l, y|
          file = Tempfile.new(["line-#{y}-", '.yaml'])
          pid = Process.fork do
            Marshal.dump render_line(world, @w, y, **options), file
            file.rewind
          end
          jobs[pid] = { file: file, line: l }
          next if y + 1 < threads

          pid, = Process.waitpid2
          job = jobs[pid]
          job[:line].replace Marshal.load(job[:file])
          job[:file].close!
          @progress&.call(@w - 1, y)
        end
      rescue Interrupt
        canvas
      ensure
        Process.waitall.each do |pid, _|
          job = jobs[pid]
          job[:line].replace Marshal.load(job[:file])
          job[:file].close!
        end
      end
    end
    # rubocop:enable Security/MarshalLoad

    def render_line(world, width, y_pos, **options)
      0.upto(width - 1).with_object([]) do |x, result|
        result << color_for_pixel(world, x, y_pos, **options)
      end
    end

    def color_for_pixel(world, px_x, px_y,
                        ssaa: false, limit: World::RECURSION_LIMIT)
      return color_for_ssaa(world, px_x, px_y, ssaa, limit) if ssaa

      ray = ray_for_pixel(px_x, px_y)
      world.color_at(ray, limit)
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def color_for_ssaa(world, px_x, px_y, samples, limit)
      step = 1.0 / samples
      offset = - 0.5 / samples
      c = Color::BLACK
      1.upto(samples) do |ssx|
        1.upto(samples) do |ssy|
          ray = ray_for_pixel(px_x + offset + step * ssx,
                              px_y + offset + step * ssy)
          c += world.color_at(ray, limit)
        end
      end
      c / samples**2
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

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
