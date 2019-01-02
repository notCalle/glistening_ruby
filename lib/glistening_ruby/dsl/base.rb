# frozen_string_literal: true

module GlisteningRuby
  module DSL
    # Base class for object builder DSL classes
    class Base
      def self.define(name, *args, klass: self, &block)
        this = self
        klass.define_singleton_method("dsl_#{name}") do
          this.setup(*args, &block)
        end
      end

      def self.setup(*args, &block)
        new(*args, &block).instance
      end

      def self.[](name, *args)
        send("dsl_#{name}", *args)
      end

      def initialize(*args, &block)
        instance_exec(*args, &block)
      end

      def instance(&block)
        instance_exec(&block) if block_given?
      end

      def copy_ivars(other, ivars = instance_variables)
        ivars.each do |ivar|
          other.instance_variable_set(ivar, instance_variable_get(ivar))
        end
      end
    end
  end
end
