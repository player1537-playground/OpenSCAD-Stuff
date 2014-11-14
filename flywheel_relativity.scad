include <libraries/relativity.scad/relativity.scad>;

// rawr

module rod_shell(r=1, h=1, thickness=0.5) {
  differed("+", "-") {
    rod(r=r, h=h, $class="+") {
      rod([$parent_size.x - thickness, $parent_size.y - thickness, $parent_size.z], $class="-");
    }
  }
  assign($parent_size=[2 * r, 2 * r, h])
    children();
}

module supports(r=1, h=1, thickness=0.5) {
  if (r < $max_r) {
    echo(str("supports: ", "r=", r, "; h=", h, "; thickness=", thickness, "; $max_r=", $max_r, "; $step_r=", $step_r, "; $show=", $show, "; $class=", $class));
    rod_shell(r, h, thickness)
      supports(r + $step_r, h, thickness);
  }
}

$fn = 20;
rod_shell(6, 5, thickness=0.5) {
  assign($max_r=$parent_size.x / 2, $step_r=2) {
    echo(str("$max_r=", $max_r, "; $step_r=", $step_r));
    color("red") supports(r=2, h=$parent_size.z, thickness=0.5);
  }
  align(bottom)
    mirrored(z)
    rod(r=$parent_size.x / 2, h=1, anchor=bottom);
}

*assign($max_r=5, $step_r=2)
supports(r=2, h=5, thickness=0.5);

*rod_shell(5, 10, 1)
align(top)
box(10, anchor=bottom, $class="+");

*box(20)
align(top)
rotated(90*z, [0,1])
mirrored(x)
translated([$parent_size.x / 2, 0, 0])
box(0.8*$parent_size, anchor=[-1,0,-1]);
