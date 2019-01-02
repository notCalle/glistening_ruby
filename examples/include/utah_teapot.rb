# frozen_string_literal: true

material :glazed_ceramic do
  color rgb 1.0, 0.8, 0.5
  ambient 0.3
  diffuse 0.7
  phong 0.9, 300
  reflective 0.1
end

shape.mesh :utah_teapot do |version = 'hi'|
  file "teapot-#{version}.obj"
  material :glazed_ceramic
  rotate x: -1/4r
  scale 1/16r
end
