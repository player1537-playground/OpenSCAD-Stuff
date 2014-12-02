include <libraries/relativity.scad/relativity.scad>;

number_of_values = 40;

// Inner dial radius, thickness
inner_dial_r = 40;
inner_dial_thickness = 10;
// Inner dial stopper offset radius, width
inner_dial_stopper_or = 30;
inner_dial_stopper_w = 3;
// Inner dial slot offset radius, width
inner_dial_slot_or = 10;
inner_dial_slot_w = 3;
// Inner dial hole radius
inner_dial_hole_r = 4;
// Inner dial stopper location constants
START = 0;
MIDDLE = 1;
END = 2;

// Dial shaft

module inner_dial(value, stopper_location=START) {
	if (_has_token($class, $show))
	differed("+", "-") {
		rod(r=inner_dial_r, h=inner_dial_thickness, anchor=bottom, $class="+") {
			mirror(stopper_location == END ? z : [0, 0, 0])
			mirrored(stopper_location == MIDDLE ? z : [0, 0, 0])
			intersected(["0", "1"], $class="+") {
				align(top)
				rod($parent_size, anchor=bottom, $class="0");

				align(top)
				rotated([0, 0, 360 / number_of_values * value])
				translated([inner_dial_stopper_or, 0, 0])
				box([100, inner_dial_stopper_w, $parent_size.z], anchor=[-1, 0, -1], $class="1");
			}

			align(bottom)
			translated([inner_dial_slot_or, 0, 0])
			box([100, inner_dial_slot_w, $parent_size.z], anchor=[-1, 0, -1], $class="-");

			align(bottom)
			rod(r=inner_dial_hole_r, h=$parent_size.z, anchor=bottom, $class="-");
		}
	}
	_rod(r=inner_dial_r, h=2 * inner_dial_thickness, anchor=bottom)
	children();
}

module dial_shaft(num_dials=1, clearance=0, excess=0) {
	assign(num_ends = min(num_dials, 2))
	assign(num_middle = num_dials - num_ends)
	assign(num_dial_thickness = num_ends + num_middle * 2 + 1)
	assign(num_clearance = num_dials - 1)
	assign(width = inner_dial_hole_r - clearance)
	assign(height = num_dial_thickness * inner_dial_thickness + num_clearance * clearance + 2 * excess)
	translated([0, 0, -excess])
	box([width, width, height], anchor=bottom)

	translated([0, 0, excess])
	children();
}

dial_shaft(3, 1, excess=10)
align(bottom)
inner_dial(10, START)
align(top)
translated([0, 0, 1])
inner_dial(5, MIDDLE)
align(top)
translated([0, 0, 1])
inner_dial(8, END);
