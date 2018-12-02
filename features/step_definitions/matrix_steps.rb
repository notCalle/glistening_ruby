# frozen_string_literal: true

Given(
  'the following {int}x{int} matrix {matrix}:'
) do |rows, cols, name, table|
  arrays = table_to_matrix(table)
  expect(cols).to eq rows
  expect(arrays.size).to eq rows
  seval(name, :'=', Matrix[*arrays])
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

Then(
  '{matrix} {operator} {matrix} is the following {int}x{int} matrix:'
) do |left, op, right, rows, cols, expected|
  expected = Matrix[*table_to_matrix(expected)]
  expect(cols).to eq rows
  expect(expected.size).to eq rows
  expect(seval(left, op, right)).to eq expected
end

Then(
  '{matrix} {operator} {variable}'\
  ' = {class}[{scalar}, {scalar}, {scalar}, {scalar}]'
) do |matrix, op, tuple, klass, x, y, z, w|
  expect(seval(matrix, op, tuple)).to eq klass[x, y, z, w]
end
