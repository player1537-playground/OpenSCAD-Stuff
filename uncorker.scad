include <libraries/relativity.scad/relativity.scad>;
use <libraries/publicDomainGearV1.1.scad>;

module rod_rack(mm_per_tooth=9, height=10, inner_radius=12, anchor=$inward, orientation=top) {
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

	rod(r=inner_radius, h=height, anchor=bottom)
	children();
    }
//    _rod(r=inner_radius, h=height, anchor=bottom)
//    children();
}

rod_rack(mm_per_tooth=9, height=100, inner_radius=10)
align(bottom)
%rod(size=hammard($parent_size, [2,2,1]), anchor=bottom);
