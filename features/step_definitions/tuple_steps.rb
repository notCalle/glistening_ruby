# frozen_string_literal: true

Given('{variable} := Tuple[{float}, {float}, {float}, {float}]') \
do |var, x, y, z, w|
  value = Tuple[x, y, z, w]
  instance_variable_set(var, value)
end

Given('{variable} := {class}[{float}, {float}, {float}]') \
do |var, klass, x, y, z|
  value = klass[x, y, z]
  instance_variable_set(var, value)
end

Then('{variable}.{axis} = {float}') \
do |var, axis, value|
  object = instance_variable_get(var)
  expect(object.send(axis)).to be value
end

Then('{variable} is a {class}') \
do |var, klass|
  expect(instance_variable_get(var)).to be_a klass
end

Then('{variable} is not a {class}') \
do |var, klass|
  expect(instance_variable_get(var)).not_to be_a klass
end

Then('{variable} = Tuple[{float}, {float}, {float}, {float}]') \
do |var, x, y, z, w|
  expect(instance_variable_get(var)).to eq Tuple[x, y, z, w]
end
