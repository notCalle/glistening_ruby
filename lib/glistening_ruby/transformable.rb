# frozen_string_literal: true

require_relative 'base'

module GlisteningRuby
  # Abstract transformable object
  class Transformable < Base
    attr_reader :parent

    def transform
      @transform ||= Matrix::IDENTITY
    end

    def transform=(transform)
      reset_cache
      @transform = transform
    end

    def inverse
      cache[:inverse] ||= transform.inverse
    end

    def inverse_transpose
      cache[:inverse_transpose] ||= transform.submatrix(3, 3).inverse.transpose
    end

    # Transform a point in outer space to local space
    #
    # :call-seq:
    #   to_local(outer_point) => local_point
    #
    def to_local(point)
      inverse * point
    end

    # Transform a point in local space to outer space
    #
    # :call-seq:
    #   to_outer(local_point) => outer_point
    #
    def to_outer(point)
      transform * point
    end

    def object_to_world(point)
      world_transform * point
    end

    def normal_to_world(vector)
      (world_inverse_transpose * vector).normalize
    end

    def world_to_object(point)
      world_inverse * point
    end

    protected

    def parent=(parent)
      reset_cache
      unless parent
        @parent = nil
        return
      end
      @parent&.delete(self)
      @parent = parent
      @parent.append(self)
    end

    def world_inverse
      return inverse if parent.nil?

      cache[:world_inverse] ||= world_transform.inverse
    end

    def world_inverse_transpose
      return inverse_transpose if parent.nil?

      cache[:world_inverse_transpose] ||=
        world_transform.submatrix(3, 3).inverse.transpose
    end

    def world_transform
      return transform if parent.nil?

      cache[:world_transform] ||= parent.world_transform * transform
    end
  end
end
