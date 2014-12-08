include <libraries/relativity.scad/relativity.scad>;
include <libraries/Thread_Library.scad>;

module screw(length=20, pitchRadius=10) {
	assign(pitch = 4)
	assign(stepsPerTurn = 12) {
		if (_has_token($show, $class))
		rotated([0, 0, 180], [0:1])
		trapezoidThread(length=length, 
		                pitch=pitch, 
		                profileRatio=0.1,
		                pitchRadius=pitchRadius,
		                stepsPerTurn=stepsPerTurn);

		//translated([0, 0, length / pitch * stepsPerTurn / (length/pitch - 1)])
		_rod(r=pitchRadius - pitch * 1/4, h=length, anchor=bottom)
		children();
	}
}

differed("+", "-") {
	rod(r=10, h=20, anchor=bottom, $class="+")
	align(bottom)
	screw(length=$parent_size.z, pitchRadius=$parent_size.x/2 - 2, $class="-");
}

