# frozen_string_literal: true

module GlisteningRuby
  # A square matrix
  class Matrix
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
    end

    def [](row, col)
      @rows[row][col]
    end

    def ==(other)
      @rows == other.rows
    end

    attr_reader :rows, :size

    def *(other)
      case other
      when Matrix
        multiply_matrix_by_matrix(other)
      when Tuple
        multiply_matrix_by_tuple(other)
      end
    end

    protected

    def []=(row, col, new_value)
      @rows[row][col] = new_value
    end

    private

    def multiply_matrix_by_tuple(other)
      result = []
      0.upto(size - 1) do |row|
        result << Tuple[*@rows[row]].dot(other)
      end
      Tuple[*result]
    end

    def multiply_matrix_by_matrix(other)
      raise 'matrix sizes differ' unless size == other.size

      0.upto(size - 1).with_object(Matrix.new(size)) do |row, result|
        0.upto(size - 1) do |col|
          result[row, col] = row_dot_col(other, row, col)
        end
      end
    end

    def row_dot_col(other, row, col)
      0.upto(size - 1).reduce(0) do |sum, i|
        sum + self[row, i] * other[i, col]
      end
    end

    def initialize_identity(size)
      @rows = Array.new(size) do |row|
        Array.new(size) { |col| row == col ? 1 : 0 }
      end
      @size = size
    end

    def initialize_from_arrays(array_of_arrays)
      @rows = array_of_arrays
      @size = array_of_arrays.size
    end
  end
end
