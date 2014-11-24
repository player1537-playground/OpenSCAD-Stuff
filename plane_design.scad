include <libraries/relativity.scad/relativity.scad>;

motor_radius = 20;
motor_mounting_hole_radius = 15;
motor_screw_radius = 2;
motor_mount_height = 10;

differed("+", "-") {
	rod(r=motor_radius, h=motor_screw_height, anchor=bottom, $class="+") {
		align(bottom)
			rotated([0, 0, 90], [0, 1, 2, 3])
			translated([motor_mounting_hole_radius, 0, 0])
			rod(r=motor_screw_radius, h=$parent_size.z, anchor=bottom, $class="-");
		align(top)
			rotated([0, 0, 45])
			box([20, 5, 40], anchor=bottom, $class="+");
	}
}