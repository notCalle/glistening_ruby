# frozen_string_literal: true

Given(
  '{variable} is added to {variable}'
) do |thing, world|
  seval(world, :<<, thing)
end
