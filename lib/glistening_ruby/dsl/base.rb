# frozen_string_literal: true

module GlisteningRuby
  module DSL
    # Base class for object builder DSL classes
    class Base
      def self.define(name, klass: self, &block)
        this = self
        klass.define_singleton_method("dsl_#{name}") do |*args|
          this.new(*args, &block)
        end
      end

      def self.setup(*args, &block)
        new(*args, &block).instance
      end

      def self.[](name, *args, &block)
        send("dsl_#{name}", *args).instance(&block)
      end

      def initialize(*args, &block)
        instance_exec(*args, &block)
      end

      def instance(&block)
        instance_exec(&block) if block_given?
      end

      private

      def copy_ivars(other, ivars = instance_variables)
        ivars.each do |ivar|
          other.send("#{ivar[1..-1]}=", instance_variable_get(ivar))
        end
      end

      def dsl(dsl_module, &block)
        Module.new do
          extend dsl_module
          define_singleton_method(:callback, &block)
        end
      end
    end
  end
end
