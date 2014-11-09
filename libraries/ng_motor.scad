// Courtesy of http://www.thingiverse.com/thing:29734/

// base length, width, height
ng_motor_bl = 23;
ng_motor_bw = 12.5;
ng_motor_bh = 22;
ng_motor_bdim = [ng_motor_bl, ng_motor_bw, ng_motor_bh];
// mount length, width, height, bottom
ng_motor_ml = 32;
ng_motor_mw = 12;
ng_motor_mh = 2;
ng_motor_mdim = [ng_motor_ml, ng_motor_mw, ng_motor_mh];
ng_motor_mbot = 4;
// shaft base x offset, bottom, radius, and height
ng_motor_sbx = 5.5;
ng_motor_sbbot = ng_motor_bh / 2;
ng_motor_sbr = 6;
ng_motor_sbh = 4.625;
ng_motor_sbpos = [ng_motor_sbx, 0, ng_motor_sbbot];
// Ignoring the small, insignificant circle
// Drive gear x offset, bottom
ng_motor_dgx = -1;
ng_motor_dgbot = ng_motor_h / 2;

module ng_motor() {
  difference() {
    union() {
      // Main motor body
      color("steelblue")
	cube(ng_motor_bdim, center=true);
      // Mount
      color("red")
	translate([0,0,ng_motor_mbot + ng_motor_mh /2])
	cube(ng_motor_mdim, center=true);
      // Larger, lower shaft base
      color("green")
	translate(ng_motor_sbpos)
	cylinder(r=ng_motor_sbr, h=ng_motor_sbh, $fn=20);
      // Small insignificant circle
      color("yellow")
	translate([-.5,0,2.75])
	cylinder(r=1, h=25.75, $fn=20, center=true);
      // Drive gear beside the shaft base
      color("orange")
	translate([-1,0,2.75])
	cube([5,5.6,24.5], center=true);
      // Shaft/axle
      color("white")
	translate([5.5,0,3.65])
	cylinder(r=2.35, h=29.25, $fn=20, center=true);
    }
    // Angled part on the bottom of the servo
    translate([10,0,-11])
      rotate([0,-30,0])
      cube([8,13,4], center=true);
    // Mounting holes
    for (hole = [14,-14]) {
      translate([hole,0,5])
	cylinder(r=2.2, h=4, $fn=20, center=true);
    }
  }
}
