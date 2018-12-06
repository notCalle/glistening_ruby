# frozen_string_literal: true

require_relative 'matrix_private'
require_relative 'matrix_transforms'

module GlisteningRuby
  # A square matrix
  class Matrix
    include MatrixPrivate
    include MatrixTransforms

    def self.[](*rows)
      new(*rows)
    end

    def initialize(*rows)
      size, = *rows
      if size.is_a?(Numeric)
        initialize_identity(size)
      else
        initialize_from_arrays(rows)
      end
      yield self if block_given?

      deep_freeze
    end

    def to_s
      +'[' << @rows.map { |r| row_to_s(r) }.join("\n ") << ']'
    end

    def inspect
      "#<#{self.class}: #{size}x#{size}\n#{self}>"
    end

    def [](row, col)
      @rows[row][col]
    end

    def ==(other)
      each_element do |element, row, col|
        return false unless close?(element, other[row, col])
      end
      true
    end

    attr_reader :size

    def *(other)
      case other
      when Matrix
        multiply_matrix_by_matrix(other)
      when Tuple
        multiply_matrix_by_tuple(other)
      end
    end

    def cofactor(row, col)
      minor(row, col) * ((row + col).odd? ? -1 : 1)
    end

    def determinant
      return determinant_2x2 if size == 2

      0.upto(size - 1).reduce(0) do |result, col|
        result + self[0, col] * cofactor(0, col)
      end
    end

    # Matrix of cofactors / determinant, and transposed
    def inverse
      raise 'not invertible' unless invertible?

      Matrix.new(size) do |result|
        det = determinant
        each_row_col do |row, col|
          result[col, row] = cofactor(row, col) / det
        end
      end
    end

    def invertible?
      !determinant.zero?
    end

    def minor(row, col)
      submatrix(row, col).determinant
    end

    def submatrix(drop_row, drop_col)
      result = []
      0.upto(size - 1) do |row|
        next if row == drop_row

        new_row = []
        0.upto(size - 1) do |col|
          new_row << self[row, col] unless col == drop_col
        end
        result << new_row
      end
      Matrix.new(*result)
    end

    def transpose
      Matrix.new(size) do |result|
        each_element do |element, row, col|
          result[col, row] = element
        end
      end
    end

    protected

    attr_reader :rows

    def []=(row, col, new_value)
      @rows[row][col] = new_value
    end
  end

  Matrix::IDENTITY = Matrix.new(4)
end