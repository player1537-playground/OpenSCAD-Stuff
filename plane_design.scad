include <libraries/relativity.scad/relativity.scad>;

base_radius = 28.5 / 2;
hole_offset_radius = 22 / 2;
screw_radius = 3 / 2;
base_height = 10;
foam_hole_offset = 10;

foam_board_thickness = 4.7625; // 3/16 in

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

zippy_l = 35;
zippy_w = 17;
zippy_h = 76;

module zippy(anchor=bottom) {
    box([zippy_l, zippy_w, zippy_h], anchor=anchor, $class=$class);
}

module motor_mount() {
    assign($fn=20)
    rotated([0, 0, -45])
    differed("+", "-") {
	rod(r=base_radius, h=base_height, anchor=bottom, $class="+") {
	    align(bottom)
	    rotated([0, 0, 90], [0, 1, 2, 3])
	    translated([hole_offset_radius, 0, 0])
	    rod(r=screw_radius, h=$parent_size.z, anchor=bottom, $class="-");

	    align(top)
	    rotated([0, 0, 45])
	    rod([2 * base_radius, 2 * (hole_offset_radius / 2), 40], anchor=bottom, $class="+") {
		align(bottom)
		box([$parent_size.x, foam_board_thickness, $parent_size.z], anchor=bottom, $class="-");

		align(center)
		mirrored(z)
		translated([0, 0, foam_hole_offset])
		rotated([90, 0, 0])
		rod(r=screw_radius, h=base_radius, anchor=center, $class="-");
	    }
	}
    }
}

battery_mount_thickness = 4;
battery_mount_wall = 10;

module battery_mount() {
    differed("+", "-", $class=$class) {
	box([zippy_l + 2 * battery_mount_thickness, zippy_w, battery_mount_thickness], anchor=bottom, $class="+") {
	    align(bottom)
	    box([$parent_size.x + 2 * battery_mount_wall, $parent_size.y, $parent_size.z], anchor=bottom, $class="+")
	    align(bottom)
	    box([$parent_size.x, foam_board_thickness, $parent_size.z], anchor=bottom, $class="-");

	    mirrored(y)
	    align(top)
	    translated([0, $parent_size.y / 2, 0, 0])
	    align([0, 1, 0])
	    box([$parent_size.x, battery_mount_thickness, zippy_h], anchor=[0, -1, -1], $class="+");

	    mirrored(x)
	    align(top)
	    translated([$parent_size.x / 2, 0, 0])
	    box([battery_mount_thickness, $parent_size.y, zippy_h], anchor=[1, 0, -1], $class="+")
	    align([1, 0, -1])
	    box([battery_mount_wall, foam_board_thickness + 2 * battery_mount_thickness, $parent_size.z], anchor=[-1, 0, -1], $class="+")
	    align([-1, 0, -1])
	    box([$parent_size.x, foam_board_thickness, $parent_size.z], anchor=[-1, 0, -1], $class="-");
	}
    }
    %translated([0, 0, battery_mount_thickness])
    zippy();

    %box([100, foam_board_thickness, 100], anchor=bottom);
}

module plane() {
    color("blue")
    motor_mount();

    rotated([180, 0, 0])
    translated([0, 0, 1])
    color("orange")
    fc_28_12();

    color("red")
    differed("+", "-") {
	translated([0, 0, base_height])
	box([300, foam_board_thickness, 150], anchor=bottom, $class="+") {
	    align(top)
	    zippy(anchor=top, $class="-");

	    align(bottom)
	    mirrored(x)
	    translated([$parent_size.x / 2 / 2, 0, 0])
	    box([$parent_size.x / 3, foam_board_thickness, 20], anchor=bottom, $class="-")
	    translated([0, 0, -$parent_size.z - 5])
	    parent($class="+");
	}
    }
}

plane();

*differed("*", "/") {
    battery_mount($class="*");
    *translated([0, 0, 20])
    box([100, 100, 100], anchor=bottom, $class="/");
}