include <libraries/ng_motor.scad>;

difference() {
  ng_motor();
  *translate([0, ng_motor_bw / 2, 0])
    cube([ng_motor_bl, ng_motor_bw, ng_motor_bh]);
}
