# frozen_string_literal: true

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

Then(
  '{matrix}[{int},{int}] = {scalar}'
) do |name, row, col, value|
  expect(seval(name)[row, col]).to be_within(EPSILON).of value
end

Then('{matrix} = {matrix}') do |a, b|
  expect(seval(a)).to eq seval(b)
end

Then('{matrix} != {matrix}') do |a, b|
  expect(seval(a)).not_to eq seval(b)
end

Then('{matrix} {operator} {matrix} = {matrix}') do |a, op, b, r|
  expect(seval(a, op, b)).to eq seval(r)
end

Then('{matrix}.{method} = {scalar}') do |matrix, method, value|
  expect(feval(matrix, method)).to be_within(EPSILON).of value
end

Then('{matrix}.{method} = {matrix}') do |a, op, r|
  expect(feval(a, op)).to eq seval(r)
end

Then('{matrix} {operator} {variable} = {variable}') do |a, op, b, r|
  expect(seval(a, op, b)).to eq seval(r)
end

Then(
  '{matrix} {operator} {matrix} is the following {int}x{int} matrix:'
) do |left, op, right, rows, cols, expected|
  expected = Matrix[*table_to_matrix(expected)]
  expect(cols).to eq rows
  expect(expected.size).to eq rows
  expect(seval(left, op, right)).to eq expected
end

Then(
  '{matrix}.{method} is the following {int}x{int} matrix:'
) do |matrix, method, rows, cols, expected|
  expected = Matrix[*table_to_matrix(expected)]
  expect(cols).to eq rows
  expect(expected.size).to eq rows
  expect(seval(matrix, method)).to eq expected
end

Then(
  '{matrix}.{method} {int}, {int} is the following {int}x{int} matrix:'
) do |matrix, method, row, col, rows, cols, expected|
  expected = Matrix[*table_to_matrix(expected)]
  expect(cols).to eq rows
  expect(expected.size).to eq rows
  expect(feval(matrix, method, row, col)).to eq expected
end

Then(
  '{matrix} {operator} {variable}'\
  ' = {class}[{scalar}, {scalar}, {scalar}, {scalar}]'
) do |matrix, op, tuple, klass, x, y, z, w|
  expect(seval(matrix, op, tuple)).to eq klass[x, y, z, w]
end
