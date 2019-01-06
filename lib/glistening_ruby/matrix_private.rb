# frozen_string_literal: true

module GlisteningRuby
  # The private bits of a square matrix
  module MatrixPrivate
    private

    def determinant_2x2
      self[0, 0] * self[1, 1] - self[0, 1] * self[1, 0]
    end

    def deep_freeze
      @rows.each(&:freeze)
      @rows.freeze
      freeze
    end

    def each_element
      each_row_col do |row, col|
        yield self[row, col], row, col
      end
    end

    def each_row_col
      0.upto(size - 1) do |row|
        0.upto(size - 1) do |col|
          yield row, col
        end
      end
    end

    def row_to_s(row)
      +'[' << row.map { |f| format('% .5f', f) }.join(', ') << ']'
    end

    def multiply_matrix_by_tuple(other)
      result = []
      0.upto(size - 1) do |row|
        result << Tuple[*@rows[row]].dot(other)
      end
      Tuple[*result]
    end

    def multiply_matrix_by_matrix(other)
      raise 'matrix sizes differ' unless size == other.size
      return self if other.identity_matrix?

      Matrix.new(size) do |result|
        0.upto(size - 1) do |row|
          0.upto(size - 1) do |col|
            result[row, col] = row_dot_col(other, row, col)
          end
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
