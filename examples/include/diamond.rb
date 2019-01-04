# frozen_string_literal: true

shape.mesh :diamond do
  file 'diamond.obj'
  material do
    ambient 0.1
    diffuse 0
    phong 1, 64
    reflective 1
    transparent 1, 2.42
  end
end
