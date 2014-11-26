include <libraries/relativity.scad/relativity.scad>;
use <libraries/publicDomainGearV1.1.scad>;

module rod_rack(inner_radius=10, mm_per_tooth=9, number_of_teeth=7) {
	assign(pi = 3.1415926)
	assign(height = number_of_teeth * mm_per_tooth + 3 / 4 * mm_per_tooth) {
		rotate_extrude()
		rotated([0, 0, 90])
		translated([mm_per_tooth * 3 / 4, mm_per_tooth / pi + inner_radius, 0])
		rack_outline(mm_per_tooth=mm_per_tooth, number_of_teeth=number_of_teeth, height=2 * mm_per_tooth / pi);
		cylinder(r=inner_radius, h=height);
	}
}

rod_rack(mm_per_tooth=13, number_of_teeth=20, inner_radius=10);
