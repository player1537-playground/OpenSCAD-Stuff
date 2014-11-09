// Courtesy of http://www.thingiverse.com/thing:38396

//LED Dimensions
led_d=5; //LED Diameter
led_h=8; //LED Height
led_fh=1; //LED FLange Thickness
led_fd=5.5; //LED Flange Diameter
led_wire_d=.5; //Wire Diameter
led_wire_h=10; //Wire Height
led_wire_da=2; // THe distance between the Wires

module led(){
  translate([0,0,led_fh])
    cylinder(h=led_h-(led_d/2)-led_fh,
	     r1=led_d/2,
	     r2=led_d/2,
	     $fn=25);
  translate([0,0,led_h-(led_d/2)])
    sphere(led_d/2,  $fn=25);
  cylinder(led_fh,led_fd/2,led_fd/2, $fn=25);
  translate([0,led_wire_da/2,-led_wire_h])cylinder(led_wire_h,led_wire_d/2,led_wire_d/2, $fn=25);
  translate([0,led_wire_da/-2,-led_wire_h])cylinder(led_wire_h,led_wire_d/2,led_wire_d/2, $fn=25);
}
