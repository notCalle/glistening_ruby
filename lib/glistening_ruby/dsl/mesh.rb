# frozen_string_literal: true

require_relative 'shape'

module GlisteningRuby
  module DSL
    # Mesh builder DSL class
    class Mesh < Shape
      def instance
        super
        ::GlisteningRuby::ObjFile.new(File.open(@file)) do |i|
          copy_ivars(i)
        end
      end

      def file(name)
        caller = caller_locations(1..1).first
        caller_dir = File.dirname(caller.absolute_path)
        @file = File.expand_path(name, caller_dir)
      end

      private

      def ivars
        instance_variables.reject - %i[@file]
      end
    end
  end
end
