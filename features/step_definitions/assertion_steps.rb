# frozen_string_literal: true

Then(
  '{variable} = {variable}'
) do |a, b|
  expect(seval(a)).to eq seval(b)
end

Then(
  '{variable} = {variable}.{method}'
) do |a, b, method|
  expect(seval(a)).to eq seval(b, method)
end

Then(
  '{variable}.{method} = {variable}.{method}'
) do |a, a_method, b, b_method|
  expect(seval(a, a_method)).to eq seval(b, b_method)
end

Then(
  '{variable} = {class}[]'
) do |a, klass|
  expect(seval(a)).to eq klass[]
end

Then(
  '{variable} is nothing'
) do |var|
  expect(seval(var)).to be_nil
end

Then(
  '{variable} is inside'
) do |var|
  expect(seval(var)).to be_inside
end

Then(
  '{variable} is not inside'
) do |var|
  expect(seval(var)).not_to be_inside
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

Then(
  '{variable} is {predicate} in {variable}'
) do |subj, method, obj|
  expect(seval(obj, method, subj)).to be_truthy
end

Then(
  '{variable} is not {predicate} in {variable}'
) do |subj, method, obj|
  expect(seval(obj, method, subj)).to be_falsey
end

Then('{variable} contains no objects') do |name|
  expect(seval(name).objects).to be_empty
end

Then('{variable} has no light source') do |name|
  expect(seval(name).lights).to be_empty
end
