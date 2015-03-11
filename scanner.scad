include <relativity.scad>;

module gear(r=20, h=1, teeth_sep_deg=30, class="*") {
    show(class)
    rod(r=r, h=h, anchor=bottom)
    rotated(teeth_sep_deg, [0:360/teeth_sep_deg])
    translated([$parent_size.x/2, 0, 0])
    align(bottom)
    rotated(45)
    box($parent_size.z, anchor=bottom);
}

module outer(r=20, h=1, width=5, class="*") {
    show(class)
    differed(positive="+", negative="-", unaffected="rest") {
        rod(r=r, h=h, anchor=bottom, $class="+")
        align(bottom)
        rod(r=$parent_size.x/2-width, h=$parent_size.z, anchor=bottom, $class="-")
        align(bottom)
        gear(r=$parent_size.x/2, h=$parent_size.z, teeth_sep_deg=5, $class="-");
    }
}

outer();
translated([20-5-5, 0, 0])
align(bottom)
gear(r=5, h=1, teeth_sep_deg=15);