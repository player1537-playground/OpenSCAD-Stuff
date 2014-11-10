module base_cube($size=10) {
	minkowski() {
		cube($size, center=true);
		sphere(r=$size/2);
	}
}

module dot(x=0, y=0, $size=10) {
	translate([x, y])
	sphere(r=$size/10);
}

module number_dot(n=1, angle=[0, 0, 0], $size=10) {
	$fn = 5;
	rotate(angle)
	translate([0, 0, $size]) {
		if (n == 1 || n == 3 || n == 5) {
			dot(0, 0);
		}
		if (n == 3 || n == 5 || n == 2 || n == 4 || n == 6) {
			dot($size / 2, $size / 2);
			dot(-$size / 2, -$size / 2);
		}
		if (n == 5 || n == 4 || n == 6) {
			dot($size / 2, -$size / 2);
			dot(-$size / 2, $size /2);
		}
		if (n == 6) {
			dot($size / 2, 0);
			dot(-$size / 2, 0);
		}
	}
}

module die($size) {
	difference() {
		base_cube();
		number_dot(1, [0, 0, 0]);
		number_dot(2, [0, 90, 0]);
		number_dot(3, [90, 90, 0]);
		number_dot(4, [-90, 0, 0]);
		number_dot(5, [0, -90, 0]);
		number_dot(6, [0, 180, 0]);
	}
}

$fn = 20;
die(20);