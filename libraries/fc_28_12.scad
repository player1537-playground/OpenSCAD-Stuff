include <relativity.scad/relativity.scad>;

// Motor radius, height
fc_28_12_mr = 28.5 / 2;
fc_28_12_mh = 30.5;
// Base radius
fc_28_12_br = 28.5 / 2;
fc_28_12_bh = 1;
// Small base radius, height
fc_28_12_sbr = fc_28_12_br / 2;
fc_28_12_sbh = 10;
// Hole offset radius, radius
fc_28_12_hor = 22 / 2;
fc_28_12_hr = 3 / 2;
// Axle radius, height
fc_28_12_ar = 3 / 2;
fc_28_12_ah = 16.8;
// Whole radius, height
fc_28_12_r = fc_28_12_mr;
fc_28_12_h = fc_28_12_mh + fc_28_12_ah;

module fc_28_12() {
	differed("+", "-", $class=$class) {
		rod(r=fc_28_12_br, h=fc_28_12_bh, anchor=bottom, $class="+") {
			align(bottom)
			rotated([0, 0, 90], [0, 1, 2, 3])
			translated([fc_28_12_hor, 0, 0])
			rod(r=fc_28_12_hr, h=$parent_size.z, anchor=bottom, $class="-");
			
			align(top)
			rod(r=fc_28_12_sbr, h=fc_28_12_sbh, anchor=bottom, $class="+")

			align(top)
			rod(r=fc_28_12_mr, h=fc_28_12_mh - fc_28_12_sbh - fc_28_12_bh, anchor=bottom, $class="+")

			align(top)
			rod(r=fc_28_12_ar, h=fc_28_12_ah, anchor=bottom, $class="+");
		}
	}
}

//fc_28_12();
