# frozen_string_literal: true

require_relative 'matrix_private'

module GlisteningRuby
  # A square matrix
  class Matrix
    include MatrixPrivate

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

      @rows.each(&:freeze)
      @rows.freeze
      freeze
    end

    def [](row, col)
      @rows[row][col]
    end

    def ==(other)
      @rows == other.rows
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
        0.upto(size - 1) do |row|
          0.upto(size - 1) do |col|
            result[col, row] = self[row, col]
          end
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
