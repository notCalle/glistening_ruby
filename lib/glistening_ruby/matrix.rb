# frozen_string_literal: true

require_relative 'base'
require_relative 'matrix_private'
require_relative 'matrix_transforms'

module GlisteningRuby
  # A square matrix
  class Matrix < Base # rubocop:disable Metrics/ClassLength
    include MatrixPrivate
    include MatrixTransforms

    def initialize(*rows)
      size, = *rows
      if size.is_a?(Numeric)
        initialize_identity(size)
        @identity_matrix = !block_given?
      else
        initialize_from_arrays(rows)
      end

      super
    end

    def to_s
      +'[' << each_row.map { |r| row_to_s(r) }.join("\n ") << ']'
    end

    def inspect
      "#<#{self.class}: #{size}x#{size}\n#{self}>"
    end

    def [](row, col)
      @a[row * @cols + col]
    end

    def ==(other)
      each_element do |element, row, col|
        return false unless close?(element, other[row, col])
      end
      true
    end

    attr_reader :cols, :rows

    def each_row
      return to_enum(__method__) { @rows } unless block_given?

      0.upto(@rows - 1) do |r|
        s = r * @cols
        yield @a[s..(s + @cols - 1)]
      end
    end

    def each_col
      return to_enum(__method__) { @cols } unless block_given?

      0.upto(@cols - 1) do |c|
        yield (0.upto(@rows - 1).with_object([]) do |r, result|
          result << @a[r * @cols + c]
        end)
      end
    end

    def *(other)
      return other if identity_matrix?

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
      return self if identity_matrix?
      raise 'not invertible' unless invertible?

      Matrix.new(size) do |result|
        det = determinant
        each_row_col do |row, col|
          result[col, row] = cofactor(row, col) / det
        end
      end
    end

    def identity_matrix?
      @identity_matrix
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
      return self if identity_matrix?

      Matrix.new(size) do |result|
        each_element do |element, row, col|
          result[col, row] = element
        end
      end
    end

    def size
      return @cols if @cols == @rows

      [@rows, @cols]
    end

    protected

    attr_reader :a

    def []=(row, col, new_value)
      @a[row * @cols + col] = new_value
    end
  end

  Matrix::IDENTITY = Matrix.new(4)
end
