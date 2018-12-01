# frozen_string_literal: true

# Symbol expression evaluation helper
def seval(lhs, operator = nil, rhs = nil)
  if operator == :'='
    instance_variable_set(lhs, rhs)
  elsif operator == :'.'
    instance_variable_get(lhs).send(rhs)
  elsif operator.nil?
    instance_variable_get(lhs)
  else
    instance_variable_get(lhs).send(operator, instance_variable_get(rhs))
  end
end
