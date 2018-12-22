# frozen_string_literal: true

module GlisteningRuby
  # Prepared computations for a ray at an intersection
  class Computations
    def initialize(hit, ray, intersections)
      initialize_hit(hit)
      initialize_ray(ray)
      initialize_refraction(hit, intersections)

      @inside = @normalv.dot(@eyev).negative?
      @normalv = -@normalv if @inside
      @under_point = @point - @normalv * EPSILON
      @point += @normalv * EPSILON
    end

    def inside?
      @inside
    end

    def fresnel?
      m = @object.material
      m.reflective.positive? && m.transparency.positive?
    end

    def total_internal_reflection?
      refractv.nil?
    end

    # sin(theta_i)   n_2
    # ------------ = ---
    # sin(theta_t)   n_1
    def refractv # rubocop:disable Metrics/AbcSize
      return @refractv unless @refractv.nil?

      n_ratio = @n1 / @n2
      cos_i = @eyev.dot @normalv
      sin2_t = n_ratio**2 * (1 - cos_i**2)
      return if sin2_t > 1

      cos_t = Math.sqrt(1.0 - sin2_t)
      @refractv = @normalv * (n_ratio * cos_i - cos_t) - @eyev * n_ratio
    end

    # https://graphics.stanford.edu/courses/cs148-10-summer/docs/2006--degreve--reflection_refraction.pdf
    def schlick # rubocop:disable Metrics/AbcSize
      cos = @eyev.dot @normalv
      if n1 > n2
        n_ratio = @n1 / @n2
        sin2_t = n_ratio**2 * (1 - cos**2)
        return 1.0 if sin2_t > 1

        cos = Math.sqrt(1.0 - sin2_t)
      end
      r0 = ((@n1 - @n2) / (@n1 + @n2))**2
      r0 + (1 - r0) * (1 - cos)**5
    end

    attr_reader :eyev, :n1, :n2, :normalv, :object, :point, :reflectv, :t
    attr_reader :under_point

    private

    def initialize_hit(hit)
      @t = hit.t
      @object = hit.object
    end

    def initialize_ray(ray)
      @point = ray.position(@t)
      @eyev = -ray.direction
      @normalv = @object.normal_at(@point)
      @reflectv = ray.direction.reflect(@normalv)
    end

    def initialize_refraction(hit, intersections)
      intersections.each.with_object([]) do |i, c|
        @n1 = last_refractive_index(c) if i == hit
        toggle_object(i.object, c)
        @n2 = last_refractive_index(c) if i == hit
        break if i == hit
      end
    end

    def last_refractive_index(container)
      container.last&.material&.refractive_index || 1.0
    end

    def toggle_object(object, container)
      container << object unless container.reject! { |o| o == object }
    end
  end
end
