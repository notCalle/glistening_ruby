# frozen_string_literal: true

def map_operator(operator)
  {
    ·: :dot,
    X: :cross
  }.fetch(operator, operator)
end

def seval(recv, method = nil, *args)
  case method
  when :'='
    instance_variable_set(recv, seval(*args))
  when nil
    recv.is_a?(Symbol) ? instance_variable_get(recv) : recv
  else
    fcall(map_operator(method), recv, *args)
  end
end

def fcall(method, *args)
  method.to_proc.call(*args.map do |arg|
    arg.is_a?(Symbol) ? instance_variable_get(arg) : arg
  end)
end

def table_to_matrix(table)
  table.raw.map { |row| row.map(&:to_f) }
end
