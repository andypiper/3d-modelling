/* use NopSCADlib to render a Pi Pico */

include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/pin_headers.scad>
include <NopSCADlib/vitamins/pcbs.scad>

rpi = RPI_Pico;

pcb(rpi);

/* -- *** -- */

/* -- *** -- */
