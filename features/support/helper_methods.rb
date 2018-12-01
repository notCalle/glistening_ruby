# frozen_string_literal: true

def map_operator(operator)
  {
    ·: :dot,
    X: :cross
  }.fetch(operator, operator)
end

# Symbol expression evaluation helper
def seval(lhs, operator = nil, rhs = nil)
  operator = map_operator(operator)
  if operator == :'='
    instance_variable_set(lhs, rhs)
  elsif operator.nil?
    instance_variable_get(lhs)
  elsif rhs.nil?
    instance_variable_get(lhs).send(operator)
  else
    instance_variable_get(lhs).send(operator, instance_variable_get(rhs))
  end
end
