# frozen_string_literal: true

Given(
  '{variable} := {scalar}'
) do |var, value|
  seval(var, :'=', value)
end

Given(
  '{variable} := {variable}.{method}'
) do |lhs, rhs, method|
  seval(lhs, :'=', rhs, method)
end

Given(
  '{variable} := {class}[]'
) do |var, klass|
  seval(var, :'=', klass[])
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
  '{variable} := {variable}.{method} {variable}'
) do |r, a, method, b|
  seval(r, :'=', a, method, b)
end

When(
  '{variable} := {matrix} {operator} {variable}'
) do |a, m, op, b|
  seval(a, :'=', m, op, b)
end

When(
  '{variable} := {class}[{variable}, {variable}]'
) do |var, klass, *args|
  seval(var, :'=', klass[*args.map { |arg| seval(arg) }])
end

Given(
  'the following {int}x{int} matrix {matrix}:'
) do |rows, cols, name, table|
  arrays = table_to_matrix(table)
  expect(cols).to eq rows
  expect(arrays.size).to eq rows
  seval(name, :'=', Matrix[*arrays])
end

Given(
  'the identity matrix {matrix}'
) do |name|
  seval(name, :'=', Matrix::IDENTITY)
end

Given(
  '{matrix} := {class}[{scalar}]'
) do |matrix, klass, *args|
  seval(matrix, :'=', klass[*args])
end

Given(
  '{matrix} := {class}[{scalar}, {scalar}, {scalar}]'
) do |matrix, klass, *args|
  seval(matrix, :'=', klass[*args])
end

Given(
  '{matrix} := '\
  '{class}[{scalar}, {scalar}, {scalar}, {scalar}, {scalar}, {scalar}]'
) do |matrix, klass, *args|
  seval(matrix, :'=', klass[*args])
end

Given(
  '{matrix} := {matrix}.{method}'
) do |a, b, method|
  seval(a, :'=', b, method)
end

Given(
  '{matrix} := {matrix} {operator} {matrix}'
) do |r, a, op, b|
  seval(r, :'=', a, op, b)
end

Given(
  '{matrix} := {matrix} * {matrix} * {matrix}'
) do |r, *matrices|
  result = matrices.map { |matrix| seval(matrix) }.reduce(&:*)
  seval(r, :'=', result)
end

Given(
  '{matrix} := {matrix}.{method} {int}, {int}'
) do |a, b, method, row, col|
  seval(a, :'=', b, method, row, col)
end
