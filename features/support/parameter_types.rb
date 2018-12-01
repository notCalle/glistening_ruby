# frozen_string_literal: true

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
  regexp: %r{[·*/+-]},
  transformer: ->(op) { op.to_sym }
)

ParameterType(
  name: 'prefixop',
  regexp: /[-]/,
  transformer: ->(op) { "#{op}@".to_sym }
)

ParameterType(
  name: 'method',
  regexp: /[a-z]+/,
  transformer: ->(name) { name.to_sym }
)

ParameterType(
  name: 'scalar',
  regexp: '([-√])?([0-9]+(\.[0-9+]+)?)',
  transformer: lambda do |prefix = nil, scalar|
    value = scalar.to_f
    value **= 0.5 if prefix == '√'
    value = -value if prefix == '-'
    value
  end
)
