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

    attr_reader :rows

    private

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
