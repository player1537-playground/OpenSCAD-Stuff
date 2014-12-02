include <libraries/relativity.scad/relativity.scad>;

number_of_values = 40;

inner_dial_r = 40;
inner_dial_thickness = 10;

inner_dial_stopper_or = 30;
inner_dial_stopper_w = 3;

inner_dial_slot_or = 10;
inner_dial_slot_w = 3;

module inner_dial(value) {
	differed("+", "-") {
		rod(r=inner_dial_r, h=inner_dial_thickness, anchor=bottom, $class="+") {
			intersected(["0", "1"], $class="+") {
				align(top)
				rod($parent_size, anchor=bottom, $class="0");

				align(top)
				translated([inner_dial_stopper_or, 0, 0])
				box([100, inner_dial_stopper_w, $parent_size.z], anchor=[-1, 0, -1], $class="1");
			}

			align(bottom)
			rotated([0, 0, 360 / number_of_values * value])
			translated([inner_dial_slot_or, 0, 0])
			box([100, inner_dial_slot_w, $parent_size.z], anchor=[-1, 0, -1], $class="-");
		}
	}
}

inner_dial(10);