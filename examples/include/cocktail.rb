# frozen_string_literal: true

material :drink do
  color rgb 0.15, 0.1, 0.05
  ambient 0.3
  diffuse 0.3
  phong 0.7
  reflective 0.7
  transparent 0.7, 1.3
end

material :glass do
  color rgb 0, 0, 0
  ambient 0.2
  diffuse 0.2
  phong 0.9
  reflective 0.9
  transparent 0.9, 1.5
end

shape.cone :cocktail_drink do
  material :drink
  closed
  scale 0.08
  translate 0, 0.11, 0
end

shape.cone :cocktail_top do
  material :glass
  scale 0.1
  translate 0, 0.1, 0
end

shape.cylinder :cocktail_leg do
  material :glass
  closed
  scale 0.01, 0.11, 0.01
end

shape.cone :cocktail_foot do
  material :glass
  closed
  scale 0.08, -0.01, 0.08
  translate 0, 0.01, 0
end

shape.group :cocktail do
  shape :cocktail_foot
  shape :cocktail_leg
  shape :cocktail_top
  shape :cocktail_drink
end
