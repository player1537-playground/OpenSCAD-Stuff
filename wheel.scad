$fs = 0.5;

module isosceles_triangle(length=1, height=1, angle=60) {
	linear_extrude(height=height)
		polygon(points=[[0, 0],length*[sin(angle), cos(angle)], length*[-sin(angle),cos(angle)]]);
}

module rounded_triangle(radius=1, height=1, angle=60) {
	intersection() {
		isosceles_triangle(2 * radius / cos(angle/2), height, angle);
		cylinder(r=radius, h=height);
	}
}

wheel_radius = 5;
wheel_width = 1;
wheel_rim_thickness = 1;
wheel_rim_width = wheel_width / 2;
shaft_radius = 1;
hole_radius = shaft_radius / 2;
shaft_length = 4;
hole_length = shaft_length + wheel_width;
num_spokes = 5;
spoke_angle = 15;

difference() {
	union() {
		cylinder(h=1, r=wheel_radius);
		translate([0, 0, wheel_width])
			cylinder(h=shaft_length, r=shaft_radius);
	}
	cylinder(h=hole_length, r=hole_radius);
	difference() {
		union() {
			translate([0, 0, wheel_rim_width])
				cylinder(h=wheel_width - wheel_rim_width, r=wheel_radius - wheel_rim_thickness);
			for (n = [0 : num_spokes]) {
				rotate(360 / num_spokes * n)
					rounded_triangle(wheel_radius - wheel_rim_thickness, 1, spoke_angle);
			}
		}
		cylinder(h=wheel_width, r=shaft_radius);
	}
}