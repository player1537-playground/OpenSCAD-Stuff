include <libraries/relativity.scad/relativity.scad>;

epsilon = 0.3;

shaft_inner_radius = 1.5 + epsilon;
shaft_outer_radius = shaft_inner_radius + 2;
shaft_length = 30;

hex_shaft_outer_radius = 5 + epsilon;

shaft_end_length = 10;

phillips_diameter = 3;
phillips_depth = 3 + epsilon;
phillips_width = 1;

hex_diameter = 7 + epsilon;
hex_width = 4 + epsilon;
hex_height = 6;

differed("+", "-") {
  // Main outer shaft
  rod(r=shaft_outer_radius, h=shaft_length, anchor=bottom, $class="+")
    // Inner shaft hole
    align(bottom)
    rod(r=shaft_inner_radius, h=shaft_length, anchor=bottom, $class="-")
    // Shaft end cap
    align(top)
    rod(r=hex_shaft_outer_radius, h=shaft_end_length, anchor=bottom, $class="+") {
    // Phillips holes
    rotated([0, 0, 90], [0, 1])
      align(bottom)
      box([phillips_diameter, phillips_width, phillips_depth], anchor=bottom, $class="-");
    // Hex tube
    align(top)
      rod(r=hex_shaft_outer_radius, h=hex_height, anchor=bottom, $class="+")
      // Hex hole
      rotated([0, 0, 60], [0, 1, 2])
      align(bottom)
      box([hex_diameter, hex_width, hex_height], anchor=bottom, $class="-");
  }
}
