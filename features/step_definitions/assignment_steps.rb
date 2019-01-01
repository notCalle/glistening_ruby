# frozen_string_literal: true

Given(
  '{variable} := {scalar}'
) do |var, value|
  seval(var, :'=', value)
end

Given(
  '{variable} := {boolean}'
) do |var, value|
  seval(var, :'=', value)
end

Given(
  '{variable} := {variable}.{method}'
) do |lhs, rhs, method|
  seval(lhs, :'=', rhs, method)
end

Given(
  '{variable} := {variable}.{method} {scalar}, {scalar}'
) do |lhs, rhs, method, *args|
  seval(lhs, :'=', rhs, method, *args)
end

Given(
  '{variable} := {variable}[{int}]'
) do |lhs, rhs, index|
  seval(lhs, :'=', seval(rhs)[index])
end

Given(
  '{variable} := {variable}[{string}]'
) do |lhs, rhs, index|
  seval(lhs, :'=', seval(rhs)[index])
end

Given(
  '{variable} := {variable}.{method}[{int}]'
) do |lhs, rhs, method, index|
  seval(lhs, :'=', seval(rhs, method)[index])
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

Given(
  '{variable} := {class}[{variable}, {variable}, {variable}]'
) do |var, klass, *tuple|
  seval(var, :'=', klass[*tuple.map { |i| seval(i) }])
end

Given(
  '{variable} := {class}[{variable}, {variable}, {variable}, {variable}]'
) do |var, klass, *tuple|
  seval(var, :'=', klass[*tuple.map { |i| seval(i) }])
end

Given(
  '{variable} := {variable}.{method}'\
  ' {variable}, {variable}'
) do |a, b, method, *args|
  seval(a, :'=', b, method, *args)
end

Given(
  '{variable} := {variable}.{method}'\
  ' {variable}, {variable}, {variable}, {variable}'
) do |a, b, method, *args|
  seval(a, :'=', b, method, *args)
end

Given(
  '{variable} := {variable}.{method}'\
  ' {variable}, {variable}, {variable}, {variable}, {variable}'
) do |a, b, method, *args|
  seval(a, :'=', b, method, *args)
end

Given(
  '{variable} := {variable}.{method}'\
  ' {variable}, {variable}, {variable}, {variable}, {variable}, {variable}'
) do |a, b, method, *args|
  seval(a, :'=', b, method, *args)
end

When(
  '{variable} := {variable}.{method} {variable}'
) do |r, a, method, b|
  seval(r, :'=', a, method, b)
end

When(
  '{variable}.{method} {matrix}'
) do |a, method, m|
  seval(a, method, m)
end

When(
  '{variable}.{method} {scalar}'
) do |a, method, value|
  seval(a, method, value)
end

When(
  '{variable}.{method} {variable}'
) do |a, method, b|
  seval(a, method, b)
end

When(
  '{variable}.{method}.{method} {scalar}'
) do |a, m1, m2, b|
  seval(seval(a, m1), m2, b)
end

When(
  '{variable}.{method} {string}'
) do |a, method, b|
  seval(a, method, b)
end

Given(
  '{variable}.{method} {class}[{variable}, {variable}]'
) do |var, method, klass, *tuple|
  seval(var, method, klass[*tuple.map { |v| seval(v) }])
end

Given(
  '{variable}.{method} {class}[{scalar}]'
) do |var, method, klass, *tuple|
  seval(var, method, klass[*tuple])
end

Given(
  '{variable}.{method} {class}[{scalar}, {scalar}, {scalar}]'
) do |var, method, klass, *tuple|
  seval(var, method, klass[*tuple])
end

When(
  '{variable} := {variable}.{method} {matrix}'
) do |r, a, method, m|
  seval(r, :'=', a, method, m)
end

When(
  '{variable} := {matrix} {operator} {variable}'
) do |a, m, op, b|
  seval(a, :'=', m, op, b)
end

When(
  '{variable} := {class}[{variable}]'
) do |var, klass, *args|
  seval(var, :'=', klass[*args.map { |arg| seval(arg) }])
end

When(
  '{variable} := {class}[{variable}, {variable}]'
) do |var, klass, *args|
  seval(var, :'=', klass[*args.map { |arg| seval(arg) }])
end

When(
  '{variable} :='\
  ' {class}[{variable}, {variable}, {variable},'\
  ' {variable}, {variable}, {variable}]'
) do |var, klass, *args|
  seval(var, :'=', klass[*args.map { |arg| seval(arg) }])
end

When(
  '{variable} := {class}[{scalar}, {variable}]'
) do |var, klass, *args|
  seval(var, :'=', klass[*args.map { |arg| seval(arg) }])
end

When(
  '{variable} := {class}[{scalar}, {variable}, {scalar}, {scalar}]'
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
  '{matrix} := {class}[{variable}, {variable}, {variable}]'
) do |matrix, klass, *args|
  seval(matrix, :'=', klass[*args.map { |a| seval(a) }])
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

When('{variable} is the {method} {word}') do |var, method, klass|
  klass = GlisteningRuby.const_get(klass.capitalize)
  seval(var, :'=', klass, method)
end
