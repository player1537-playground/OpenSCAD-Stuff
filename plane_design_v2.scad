include <libraries/relativity.scad/relativity.scad>;
include <libraries/fc_28_12.scad>;

module box_ring(outer_side, inner_side=false, shell=false, h, anchor=center) {
	assign(inner_side = inner_side != false ? inner_side : outer_side - 2 * shell)
	if (_has_token($show, $class))
	difference() {
		box([outer_side, outer_side, h], anchor=anchor);
		box([inner_side, inner_side, h], anchor=anchor);
	}
	_box([outer_side, outer_side, h], anchor=anchor)
	children();
}

assign(offset = 10)
assign(shell = 1)
differed("+", "-") {
	box_ring(outer_side=20, shell=shell, h=5, anchor=bottom, $class="+") {
		box_ring(outer_side=$parent_size.x + 2*shell + offset, shell=shell, h=$parent_size.z, $class="+");

		rotated([0, 0, 90], [0:3])

		align([1, 1, -1])
		translated([-shell, -shell, 0])
		_box([offset/2 + 2*shell, offset/2 + 2*shell, $parent_size.z], anchor=[-1, -1, -1])
		box_ring(outer_side=$parent_size.x, shell=shell, h=$parent_size.z, $class="+")

		align([-1, -1, -1])
		translated([shell, shell, 0])
		box([100, 100, $parent_size.z], anchor=[-1, -1, -1], $class="-");

		align(bottom)
		intersected(["0", "1"], $class="+") {
			box($parent_size, anchor=bottom, $class="0")
			align(bottom)

			rotated([0, 0, 45], [-1, 1])
			box([1, sqrt(2)*$parent_size.x, $parent_size.z], anchor=bottom, $class="1");
		}
	}
}