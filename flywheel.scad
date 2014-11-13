tank_inner_radius = 20;
tank_wall_thickness = 2;
tank_outer_radius = tank_wall_thickness + tank_inner_radius;

tank_inner_height = 10;
tank_outer_height = tank_inner_height + 2 * tank_wall_thickness;

axle_radius = 4;
axle_hole_inner_radius = 4;
axle_hole_outer_radius = axle_hole_inner_radius + tank_wall_thickness;

water_hole_radius = 2;
water_hole_offset_radius = (tank_inner_radius + axle_hole_outer_radius) / 2;


module tank() {
	difference() {
		union() {
			difference() {
				cylinder(r=tank_outer_radius, h=tank_outer_height);
				translate([0, 0, tank_wall_thickness])
					cylinder(r=tank_inner_radius, h=tank_inner_height);
			}
			cylinder(r=axle_hole_outer_radius, h=tank_outer_height);
			translate([0, tank_inner_radius / 2, tank_outer_height / 2])
				cube([tank_wall_thickness, tank_inner_radius, tank_outer_height], center=true);
		}
		cylinder(r=axle_hole_inner_radius, h=tank_outer_height);
		color("blue")
		translate([water_hole_offset_radius, 0, tank_outer_height - tank_wall_thickness])
			cylinder(r=water_hole_radius, h=tank_wall_thickness);
	}		
}

difference() {
	tank();
	translate([0, 0, tank_outer_height - tank_wall_thickness])
		cylinder(r=tank_outer_radius, h=tank_wall_thickness);
	cube([tank_outer_radius, tank_outer_radius, tank_outer_height]);
}