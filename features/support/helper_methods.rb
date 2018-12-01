# frozen_string_literal: true

# Symbol expression evaluation helper
def seval(lhs, operator = nil, rhs = nil)
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
