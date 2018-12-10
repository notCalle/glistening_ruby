# frozen_string_literal: true

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

Then('{matrix} is invertible') do |matrix|
  expect(seval(matrix)).to be_invertible
end

Then('{matrix} is not invertible') do |matrix|
  expect(seval(matrix)).not_to be_invertible
end

Then('{matrix} {operator} {matrix} = {matrix}') do |a, op, b, r|
  expect(seval(a, op, b)).to eq seval(r)
end

Then('{matrix}.{method} = {scalar}') do |matrix, method, value|
  expect(seval(matrix, method)).to be_within(EPSILON).of value
end

Then(
  '{matrix}.{method} {int}, {int} = {scalar}'
) do |matrix, method, row, col, value|
  expect(seval(matrix, method, row, col)).to be_within(EPSILON).of value
end

Then('{matrix}.{method} = {matrix}') do |a, op, r|
  expect(seval(a, op)).to eq seval(r)
end

Then(
  '{matrix} {operator} {matrix}.{method} = {matrix}'
) do |a, op, b, method, r|
  expect(seval(a, op, seval(b, method))).to eq seval(r)
end

Then('{matrix} {operator} {variable} = {variable}') do |a, op, b, r|
  expect(seval(a, op, b)).to eq seval(r)
end

Then(
  '{matrix} = {class}[{scalar}, {scalar}, {scalar}]'
) do |m, klass, *args|
  expect(seval(m)).to eq klass[*args]
end

Then(
  '{matrix} {operator} {variable} = {class}[{scalar}, {scalar}, {scalar}]'
) do |m, op, v, klass, *args|
  expect(seval(m, op, v)).to eq klass[*args]
end

Then(
  '{matrix} is the following {int}x{int} matrix:'
) do |matrix, rows, cols, expected|
  expected = Matrix[*table_to_matrix(expected)]
  expect(cols).to eq rows
  expect(expected.size).to eq rows
  expect(seval(matrix)).to eq expected
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
  expect(seval(matrix, method, row, col)).to eq expected
end

Then(
  '{matrix} {operator} {variable}'\
  ' = {class}[{scalar}, {scalar}, {scalar}, {scalar}]'
) do |matrix, op, tuple, klass, x, y, z, w|
  expect(seval(matrix, op, tuple)).to eq klass[x, y, z, w]
end

Then(
  '{matrix} is the identity matrix'
) do |name|
  expect(seval(name)).to eq Matrix::IDENTITY
end
