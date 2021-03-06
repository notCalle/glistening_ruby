# frozen_string_literal: true

Then(
  '{variable} = {scalar}'
) do |var, value|
  expect(seval(var)).to be_within(EPSILON).of(value)
end

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
  '{variable}.{method} = {variable}.{method}[{int}]'
) do |a, a_method, b, b_method, i|
  expect(seval(a, a_method)).to eq seval(b, b_method)[i]
end

Then(
  '{variable} = {class}[]'
) do |a, klass|
  expect(seval(a)).to eq klass[]
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
  '{variable}[{int}] = {variable}[{int}]'
) do |lvar, lindex, rvar, rindex|
  expect(seval(lvar)[lindex]).to eq seval(rvar)[rindex]
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
  '{variable}.{method} = {string}'
) do |name, method, string|
  expect(seval(name, method)).to eq string
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
  '{variable}.{method} is less than -EPSILON÷2'
) do |name, method|
  expect(seval(name, method)).to be < -EPSILON / 2
end

Then(
  '{variable}.{method} is greater than EPSILON÷2'
) do |name, method|
  expect(seval(name, method)).to be > EPSILON / 2
end

Then(
  '{variable}.{method} {variable} should terminate successfully'
) do |name, method, *args|
  expect { seval(name, method, *args) }.not_to raise_error
end

Then(
  '{variable} includes {variable}'
) do |a, b|
  expect(seval(a, :include?, b)).to be_truthy
end

Then(
  '{variable} does/is {predicate}'
) do |subj, method|
  expect(seval(subj, method)).to be_truthy
end

Then(
  '{variable} does/is not {predicate}'
) do |subj, method|
  expect(seval(subj, method)).to be_falsey
end

Then(
  '{variable}.{method} does/is {predicate}'
) do |subj, method, predicate|
  expect(seval(seval(subj, method), predicate)).to be_truthy
end

Then(
  '{variable}.{method} does/is not {predicate}'
) do |subj, method, predicate|
  expect(seval(seval(subj, method), predicate)).to be_falsey
end

Then(
  '{variable} is {predicate} in {variable}'
) do |subj, method, obj|
  expect(seval(obj, method, subj)).to be_truthy
end

Then(
  '{variable} does not {predicate} {boolean}, {boolean}, {boolean}'
) do |obj, predicate, *args|
  expect(seval(obj, predicate, *args)).to be_falsey
end

Then(
  '{variable} does {predicate} {boolean}, {boolean}, {boolean}'
) do |obj, predicate, *args|
  expect(seval(obj, predicate, *args)).to be_truthy
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

Then('{variable} is identical to {variable}') do |a, b|
  a = seval(a)
  b = seval(b)
  expect(a.class).to eq b.class
  expect(a.instance_variables).to eq b.instance_variables
end
