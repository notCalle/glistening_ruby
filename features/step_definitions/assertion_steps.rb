# frozen_string_literal: true

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
