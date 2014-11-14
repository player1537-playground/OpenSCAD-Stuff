tank_inner_radius = 51;
tank_wall_thickness = 2;
tank_outer_radius = tank_wall_thickness + tank_inner_radius;

tank_inner_height = 10;
tank_outer_height = tank_inner_height + 2 * tank_wall_thickness;

axle_radius = 4;
axle_hole_inner_radius = 4;
axle_hole_outer_radius = axle_hole_inner_radius + tank_wall_thickness;

support_step = 10;
support_list = [axle_hole_inner_radius : support_step : tank_inner_radius ];

water_hole_radius = 2;
water_hole_offset = support_step / 2;

water_hole_list = [axle_hole_inner_radius + water_hole_offset : support_step : tank_inner_radius];

module cylinder_shell(inner_radius=1, outer_radius=false, thickness=false, height=1) {
	if (outer_radius == false && thickness == false) {
		echo("Must supply one of outer_radius or thickness");
	}
	
	outer_radius = outer_radius != false ? outer_radius : inner_radius + thickness;
	
	difference() {
		cylinder(r=outer_radius, h=height);
		cylinder(r=inner_radius, h=height);
	}
}


module tank() {
	difference() {
		union() {
			cylinder_shell(inner_radius=tank_inner_radius, outer_radius=tank_outer_radius, height=tank_outer_height);
			cylinder(r=tank_outer_radius, h=tank_wall_thickness);
			translate([0, 0, tank_outer_height - tank_wall_thickness])
				cylinder(r=tank_outer_radius, h=tank_wall_thickness);
			cylinder_shell(inner_radius=axle_hole_inner_radius, outer_radius=axle_hole_outer_radius, height=tank_outer_height);
			translate([0, tank_inner_radius / 2, tank_outer_height / 2])
				cube([tank_wall_thickness, tank_inner_radius, tank_outer_height], center=true);
			for (r = support_list) {
				cylinder_shell(inner_radius=r, thickness=tank_wall_thickness, height=tank_outer_height);
			}
			
		}
		for (r = water_hole_list) {
			color("blue")
				translate([r, 0, tank_outer_height - tank_wall_thickness])
				cylinder(r=water_hole_radius, h=tank_wall_thickness);
		}
		cylinder(r=axle_hole_inner_radius, h=tank_outer_height);
	}		
}

difference() {
	tank();
	*translate([0, 0, tank_outer_height - tank_wall_thickness])
		cylinder(r=tank_outer_radius, h=tank_wall_thickness);
	*cylinder(r=tank_outer_radius, h=tank_wall_thickness);
	*cube([tank_outer_radius, tank_outer_radius, tank_outer_height]);
}











