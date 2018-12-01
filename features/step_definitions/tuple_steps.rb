# frozen_string_literal: true

Given(
  '{variable} := {scalar}'
) do |var, value|
  seval(var, :'=', value)
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

Then(
  '{variable}.{method} = {scalar}'
) do |a, op, value|
  expect(seval(a, op)).to be_within(EPSILON).of value
end

Then(
  '{variable}.{method} = {variable}'
) do |a, op, b|
  expect(seval(a, op)).to eq seval(b)
end

Then(
  '{variable}.{method}'\
  ' = {class}[{scalar}, {scalar}, {scalar}]'
) do |a, op, klass, *tuple|
  expect(seval(a, op)).to eq klass[*tuple]
end

Then(
  '{variable}.{method}'\
  ' = {class}[{scalar}, {scalar}, {scalar}, {scalar}]'
) do |a, op, klass, *tuple|
  expect(seval(a, op)).to eq klass[*tuple]
end

Then(
  '{variable} is a {class}'
) do |var, klass|
  expect(seval(var)).to be_a klass
end

Then(
  '{variable} is not a {class}'
) do |var, klass|
  expect(seval(var)).not_to be_a klass
end

Then(
  '{variable} = {class}[{scalar}, {scalar}, {scalar}]'
) do |var, klass, x, y, z|
  expect(seval(var)).to eq klass[x, y, z]
end

Then(
  '{variable} = {class}[{scalar}, {scalar}, {scalar}, {scalar}]'
) do |var, klass, *tuple|
  expect(seval(var)).to eq klass[*tuple]
end

Then(
  '{prefixop}{variable}'\
  ' = {class}[{scalar}, {scalar}, {scalar}]'
) do |op, a, klass, *tuple|
  expect(seval(a, op)).to eq klass[*tuple]
end

Then(
  '{prefixop}{variable}'\
  ' = {class}[{scalar}, {scalar}, {scalar}, {scalar}]'
) do |op, a, klass, *tuple|
  expect(seval(a, op)).to eq klass[*tuple]
end

Then(
  '{variable} {operator} {variable} = {scalar}'
) do |a, op, b, value|
  expect(seval(a, op, b)).to be_within(EPSILON).of value
end

Then(
  '{variable} {operator} {variable}'\
  ' = {class}[{scalar}, {scalar}, {scalar}]'
) do |a, op, b, klass, *tuple|
  expect(seval(a, op, b)).to eq klass[*tuple]
end

Then(
  '{variable} {operator} {variable}'\
  ' = {class}[{scalar}, {scalar}, {scalar}, {scalar}]'
) do |a, op, b, klass, *tuple|
  expect(seval(a, op, b)).to eq klass[*tuple]
end
