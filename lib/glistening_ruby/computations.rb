# frozen_string_literal: true

module GlisteningRuby
  # Prepared computations for a ray at an intersection
  class Computations
    def initialize(hit, ray, intersections)
      @hit = hit
      @ray = ray
      @intersections = intersections
      @point_t = ray.position(t)
      @object_normal = object.normal_at(@point_t, hit)
    end

    def inside?
      @inside ||= @object_normal.dot(eyev).negative?
    end

    def total_internal_reflection?
      !refractv
    end

    # sin(theta_i)   n_2
    # ------------ = ---
    # sin(theta_t)   n_1
    def refractv # rubocop:disable Metrics/AbcSize
      return @refractv unless @refractv.nil?

      n_ratio = n1 / n2
      cos_i = eyev.dot normalv
      sin2_t = n_ratio**2 * (1 - cos_i**2)
      return @refractv = false if sin2_t > 1

      cos_t = Math.sqrt(1.0 - sin2_t)
      @refractv = normalv * (n_ratio * cos_i - cos_t) - eyev * n_ratio
    end

    # https://graphics.stanford.edu/courses/cs148-10-summer/docs/2006--degreve--reflection_refraction.pdf
    def schlick # rubocop:disable Metrics/AbcSize
      cos = eyev.dot normalv
      if n1 > n2
        n_ratio = n1 / n2
        sin2_t = n_ratio**2 * (1 - cos**2)
        return 1.0 if sin2_t > 1

        cos = Math.sqrt(1.0 - sin2_t)
      end
      r0 = ((n1 - n2) / (n1 + n2))**2
      r0 + (1 - r0) * (1 - cos)**5
    end

    def eyev
      @eyev ||= -@ray.direction
    end

    def material
      @material ||= object.material
    end

    def n1
      @n1 || (initialize_refraction && @n1)
    end

    def n2
      @n2 || (initialize_refraction && @n2)
    end

    def normalv
      @normalv ||= inside? ? -@object_normal : @object_normal
    end

    def object
      @object ||= @hit.object
    end

    def point
      @point ||= @point_t + normalv * EPSILON
    end

    def reflectv
      @reflectv = @ray.direction.reflect(normalv)
    end

    def t
      @t ||= @hit.t
    end

    def under_point
      @under_point ||= @point_t - normalv * EPSILON
    end

    private

    def initialize_refraction
      @intersections.each.with_object([]) do |i, c|
        @n1 = last_refractive_index(c) if i == @hit
        toggle_object(i.object, c)
        @n2 = last_refractive_index(c) if i == @hit
        break true if i == @hit
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
