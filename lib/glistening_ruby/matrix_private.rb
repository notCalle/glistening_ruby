# frozen_string_literal: true

module GlisteningRuby
  # The private bits of a square matrix
  module MatrixPrivate
    private

    def determinant_2x2
      @a[0] * @a[3] - @a[1] * @a[2]
    end

    def each_element
      @a.reduce(0) do |n, el|
        yield el, n / @cols, n % @cols
        n + 1
      end
    end

    def each_row_col
      0.upto(cols * rows - 1) { |n| yield n / @cols, n % @cols }
    end

    def row_to_s(row)
      +'[' << row.map { |f| format('% .5f', f) }.join(', ') << ']'
    end

    def multiply_matrix_by_tuple(other)
      result = []
      each_row do |row|
        s = row.size
        row.concat Array.new(4 - s, 0) if s < 4
        result << other.dot_a(row)
      end
      Tuple.new(*result)
    end

    def multiply_matrix_by_matrix(other)
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
      @rows = @cols = size
      @a = Array.new(size * size) { |n| (n / @cols) == (n % @cols) ? 1 : 0 }
    end

    def initialize_from_arrays(array_of_arrays)
      @rows = array_of_arrays.count
      @cols = array_of_arrays[0].count
      @a = array_of_arrays.flatten
    end
  end
end
