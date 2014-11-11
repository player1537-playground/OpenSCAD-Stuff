include <libraries/ng_motor.scad>;

$fn = 10;

ng_motor();

// Rack and pinion platform dimension, and position
rap_plat_delta = [-1, -14, -1];
rap_plat_pos = ng_motor_mpos + rap_plat_delta;
rap_plat_dim = ng_motor_mdim + -2 * rap_plat_delta + [0, 0, 2];

difference() {
	union() {
		color("red") translate(ng_motor_mpos + [-1, -14, -1])
			cube(ng_motor_mdim + [2, 28, 4]);
		for (y = [-14, ng_motor_mw + 14 - 4]) {
			color("green") translate(ng_motor_mpos + [-1, y, -1 + ng_motor_mh + 4])
				cube([ng_motor_ml + 2, 4, ng_motor_mh]);
		}
	}
	translate(ng_motor_mpos + [0, 0, -1])
		cube(ng_motor_mdim + [0, 0, 2]);
	translate([-1, -1, ng_motor_mbot])
		cube([ng_motor_bl + 2, ng_motor_bw + 2, ng_motor_mh + 4]);
	for (hole = ng_motor_mhx) {
		translate([hole, ng_motor_mhy, ng_motor_mhbot])
			cylinder(r=ng_motor_mhr, h=ng_motor_mh + 4);
	}
}