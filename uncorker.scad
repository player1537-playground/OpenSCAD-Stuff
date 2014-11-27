include <libraries/relativity.scad/relativity.scad>;
use <libraries/publicDomainGearV1.1.scad>;

module _rod_rack(inner_radius=10, mm_per_tooth=9, number_of_teeth=7) {
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

module rod_rack(mm_per_tooth=9, height=10, inner_radius=12) {
    assign(pi = 3.1415926)
    assign(rack_height = 2 * mm_per_tooth / pi + inner_radius)
    assign(rack_y_offset = mm_per_tooth / pi + inner_radius)
    assign(number_of_teeth = floor(height / mm_per_tooth - 1/2)) // mm_per_tooth * number_of_teeth + mm_per_tooth * 1/2 = height
    assign(rack_length = mm_per_tooth * (number_of_teeth + 1/2))
    assign(rack_x_offset = mm_per_tooth * 3 / 4 + (height - rack_length) / 2)
    {
	echo(str("rh=", rack_height, ", y=", rack_y_offset, ", x=", rack_x_offset, ", n=", number_of_teeth));
	rotate_extrude()
	rotated([0, 0, 90])
	translated([rack_x_offset, rack_y_offset, 0])
	rack_outline(mm_per_tooth=mm_per_tooth, number_of_teeth=number_of_teeth, height=rack_height);

	rod(r=inner_radius, h=height, anchor=bottom);
    }
}

rod_rack(9, 100, 10);
%rod(r=10, h=100, anchor=bottom, $fn=10);

*translated([0, -2, 0])
square([10 * 17 + 10 * 1 / 2, 1]);