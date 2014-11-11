include <libraries/ng_motor.scad>;

$fn = 10;

// Rack and pinion platform position and dimension
rap_pdel = [-1, -14, -1];
rap_ppos = ng_motor_mpos + rap_pdel;
rap_pdim = ng_motor_mdim + -2 * rap_pdel + [0, 0, 2];
// Rack and pinion mounting hole position, radius, height
rap_mhx = ng_motor_mhx;
rap_mhy = ng_motor_mhy;
rap_mhbot = ng_motor_mhbot;
rap_mhr = ng_motor_mhr;
rap_mhh = rap_pdim.z + (rap_ppos.z - rap_mhbot);
// Rack and pinion motor (and mount) cutout position and dimension
rap_mcdel = [0, 0, -1];
rap_mcpos = ng_motor_mpos + rap_mcdel;
rap_mcdim = ng_motor_mdim + -2 * rap_mcdel;
// Rack and pinion motor tolerance cutout
rap_mttol = 1;
rap_mtx = -rap_mttol;
rap_mty = -rap_mttol;
rap_mtbot = rap_ppos.z;
rap_mtpos = [rap_mtx, rap_mty, rap_mtbot];
rap_mtl = ng_motor_bl + 2 * rap_mttol;
rap_mtw = ng_motor_bw + 2 * rap_mttol;
rap_mth = rap_pdim.z;
rap_mtdim = [rap_mtl, rap_mtw, rap_mth];

module rack_and_pinion_mount() {
	difference() {
		union() {
			// Main platform
			color("red") translate(rap_ppos)
				cube(rap_pdim);
			// Side walls
			for (y = [-14, ng_motor_mw + 14 - 4]) {
				color("green") translate(ng_motor_mpos + [-1, y, -1 + ng_motor_mh + 4])
					cube([ng_motor_ml + 2, 4, ng_motor_mh + 10]);
			}
		}
		// Motor and mount cutout
		translate(rap_mcpos)
			cube(rap_mcdim);
		// Motor tolerance cutout
		translate(rap_mtpos)
			cube(rap_mtdim);
		// Mounting holes
		for (hole = rap_mhx) {
			translate([hole, rap_mhy, rap_mhbot])
				cylinder(r=rap_mhr, h=rap_mhh);
		}
	}
}

module rack_and_pinion_gear() {
	
}

rack_and_pinion_mount();
%ng_motor();














