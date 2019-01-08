# frozen_string_literal: true

shape.group :table do
  material do
    pattern.perturb do
      pattern.stripe do
        color rgb 0.5, 0.35, 0.15
        color rgb 0.45, 0.3, 0.1
        scale 1/32r
      end
      magnitude 0.2
      octaves 2
    end
    phong 0.3
    reflective 0.05
  end

  shape.cube do
    scale 1.25, 0.05, 0.5
    translate 0, 0.8, 0
  end

  [-1, 1].each do |x|
    [-1, 1].each do |z|
      shape.cube do
        scale 0.05, 0.4, 0.05
        translate(x * 1.2, 0.4, z * 0.45)
      end
    end
  end
end
