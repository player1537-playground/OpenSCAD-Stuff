use <libraries/publicDomainGearV1.1.scad>;

mm_per_tooth = 9;
n1 = 17;
n2 = 8;

gear(mm_per_tooth, number_of_teeth=n1);
translate([0, -pitch_radius(mm_per_tooth, n1), 0])
	rack(mm_per_tooth, n2, height=12);
