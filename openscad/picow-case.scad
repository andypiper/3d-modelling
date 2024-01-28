// written by ChatGPT and tweaked

// Variables
pico_length = 52;
pico_width = 21;
pico_height = 4;
sensor_length = 19;
sensor_width = 19;
sensor_height = 3;
case_thickness = 1;
bottom_base_thickness = 6;
extra_space = 4;
usb_width = 2.5;
usb_height = 8;
usb_offset_x = 3;
usb_offset_y = 11;
clip_depth = 3;
clip_height = 3;
clip_width = 5;
clip_offset = 20;
magnet_diameter = 5;
magnet_depth = 3;
magnet_spacing = 25;
wall_thickness = 1;
magnet_layer_thickness = 1;
corner_radius = 0.8;

// Rounded box function
module rounded_box(x, y, z, r) {
    hull() {
        for (i = [0:1]) {
            for (j = [0:1]) {
                for (k = [0:1]) {
                    translate([i * (x - 2 * r), j * (y - 2 * r), k * (z - 2 * r)]) {
                        sphere(r, $fn = 50);
                    }
                }
            }
        }
    }
}


// Bottom part
module bottom() {
    difference() {
        // Base
        rounded_box(pico_length + sensor_length + 2 * case_thickness, max(pico_width, sensor_width) + 2 * case_thickness, bottom_base_thickness, corner_radius);


        // Pico cavity
        translate([case_thickness, case_thickness, magnet_layer_thickness]) {
            cube([pico_length, pico_width, case_thickness + pico_height + extra_space]);
        }

        // Sensor cavity
        translate([case_thickness + pico_length, case_thickness, magnet_layer_thickness]) {
            cube([sensor_length, sensor_width, case_thickness + sensor_height + extra_space]);
        }

        // Magnet cutouts from the underside
        for (i = [0:1]) {
            translate([case_thickness + pico_length / 2 - magnet_diameter / 2 + i * magnet_spacing, case_thickness + pico_width / 2 - magnet_diameter / 2, -1]) {
                #cylinder(h = magnet_depth, r = magnet_diameter / 2, $fn = 50);
            }
        }
    }

    // Wall between Pico and sensor
    translate([case_thickness + pico_length - wall_thickness / 2, case_thickness, magnet_layer_thickness]) {
        cube([wall_thickness, sensor_width, bottom_base_thickness - magnet_layer_thickness]);
    }

//    // USB cutout
//    translate([case_thickness, case_thickness + (pico_width - usb_height) / 2, magnet_layer_thickness]) {
//        #cube([usb_width, usb_height, case_thickness + pico_height]);
//    }
}

// Top part
module top() {
    difference() {
        // Lid
        rounded_box(pico_length + sensor_length + 2 * case_thickness, max(pico_width, sensor_width) + 2 * case_thickness, case_thickness, corner_radius);


        // Clip cutouts
        for (i = [0:1]) {
            translate([clip_offset + i * (pico_length + sensor_length - 2 * clip_offset), case_thickness, 0]) {
                cube([clip_width, clip_depth, clip_height]);
            }
        }
    }
}

// Assemble bottom part
difference() {
    translate([0, 0, 0]) {
        bottom();
    }
    
    // USB cutout
    // the # makes it visible
    #translate([-1, case_thickness + (pico_width - usb_height) / 2, magnet_layer_thickness]) {
        cube([usb_width, usb_height, case_thickness + pico_height]);
    }
}

// Assemble top part
//translate([0, 0, bottom_base_thickness]) {
//    top();
//}
