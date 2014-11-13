include <libraries/ng_motor.scad>;

function expand(val, n=3) = val * (n == 2 ? [1, 1] : n == 3 ? [1, 1, 1] : echo("expand not defined for n=", n));

$fn = 10;

// Rack and pinion platform position and dimension
rap_pdel = [-3, -6, -1];
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
// Rack and pinion motor tolerance cutout tolerance, x offset, y offset, bottom,
// length, width, and height
rap_mttol = 1;
rap_mtx = -rap_mttol;
rap_mty = -rap_mttol;
rap_mtbot = rap_ppos.z;
rap_mtpos = [rap_mtx, rap_mty, rap_mtbot];
rap_mtl = ng_motor_bl + 2 * rap_mttol;
rap_mtw = ng_motor_bw + 2 * rap_mttol;
rap_mth = rap_pdim.z;
rap_mtdim = [rap_mtl, rap_mtw, rap_mth];
// Rack and pinion side wall
rap_swl = rap_pdim.x;
rap_sww = 4;
rap_swh = 10;
rap_swdim = [rap_swl, rap_sww, rap_swh];
rap_swx = rap_ppos.x;
rap_swy = expand(rap_ppos[1], n=2) + [0, rap_pdim[1] - rap_sww];
rap_swbot = rap_ppos.z + rap_pdim.z;

module rack_and_pinion_mount() {
	difference() {
		union() {
			// Main platform
			color("red") translate(rap_ppos)
				cube(rap_pdim);
			// Side walls
			*for (y = rap_swy) {
				color("green") translate([rap_swx, y, rap_swbot])
					cube(rap_swdim);
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
	cube();
}

rack_and_pinion_mount();
%ng_motor();














