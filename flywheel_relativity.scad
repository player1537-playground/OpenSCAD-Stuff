include <libraries/relativity.scad/relativity.scad>;

// rawr

module rod_shell(r=1, h=1, thickness=0.5) {
  differed("+", "-") {
    rod(r=r, h=h, $class="+") {
      rod([$parent_size.x - thickness, $parent_size.y - thickness, $parent_size.z], $class="-");
    }
  }
  rod(r=r, h=h, $class="_", $show="!")
    assign($show="", $class="")
    children();
}

module supports(r=1, h=1, thickness=0.5) {
  if (r < $max_r) {
    echo(str("supports: ", "r=", r, "; h=", h, "; thickness=", thickness, "; $max_r=", $max_r, "; $step_r=", $step_r, "; $show=", $show, "; $class=", $class));
    rod_shell(r, h, thickness)
      supports(r + $step_r, h, thickness);
  }
}

module flywheel(inner_radius=6, axle_radius=2, height=5, thickness=0.5, support_step=2) {
  rod_shell(r=inner_radius, h=height, thickness=thickness) {
    assign($max_r=$parent_size.x / 2, $step_r=support_step) {
      echo(str("$max_r=", $max_r, "; $step_r=", $step_r));
      color("red") supports(r=axle_radius, h=$parent_size.z, thickness=thickness);
    }
    mirrored(z)
      align(bottom)
      rod(r=$parent_size.x / 2, h=thickness, anchor=bottom);
    differed("+", "-") {
      box([$parent_size.x / 2, thickness, height], anchor=[-1, 0, 0], $class="+");
      rod(r=axle_radius, h=height, $class="-");
      rod_shell(r=inner_radius + thickness / 2, h=height, thickness=thickness, $class="-");
    }
  }
}

$fn = 20;
difference() {
  flywheel(6, 2, 5, 0.5, 2);
  rod(r=6, h=5, anchor=top);
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
