// from https://github.com/alanpreed/Picoprobe-enclosure

pico_x = 21;
pico_y = 51;
pico_z = 1;
pico_hole_d = 2.1;
pico_hole_x_pos = 11.4 / 2;
pico_hole_y_pos = (pico_y / 2) - 2;

button_x = 3.4;
button_y = 4.3;
button_z = 2.5;
button_x_pos = -((pico_x / 2) - 5.5);
button_y_pos = ((pico_y / 2) - 14.5);

led_x = 2;
led_y = 1;
led_z = 0.5;
led_x_pos = -(pico_x / 2 - 3.75);
led_y_pos = pico_y / 2 - 5;

usb_x = 7.6;
usb_y = 5.5;
usb_z = 2.8;
usb_x_pos = 0;
usb_y_pos = pico_y/2 - 4.5;
usb_z_pos = 0;



module pico_holes(){
    for (i = [[pico_hole_x_pos, pico_hole_y_pos, 0], 
           [pico_hole_x_pos, -pico_hole_y_pos, 0], 
           [-pico_hole_x_pos, -pico_hole_y_pos, 0], 
           [-pico_hole_x_pos, pico_hole_y_pos, 0]]){
        translate(i){
            children();
        }
    }
}

module pico_button(){
    translate([button_x_pos + button_x/2, button_y_pos + button_y/2, 0]){
        children();
    }
}

module pico_led(){
    translate([led_x_pos + led_x/2, led_y_pos + led_y / 2, 0]){
        children();
    }
}

module pico_usb(){
    translate([usb_x_pos, usb_y_pos + usb_y/2, usb_z_pos]){
        children();
    }
}

module pico(){
    difference(){
        union(){
            cube([pico_x, pico_y, pico_z], center=true);
            translate([0, 0, pico_z/2]){
                pico_button(){
                    translate([0, 0, button_z/2]){
                        cube([button_x, button_y, button_z], center=true);
                    }
                }
                pico_led(){
                    translate([0, 0, led_z/2]){
                        cube([led_x, led_y, led_z], center=true);
                    }
                }
                pico_usb(){
                    translate([0, 0, usb_z/2]){
                        cube([usb_x, usb_y, usb_z], center=true);
                    }
                }                
            }
        }
        
        pico_holes(){
            cylinder(h = 2* pico_z, d = pico_hole_d, center=true, $fn=20);
        }
    }
}

pico();