include <libraries/relativity.scad/relativity.scad>;
include <libraries/fc_28_12.scad>;

differed("+", "-") {
	box([20, 20, 4], anchor=bottom, $class="+") {
		align(bottom)
		box([$parent_size.x - 1, $parent_size.y - 1, $parent_size.z], anchor=bottom, $class="-")
		align(bottom)
		rotated([0, 0, 45])
		box([1, sqrt(2)*$parent_size.x, $parent_size.z], anchor=bottom, $class="+");
	}
}