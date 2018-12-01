# frozen_string_literal: true

When(
  '{variable}[{int}, {int}] := {variable}'
) do |canvas, x, y, color|
  seval(canvas)[x, y] = seval(color)
end

Then(
  '{variable}[{int}, {int}] = {variable}'
) do |canvas, x, y, color|
  expect(seval(canvas)[x, y]).to eq seval(color)
end

Then(
  'every pixel of {variable} is Color[{scalar}, {scalar}, {scalar}]'
) do |canvas, red, green, blue|
  color = Color[red, green, blue]
  seval(canvas).each { |p| expect(p).to eq color }
end
