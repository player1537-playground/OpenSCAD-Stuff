include <libraries/LED.scad>;

$fn = 20;

difference() {
  union() {
    difference() {
      translate([0, 0, -led_wire_h/2])
      cylinder(r=led_fd * 1.5 / 2, h=led_h + led_wire_h / 2);
      render() {
	minkowski() {
	  led();
	  cube(0.5, center=true);
	}
      }
      cylinder(r=led_fd*1.1 / 2, h=led_h+5);
    }

    led();
  }
  translate([0, 0, -led_wire_h*1.1/2])
  difference() {
    cylinder(r=led_fd, h=led_wire_h/2);
    cylinder(r=led_wire_da, h=led_wire_h/2);
  }

  translate([0, 0, -10])
  cube(20);
}
