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
