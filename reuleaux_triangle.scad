module isosceles_triangle(r=1, angle=60) {
  polygon(points=[[0, 0], [r*tan(angle/2), r],[r*-tan(angle/2), r]]);
}

module circle_segment(r=1, angle=60) {
  intersection() {
    circle(r=r);
    isosceles_triangle(r, angle);
  }
}

module reuleaux_triangle(r=1) {
  angle = 60;
  union() {
    circle_segment(r, angle);
    translate([r*sin(angle/2), r*cos(angle/2), 0])
      rotate([0, 0, 180-angle])
      circle_segment(r, angle);
    translate([-r*sin(angle/2), r*cos(angle/2), 0])
      rotate([0, 0, 180+angle])
      circle_segment(r, angle);
  }
}

module 3d_reuleaux_triangle(r=1) {
  angle = 60;
  rotate_extrude()
  reuleaux_triangle(r);
}

$fn = 75;
r = 10;

3d_reuleaux_triangle(r);

*translate([0, -r/sqrt(3)])
linear_extrude(height=1)
reuleaux_triangle(r);
