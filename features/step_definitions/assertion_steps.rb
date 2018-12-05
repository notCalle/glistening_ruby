# frozen_string_literal: true

Then(
  '{variable} = {variable}'
) do |a, b|
  expect(seval(a)).to eq seval(b)
end

Then(
  '{variable} is nothing'
) do |var|
  expect(seval(var)).to be_nil
end

Then(
  '{variable}.{method} {scalar} = {class}[{scalar}, {scalar}, {scalar}]'
) do |var, method, method_arg, klass, *args|
  expected = klass[*args]
  expect(seval(var, method, method_arg)).to eq expected
end

Then(
  '{variable}[{int}] = {scalar}'
) do |var, index, value|
  expect(seval(var)[index]).to be_within(EPSILON).of value
end

Then(
  '{variable}[{int}].{method} = {variable}'
) do |a, index, method, b|
  expect(seval(seval(a)[index], method)).to eq seval(b)
end

Then(
  '{variable}[{int}].{method} = {scalar}'
) do |a, index, method, value|
  expect(seval(seval(a)[index], method)).to be_within(EPSILON).of value
end

Then(
  '{variable}.{method} = {matrix}'
) do |name, method, matrix|
  expect(seval(name, method)).to eq seval(matrix)
end

Then(
  '{variable}.{method} is the identity matrix'
) do |name, method|
  expect(seval(name, method)).to eq Matrix::IDENTITY
end
