# frozen_string_literal: true

ParameterType(
  name: 'axis',
  regexp: /[w-z]/,
  transformer: ->(axis) { axis.to_sym }
)

ParameterType(
  name: 'variable',
  regexp: /[a-z][a-z0-9]*/,
  transformer: ->(name) { "@#{name}".to_sym }
)

ParameterType(
  name: 'class',
  regexp: /[A-Z][A-Za-z]+/,
  transformer: ->(klass) { GlisteningRuby.const_get(klass) }
)

ParameterType(
  name: 'operator',
  regexp: /[+-]/,
  transformer: ->(op) { op.to_sym }
)

ParameterType(
  name: 'prefixop',
  regexp: /[-]/,
  transformer: ->(op) { "#{op}@".to_sym }
)
