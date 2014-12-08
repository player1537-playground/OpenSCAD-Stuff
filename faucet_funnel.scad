include <libraries/relativity.scad/relativity.scad>;

module ring(r1=1, r2=0, h=1, anchor=center) {
	if (_has_token($show, $class))
	difference() {
		rod(r=r1, h=h, anchor=anchor);
		rod(r=r2, h=h, anchor=anchor);
	}
	children();
}

module angle_piece(start_angle=0, end_angle=360, r=1000, h=1000) {
	if (_has_token($show, $class))
	assign(orig_delta = end_angle - start_angle)
	assign(delta = orig_delta > 180 ? 180 : orig_delta) {
		if (orig_delta > 180)
		angle_piece(start_angle=180, end_angle=end_angle, r=r, h=h);

		rotate(start_angle)
		linear_extrude(height=h, center=true)
		polygon(points=[[0,0],
		                [r*cos(0),r*sin(0)],
		                [r*cos(0),r*sin(delta/2)],
		                [r*cos(delta/2),r*sin(delta/2)],
		                [r*cos(delta),r*sin(delta/2)],
		                [r*cos(delta),r*sin(delta)]]);
	}
}

module angle_intersected(class="", start_angle=0, end_angle=360) {
	if (_has_token($show, $class))
	intersection() {
		assign($show=class)
		children();
		angle_piece(start_angle=start_angle, end_angle=end_angle);
	}
	children();
}

differed("+", "-") {
	rod(r=10, h=10, anchor=bottom, $class="+")
	align(bottom) {
		rod(r=$parent_size.x/2 - 3, h=$parent_size.z, anchor=bottom, $class="-");

		rotated([0, 0, 180], [0, 1]) {
			align([1, 0, 0])
			translated([-1, 0, 0])
			box([1000, 1, $parent_size.z/2], anchor=[-1, 0, -1], $class="-");
	
			translated([0, 0, $parent_size.z/2]) {
				translated([0, 0, -1])
				angle_intersected("A", 0, 90, $class="-")
				ring(r1=$parent_size.x/2 + 1, r2=$parent_size.x/2 - 1, h=1, anchor=bottom, $class="A");
	
				align([0, 1, 0])
				translated([0, -1, 0])
				box([1, 1000, $parent_size.z/2/2], anchor=[0, -1, 1], $class="-");
			}
		}
	}
}

*translated([0, 0, 40])
angle_intersected("A", start_angle=0, end_angle=180+60)
ring(10, 5, 20, $class="A");
