# frozen_string_literal: true

Given(
  '{variable} := {float}'
) do |var, value|
  seval(var, :'=', value)
end

Given(
  '{variable} := {class}[{float}, {float}, {float}]'
) do |var, klass, *tuple|
  seval(var, :'=', klass[*tuple])
end

Given(
  '{variable} := {class}[{float}, {float}, {float}, {float}]'
) do |var, klass, *tuple|
  seval(var, :'=', klass[*tuple])
end

Then(
  '{variable}.{axis} = {float}'
) do |var, axis, value|
  expect(seval(var, axis)).to be value
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
  '{variable} = {class}[{float}, {float}, {float}]'
) do |var, klass, x, y, z|
  expect(seval(var)).to eq klass[x, y, z]
end

Then(
  '{variable} = {class}[{float}, {float}, {float}, {float}]'
) do |var, klass, *tuple|
  expect(seval(var)).to eq klass[*tuple]
end

Then(
  '{prefixop}{variable}'\
  ' = {class}[{float}, {float}, {float}]'
) do |op, a, klass, *tuple|
  expect(seval(a, op)).to eq klass[*tuple]
end

Then(
  '{prefixop}{variable}'\
  ' = {class}[{float}, {float}, {float}, {float}]'
) do |op, a, klass, *tuple|
  expect(seval(a, op)).to eq klass[*tuple]
end

Then(
  '{variable} {operator} {variable}'\
  ' = {class}[{float}, {float}, {float}]'
) do |a, op, b, klass, *tuple|
  expect(seval(a, op, b)).to eq klass[*tuple]
end

Then(
  '{variable} {operator} {variable}'\
  ' = {class}[{float}, {float}, {float}, {float}]'
) do |a, op, b, klass, *tuple|
  expect(seval(a, op, b)).to eq klass[*tuple]
end
