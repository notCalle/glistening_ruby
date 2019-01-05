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

      def method_missing(name, value, *args)
        return super unless args.empty? && respond_to_missing?(name)

        instance_variable_set("@#{name}", value) if args.empty?
      end

      def respond_to_missing?(name, *)
        return true if name =~ /[a-z]+/

        super
      end

      private

      def copy_ivars(other)
        ivars.each do |ivar|
          other.send("#{ivar[1..-1]}=", instance_variable_get(ivar))
        end
        other
      end

      def ivars
        instance_variables
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
