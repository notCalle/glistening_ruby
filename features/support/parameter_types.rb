# frozen_string_literal: true

ParameterType(
  name: 'variable',
  regexp: /[a-z][a-z0-9_]*/,
  use_for_snippets: false,
  transformer: ->(name) { "@#{name}".to_sym }
)

ParameterType(
  name: 'boolean',
  regexp: /true|false/,
  use_for_snippets: false,
  transformer: ->(name) { name == 'true' }
)

ParameterType(
  name: 'matrix',
  regexp: /[A-Z]/,
  transformer: ->(name) { "@#{name}".to_sym }
)

ParameterType(
  name: 'class',
  regexp: /[A-Z][A-Za-z]+/,
  transformer: ->(klass) { GlisteningRuby.const_get(klass) }
)

ParameterType(
  name: 'operator',
  regexp: %r{[·X*/+-]},
  transformer: ->(op) { op.to_sym }
)

ParameterType(
  name: 'prefixop',
  regexp: /[-]/,
  transformer: ->(op) { "#{op}@".to_sym }
)

ParameterType(
  name: 'method',
  regexp: /[a-z][a-z_0-9]*=?/,
  use_for_snippets: false,
  transformer: ->(name) { name.to_sym }
)

ParameterType(
  name: 'predicate',
  regexp: /[a-z_]+/,
  use_for_snippets: false,
  transformer: ->(name) { "#{name}?".to_sym }
)

ParameterType(
  name: 'scalar',
  regexp: '(-?√?)((?:[0-9]+\.)?[0-9]+)(?:/([0-9]+))?',
  transformer: lambda do |prefix, scalar, divisor = 1|
    value = scalar.to_f
    value **= 0.5 if prefix =~ /√/
    value = -value if prefix =~ /-/
    value / divisor.to_f
  end
)
