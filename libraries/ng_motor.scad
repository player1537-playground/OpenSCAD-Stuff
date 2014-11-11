// Courtesy of http://www.thingiverse.com/thing:29734/

// base length, width, height
ng_motor_bl = 23;
ng_motor_bw = 12.5;
ng_motor_bh = 22;
ng_motor_bdim = [ng_motor_bl, ng_motor_bw, ng_motor_bh];
// mount length, width, height, x offset, y offset, bottom
ng_motor_ml = 32;
ng_motor_mw = 12;
ng_motor_mh = 2;
ng_motor_mdim = [ng_motor_ml, ng_motor_mw, ng_motor_mh];
ng_motor_mx = (ng_motor_bl - ng_motor_ml) / 2;
ng_motor_my = (ng_motor_bw - ng_motor_mw) / 2;
ng_motor_mbot = ng_motor_bh / 2 + 4;
ng_motor_mpos = [ng_motor_mx, ng_motor_my, ng_motor_mbot];
// shaft base x offset, bottom, radius, and height
ng_motor_sbr = 6;
ng_motor_sbh = 4.625;
ng_motor_sbx = ng_motor_bl / 2 + 5.5;
ng_motor_sbbot = ng_motor_bh;
ng_motor_sby = ng_motor_bw / 2;
ng_motor_sbpos = [ng_motor_sbx, ng_motor_sby, ng_motor_sbbot];
// Ignoring the small, insignificant circle
// Drive gear x offset, y offset, bottom, length, width, height
ng_motor_dgl = 5;
ng_motor_dgw = 5.6;
ng_motor_dgh = 4.625;
ng_motor_dgdim = [ng_motor_dgl, ng_motor_dgw, ng_motor_dgh];
ng_motor_dgx = ng_motor_bl / 2 - ng_motor_dgl / 2 - 1;
ng_motor_dgy = ng_motor_bw / 2 - ng_motor_dgw / 2;
ng_motor_dgbot = ng_motor_bh;
ng_motor_dgpos = [ng_motor_dgx, ng_motor_dgy, ng_motor_dgbot];
// Drive axle radius, height, x offset, y offset, bottom
ng_motor_dar = 2.35;
ng_motor_dah = 2.65;
ng_motor_dax = ng_motor_bl / 2 + 5.5;
ng_motor_day = ng_motor_bw / 2;
ng_motor_dabot = ng_motor_sbbot + ng_motor_sbh;
ng_motor_dapos = [ng_motor_dax, ng_motor_day, ng_motor_dabot];
// Cutout x offset, y offset, bottom, angle, length, width, height
ng_motor_cl = 8;
ng_motor_cw = ng_motor_bw + 0.5;
ng_motor_ch = 4;
ng_motor_cdim = [ng_motor_cl, ng_motor_cw, ng_motor_ch];
ng_motor_cx = ng_motor_bl;
ng_motor_cy = ng_motor_bw / 2;
ng_motor_cbot = 0;
ng_motor_cpos = [ng_motor_cx, ng_motor_cy, ng_motor_cbot];
ng_motor_cangle = [0, -30, 0];
// Mounting holes x offsets, y offset, bottom, radius, height
ng_motor_mhx = [ng_motor_bl / 2 - 14, ng_motor_bl / 2 + 14];
ng_motor_mhy = ng_motor_bw / 2;
ng_motor_mhbot = ng_motor_mbot;
ng_motor_mhr = 2.2;
ng_motor_mhh = ng_motor_mh;
// Color
ng_motor_body_color = "steelblue";
ng_motor_axle_color = "white";
// Overall stats
ng_motor_w = ng_motor_mw;
ng_motor_h = ng_motor_bh + ng_motor_sbh + ng_motor_dah;

module ng_motor($fn=$fn) {
  difference() {
    union() {
      // Main motor body
      color(ng_motor_body_color)
	cube(ng_motor_bdim);
      // Mount
      color(ng_motor_body_color)
	translate(ng_motor_mpos)
	cube(ng_motor_mdim);
      // Larger, lower shaft base
      color(ng_motor_body_color)
	translate(ng_motor_sbpos)
	cylinder(r=ng_motor_sbr, h=ng_motor_sbh);
      // Small insignificant circle
      *color(ng_motor_body_color)
      	translate([-.5,0,2.75])
	cylinder(r=1, h=25.75, center=true);
      // Drive gear beside the shaft base
      color(ng_motor_body_color)
	translate(ng_motor_dgpos)
	cube(ng_motor_dgdim);
      // Drive axle
      color(ng_motor_axle_color)
	translate(ng_motor_dapos)
	cylinder(r=ng_motor_dar, h=ng_motor_dah);
    }
    // Angled part on the bottom of the servo
    translate(ng_motor_cpos)
      rotate(ng_motor_cangle)
      cube(ng_motor_cdim, center=true);
    // Mounting holes
    for (hole = ng_motor_mhx) {
      translate([hole, ng_motor_mhy, ng_motor_mhbot])
	cylinder(r=ng_motor_mhr, h=ng_motor_mhh);
    }
  }
}
