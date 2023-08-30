/* uses the LEGO.scad library from
   https://github.com/cfinke/LEGO.scad */
   
use <LEGO.scad>;

/* headphones logo SVG from The Noun Project */
module logo(height) {
    linear_extrude(height = height) {
        scale(1)
        import("headphones.svg");
    }
}

/* tall brick for the large BYGGLEK */
/* logo added, but optional */
rotate([90,0,0])
color( "white" ) place(0, 0, 0) block(
    width=1,
    length=6,
    height=5,
    reinforcement=true
);

rotate([180,0,0])
color("black") place(1,-2.2,-0.6) logo(2);


/* smaller brick for smaller BYGGLEK */
rotate([90,0,0])
color( "white" ) place(0, 10, 0) block(
    width=1,
    length=4,
    height=3,
    reinforcement=true
);
