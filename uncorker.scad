include <libraries/relativity.scad/relativity.scad>;
use <libraries/publicDomainGearV1.1.scad>;

module rod_rack(inner_radius=10, mm_per_tooth=9, number_of_teeth=7) {
	assign(pi = 3.1415926)
	assign(height = number_of_teeth * mm_per_tooth + 1 / 4 * mm_per_tooth) {
		rotate_extrude()
		rotated([0, 0, 90])
		translated([mm_per_tooth * 1 / 4, mm_per_tooth / pi + inner_radius, 0])
		rack_outline(mm_per_tooth=mm_per_tooth, number_of_teeth=number_of_teeth, height=2 * mm_per_tooth / pi);
		cylinder(r=inner_radius, h=height);
	}
}

*rod_rack(mm_per_tooth=13, number_of_teeth=20, inner_radius=10);
*translated([20, 0, 0])
rod(r=10, h=20 * 13, anchor=bottom);

rotate_extrude()
translated([10 * 3 / 4, 3 / 2 * 10 / 3.1415926, 0])
rack_outline(mm_per_tooth=10, number_of_teeth=17, height=5 / 2 * 10 / 3.1415926);
translated([0, -2, 0])
square([10 * 17 + 10 * 1 / 2, 1]);