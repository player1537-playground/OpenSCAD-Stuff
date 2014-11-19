include <libraries/relativity.scad/relativity.scad>;

base_l = 40;
base_w = 20;
base_h = 1;

tube_r = base_w / 2 - 3;
tube_h = 40;
tube_yoffset = 10;
tube_angle = 27.5;
tube_wall_thickness = 5;

tube_base_w = tube_r * 2;
tube_base_l = tube_base_w;
tube_base_h = 20;

differed("+", "-") {
  box([base_l, base_w, base_h], anchor=bottom, $class="+")
    align($inward)
      mirrored(x)
      mirrored(y)
      translated([base_w / 2, base_w / 2, 0])
      rotated(60)
      box([50, 50, 50], anchor=[-1, 0, 0], $class="-");
    differed("<", ">", $class="+")
      rotated([180, 0, 0])
      box([tube_base_w, tube_base_l, tube_base_h], anchor=bottom, $class="<")
      align(bottom)
      translated([0, 0, tube_yoffset])
      rotated([0, tube_angle, 0])
      box([30, 30, 30], anchor=bottom, $class=">");
    rotated([180, 0, 0])
      translated([0, 0, tube_yoffset])
      align(bottom)
      rotated([0, tube_angle, 0])
      rod(r=tube_r, h=tube_h, anchor=bottom, $class="+")
      align(bottom)
      rod(r=tube_r - tube_wall_thickness, h=tube_h, anchor=bottom, $class="-");
  }
}
