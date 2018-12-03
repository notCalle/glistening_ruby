# frozen_string_literal: true

Given(
  '{variable} := {scalar}'
) do |var, value|
  seval(var, :'=', value)
end

Given(
  '{variable} := {variable}.{method}'
) do |lhs, rhs, method|
  seval(lhs, :'=', seval(rhs, method))
end

Given(
  '{variable} := {class}[{scalar}, {scalar}]'
) do |var, klass, *tuple|
  seval(var, :'=', klass[*tuple])
end

Given(
  '{variable} := {class}[{scalar}, {scalar}, {scalar}]'
) do |var, klass, *tuple|
  seval(var, :'=', klass[*tuple])
end

Given(
  '{variable} := {class}[{scalar}, {scalar}, {scalar}, {scalar}]'
) do |var, klass, *tuple|
  seval(var, :'=', klass[*tuple])
end

When(
  '{variable} := {matrix} {operator} {variable}'
) do |a, m, op, b|
  seval(a, :'=', seval(m, op, b))
end
