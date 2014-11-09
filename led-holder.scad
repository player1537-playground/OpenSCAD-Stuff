include <libraries/LED.scad>;

$fn = 20;

module led_holder() {
  outer_shell_thickness = 1;
  inner_shell_diameter = led_fd + 1;
  upper_shell_top = led_h + 1;
  upper_shell_bottom = -1;
  lower_shell_bottom = -led_wire_h / 2;
  lower_shell_thickness = 1;
  minkowski_shell = 0.5;

  difference() {
    union() {
      translate([0, 0, upper_shell_bottom])
	cylinder(r=led_fd/2 + outer_shell_thickness, h=upper_shell_top);
      scale([0.5, 1, 1])
	translate([0, 0, lower_shell_bottom])
	cylinder(r=led_wire_da, h=upper_shell_bottom - lower_shell_bottom);
    }
    render() {
      minkowski() {
	led();
	cube(minkowski_shell, center=true);
      }
    }
    cylinder(r=inner_shell_diameter / 2, h=upper_shell_top);
  }
}

difference() {
  union() {
    led_holder();
    %color("blue") led();
  }
  translate([0, 0, -20])
    cube(40);
}
