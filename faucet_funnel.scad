include <libraries/relativity.scad/relativity.scad>;

module ring(r1=1, r2=0, h=1, anchor=center, use_r1=true) {
	_rod(r=use_r1 ? r1 : r2, h=h, anchor=anchor) {
		if (_has_token($show, $class))
		difference() {
			rod(r=r1, h=h);
			rod(r=r2, h=h);
		}
		children();
	}
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

module faucet_adapter(faucet_radius, outer_radius, 
                      faucet_length, 
                      slot_height, slot_depth, slot_width) {
	differed("+", "-") {
		rod(r=outer_radius, h=faucet_length, anchor=bottom, $class="+")
		align(bottom) {
			rod(r=faucet_radius, h=$parent_size.z, anchor=bottom, $class="-");
	
			rotated([0, 0, 180], [0, 1]) {
				align([1, 0, 0])
				translated([-slot_depth, 0, 0])
				box([1000, slot_width, slot_height], anchor=[-1, 0, -1], $class="-");
		
				translated([0, 0, slot_height])
				translated([0, 0, -slot_depth])
				angle_intersected("A", 0, 90, $class="-")
				ring(r1=$parent_size.x/2 + 1, r2=$parent_size.x/2 - slot_depth, h=slot_width, anchor=bottom, $class="A");
			}
		}
	}
	_rod(r=outer_radius, h=faucet_length, anchor=bottom)
	children();
}

module cone_shell(r1=20, r2=10, h=10, shell=5, anchor=bottom, use_r1=true) {
	_rod(r=use_r1 ? r1 : r2, h=h, anchor=anchor) {
		if (_has_token($show, $class))
		align(bottom)
		difference() {
			cylinder(r1=r1, r2=r2, h=h);
			cylinder(r1=r1-shell, r2=r2-shell, h=h);
		}
		children();
	}
}

module funnel_adapter(adapter_radius, outer_radius, hole_radius, 
                      funnel_length, slot_length, 
                      slot_depth, slot_offset, anchor=bottom) {
	_rod(r=outer_radius, h=funnel_length + slot_length, anchor=anchor) {
		align(bottom)
		cone_shell(r1=hole_radius, r2=outer_radius, h=funnel_length, shell=outer_radius-adapter_radius, anchor=bottom, use_r1=false)
		align(top)
		ring(r1=$parent_size.x/2, r2=adapter_radius, h=slot_length, anchor=bottom, use_r1=false)
		rotated([0, 0, 180], [0, 1])
		align([1, 0, 1])
		translated([0, 0, -slot_offset])
		rod(d=1, h=slot_depth, orientation=[-1, 0, 0], anchor=[1, 0, 1], $fn=10);
	}
}

module faucet_funnel(faucet_radius, hole_radius, shell, 
                     faucet_length, slot_length, funnel_length,
                     slot_depth) {
	assign(slot_width = 1)
	faucet_adapter(faucet_radius=faucet_radius, 
	               outer_radius=faucet_radius + shell,
	               faucet_length=faucet_length, 
	               slot_depth=slot_depth,
	               slot_height=slot_length, 
	               slot_width=slot_width)
	align(bottom)
	translated([0, 0, -1])
	funnel_adapter(adapter_radius=faucet_radius + shell, 
	               outer_radius=faucet_radius + shell + shell, 
	               hole_radius=hole_radius,
	               funnel_length=funnel_length,
	               slot_length=slot_length,
	               slot_depth=slot_depth,
	               slot_offset=0,
	               anchor=top);
}

faucet_funnel(faucet_radius=10, faucet_length=5,
              hole_radius=5, funnel_length=5,
              shell=2,
              slot_length=4, slot_depth=1);















