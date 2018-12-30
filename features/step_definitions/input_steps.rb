# frozen_string_literal: true

Given('{variable} containing:') do |var, string|
  seval(var, :'=', string)
end

Given('{variable} with contents of {string}') do |var, file_name|
  seval(var, :'=', File.open("features/#{file_name}", 'r'))
end
