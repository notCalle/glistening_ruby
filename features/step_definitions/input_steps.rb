# frozen_string_literal: true

Given('{variable} containing:') do |var, string|
  seval(var, :'=', string)
end
