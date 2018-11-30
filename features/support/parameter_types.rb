# frozen_string_literal: true

ParameterType(
  name: 'axis',
  regexp: /[w-z]/,
  transformer: ->(axis) { axis.to_sym }
)

ParameterType(
  name: 'variable',
  regexp: /[A-Za-z]+/,
  transformer: ->(name) { "@#{name}".to_sym }
)

ParameterType(
  name: 'class',
  regexp: /[A-Z][A-Za-z]+/,
  transformer: ->(klass) { GlisteningRuby.const_get(klass) }
)
