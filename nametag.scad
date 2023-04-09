// via https://github.com/hugs/nametags
// parameterized and using BOSL2 features

// Dependencies:
// Font: https://www.google.com/fonts/specimen/Allerta+Stencil
// BOSL2 library: https://github.com/revarbat/BOSL2

include <BOSL2/std.scad>

// uncomment if not installed at system level
// use <font/Allerta_Stencil/AllertaStencil-Regular.ttf>

name = "@andypiper";
nametag_font = "AllertaStencil";
// nametag_font = "StardosStencil";
nametag_font_size = 13.5;
nametag_width = 8*16;

// You "shouldn't" need to change anything below:
$fn = 60;
beam_width    = 8;
hole_diameter = 5.1;
hole_radius   = hole_diameter / 2;
number_of_holes = 10;
dimensions=[nametag_width,8*4,4];

difference() {
    cuboid(dimensions, rounding = 2, edges = "Z");

    translate([0,0,-1])
        text3d(name,
            size = nametag_font_size,
            font = nametag_font,
            anchor=CENTER, atype="ycenter",
            h = 10);

    translate([-nametag_width/2+4,-16,-7])
    rotate([0,0,90])
    holes(4);

    translate([nametag_width/2-4,-16,-7])
    rotate([0,0,90])
    holes(4);
}

module holes(number_of_holes) {
    beam_length = number_of_holes * 8;
    for (x=[beam_width : beam_width : beam_length]) {
        translate([x-4,0,2])
        cylinder(r=hole_radius, h=12, $fn=30);
    }
}

module hoop() {
    // idea is to add a hoop on the back for a pin
}
