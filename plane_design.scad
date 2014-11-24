include <libraries/relativity.scad/relativity.scad>;

base_radius = 28.5 / 2;
hole_offset_radius = 22 / 2;
screw_radius = 3 / 2;
base_height = 10;
foam_hole_offset = 10;

foam_board_thickness = 4.7625; // 3/16 in

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

motor_mount();
differed("+", "-") {
    translated([0, 0, base_height])
    box([300, foam_board_thickness, 150], anchor=bottom, $class="+")
    align(bottom)
    mirrored(x)
    translated([$parent_size.x / 2 / 2, 0, 0])
    box([$parent_size.x / 3, foam_board_thickness, 20], anchor=bottom, $class="-")
    translated([0, 0, -5])
    parent($class="+");
}