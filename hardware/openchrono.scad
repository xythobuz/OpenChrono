outer_dia = 55;
inner_dia = 8.5;
height = 100;

body_gap = 0.1;

body_screw_off = 10;
body_screw_pos = 20;
body_screw_dia = 3.3;
body_screw_head = 6.0;
body_screw_depth = 3.2;
body_screw_insert_dia = 4.8;
body_screw_insert_height = 12.0;

lcd_pcb_w = 29.0;
lcd_pcb_h = 29.0;
lcd_pcb_d = 5.2;
lcd_hole_dia = 1.9;
lcd_hole_w = 6.0;
lcd_hole_h = 2.5;
lcd_off = 10.0;
lcd_hole_off_x = 23.1;
lcd_hole_off_y = 23.65;
lcd_hole_off_y_total = 0.4;
lcd_hole_screw_len = 10.0;

arduino_w = 19.0;
arduino_h = 46.5 + 10;
arduino_d = 10.0;

bat_w = 11.5;
bat_l = 45.5;
bat_tab_w = 9.5;
bat_tab_h = 8.5;
bat_tab_d = 2.5; // TODO?
bat_tab_con_w = 5.0; // TODO?
bat_tab_con_h = 6.5; // TODO?
bat_spring_w = 7.5; // TODO?
bat_spring_dist = 7.5; // TODO?
bat_wall = 1.0;
bat_angle = 48;

led_dia = 3.3;
led_l = 4.5;
led_off = 15;
led_ridge_dia = 4.2;
led_ridge_h = 1.6;

switch_w = 12.0;
switch_h = 6.5;
switch_d = 10.0;
switch_plate_w = 20.5;
switch_plate_h = switch_h;
switch_dia = 2.4;
switch_screw_l = 10.0;
switch_screw_d = 15.0;
switch_off = 15;

// 1911
thread_profile_1911 = [
    true, // type is_male
    12.0, // diameter
    1.0, // pitch
    0.0, // offset
    9.0, // length
    0.0, // offset dia
    9.1, // inner hole
    true, // is cw thread
];

// M14x1.0 CW female thread
thread_profile_m14_cw = [
    false, // type is_male
    14.0, // diameter
    1.0, // pitch
    0.0, // offset
    12.0, // length
    0.0, // offset dia
    8.5, // inner hole
    true, // is cw thread
];

// M14x1.0 CCW female thread
thread_profile_m14_ccw = [
    false, // type is_male
    14.0, // diameter
    1.0, // pitch
    0.0, // offset
    12.0, // length
    0.0, // offset dia
    8.5, // inner hole
    false, // is cw thread
];

// ASG / KWC Cobray Ingram M11 CO2 NBB 6mm
thread_profile_mac11 = [
    false, // type is_male
    16.5, // diameter
    1.5, // pitch
    9.0, // offset
    10.0, // length
    20.0, // offset dia
    8.5, // inner hole
    true, // is cw thread
];

thread_profile_giant = [
    false, // type is_male
    34.0, // diameter
    1.0, // pitch
    0.0, // offset
    10.0, // length
    0.0, // offset dia
    8.5, // inner hole
    true, // is cw thread
];

thread_profiles = [
    thread_profile_1911,
    thread_profile_m14_cw,
    thread_profile_m14_ccw,
    thread_profile_mac11,
    thread_profile_giant
];

thread_base = 5.0;

test_bat_w = 47;
test_bat_h = 59;
test_bat_d = 15;
test_bat_dia = 2.9;
test_bat_off = 30.5;
test_bat_l = 8;

thread_adapter_screw_inset = 5;
thread_adapter_in_body = 5;
thread_adapter_h = body_screw_insert_height - thread_adapter_in_body;

text1 = [
    "OpenChrono",
    "Liberation Sans:style=Bold",
    12.0,
    2.0,
    55
];
text2 = [
    "by xythobuz.de",
    "Liberation Sans:style=Bold",
    9.0,
    2.0,
    -60
];

text3 = [
    "OpenChrono",
    "Liberation Sans:style=Bold",
    12.0 - 4,
    1.0,
    70
];
text4 = [
    "by xythobuz.de",
    "Liberation Sans:style=Bold",
    9.0 - 2,
    1.0,
    -70
];

texts_left = [ text1, text2 ];
texts_lipo = [ text3, text4 ];

lipo_lid_height = 65;
lipo_lid_width = 80;
lipo_lid_d = 3.0;
lipo_lid_gap = 0.5;
lipo_lid_gap_d = 0.2;

lipo_lid_screw_d_small = 2.8;
lipo_lid_screw_d_big = 3.3;
lipo_lid_screw_area = 10;
lipo_lid_screw_len = 10.0;
lipo_lid_screw_off = 5.0;

lipo_lid_compartment_d = 15.0;
lipo_lid_compartment_w = lipo_lid_width - 2 * lipo_lid_screw_area - 5;

lipo_pcb_w = 18.0;
lipo_pcb_h = 29.0;
lipo_pcb_d = 5.0;
lipo_pcb_usb_w = 9.0;
lipo_pcb_usb_h = 3.6;
lipo_pcb_usb_off = 1.4;
lipo_pcb_usb_wall = 1.5;
lipo_pcb_led_dia = 2.0;
lipo_pcb_led_dist = 5.0;
lipo_pcb_led_off_x = 1.75;
lipo_pcb_led_off_z = 7.0;

lipo_w = 30.0;
lipo_h = 43.0;
lipo_d = 9.0;

enable_gap_support = true;
include_uv_leds = true;

lipo_lid_angle = circum_angle(lipo_lid_width - lipo_lid_gap * 2, outer_dia);
lipo_lid_angle_hole = circum_angle(lipo_lid_width, outer_dia);
lipo_lid_angle_compartment = circum_angle(lipo_lid_compartment_w, outer_dia);

bat_h = bat_l + bat_spring_dist + 2 * bat_wall + 2 * bat_tab_d;

$fn = 42;

echo("sensor_distance", height - 2 * led_off);

if (include_uv_leds)
echo("uv_led_distance", led_off / 2);

// https://dkprojects.net/openscad-threads/
include <extern/threads.scad>

// how deep things on the outside have to be set in
function circle_offset_deviation(off, dia) =
    dia * (1 - sin(acos(off * 2 / dia))) / 2;

// circumference to angle
function circum_angle(width, dia) = width / dia * 180 / 3.141;

// from https://3dprinting.stackexchange.com/questions/10638/creating-pie-slice-in-openscad
module pie_slice(r, a) {
    intersection() {
        circle(r = r);
        
        square(r);
        
        rotate(a - 90)
        square(r);
    }
}

module lcd_cutout() {
    difference() {
        cube([lcd_pcb_w, lcd_pcb_h, lcd_pcb_d + 10]);
        
        for (x = [0, lcd_pcb_w - lcd_hole_w])
        for (y = [0, lcd_pcb_h - lcd_hole_w])
        translate([x, y, -1])
        cube([lcd_hole_w, lcd_hole_w, lcd_hole_h + 1]);
        
        // TODO hacky
        if (enable_gap_support)
        translate([0, (lcd_pcb_w - 1) / 2, 1])
        cube([lcd_pcb_w, 1, 8]);
    }
            
    for (x = [0, lcd_hole_off_x])
    for (y = [0, lcd_hole_off_y])
    translate([x + lcd_hole_w / 2, y + lcd_hole_w / 2 - lcd_hole_off_y_total, lcd_hole_h - lcd_hole_screw_len])
    cylinder(d = lcd_hole_dia, h = lcd_hole_screw_len + 1);
}

module arduino_cutout() {
    cube([arduino_w, arduino_h, arduino_d]);
}

module bat_cutout() {
    // battery
    translate([0, 0, bat_tab_d + bat_wall])
    cube([bat_w, bat_w, bat_l + bat_spring_dist]);
    
    // negative terminal
    for (z = [0, bat_l + bat_spring_dist + 2 * bat_wall + bat_tab_d])
    translate([(bat_w - bat_tab_w) / 2, (bat_w - bat_tab_h) / 2, z])
    cube([bat_tab_w, bat_tab_h + (bat_w - bat_tab_h) / 2, bat_tab_d]);

    // spring
    for (z = [bat_tab_d, bat_l + bat_spring_dist + bat_wall + bat_tab_d])
    translate([(bat_w - bat_spring_w) / 2, (bat_w - bat_spring_w) / 2, z - 0.1])
    cube([bat_spring_w, bat_spring_w + (bat_w - bat_spring_w) / 2, bat_wall + 0.2]);
}

module switch_cutout() {
    translate([-switch_w / 2, -10, -switch_h / 2])
    cube([switch_w, switch_d + 10, switch_h]);
    
    translate([-switch_plate_w / 2, -switch_d, -switch_plate_h / 2])
    cube([switch_plate_w, 10, switch_plate_h]);
    
    for (x = [1, -1])
    scale([x, 1, 1])
    translate([-switch_screw_d / 2, -10, 0])
    rotate([-90, 0, 0])
    cylinder(d = switch_dia, h = switch_screw_l + 10);
}

module thread(profile, thread_draw) {
    if (profile[0]) {
        // male thread
        difference() {
            union() {
                cylinder(d = outer_dia, h = thread_base + body_screw_depth);
                
                scale([1, profile[7] ? 1 : -1, 1])
                metric_thread(profile[1], profile[2], profile[4] + thread_base + body_screw_depth, test=!thread_draw);
            }
            
            translate([0, 0, -1])
            cylinder(d = profile[6], h = profile[4] + thread_base + body_screw_depth + 2);
        }
    } else {
        // female thread
        difference() {
            cylinder(d = outer_dia, h = thread_base + body_screw_depth + profile[4] + profile[3]);
            
            translate([0, 0, -1])
            scale([1, profile[7] ? 1 : -1, 1])
            metric_thread(profile[1], profile[2], profile[4] + thread_base + body_screw_depth + 2, true, test=!thread_draw);
            
            translate([0, 0, thread_base + body_screw_depth + profile[4]])
            cylinder(d = profile[5], h = profile[3] + 1);
            
            translate([0, 0, -1])
            cylinder(d = profile[6], h = profile[4] + thread_base + profile[3] + 2);
        } 
    }
}

module thread_profile_adapter(profile, draw_profile) {
    difference() {
        thread(profile, draw_profile);
        
        for (r = [45, -45])
        for (r2 = [0, 180])
        rotate([0, 0, r + r2])
        translate([0, (outer_dia - body_screw_insert_dia) / 2 - thread_adapter_screw_inset, 0]) {
            translate([0, 0, -1])
            cylinder(d = body_screw_dia, h = 50);
            
            translate([0, 0, thread_base])
            cylinder(d = body_screw_head, h = 50);
        }
    }
}

module mac11_extender() {
    difference() {
        cylinder(d = outer_dia, h = 15);
        
        translate([0, 0, -1])
        cylinder(d = 20, h = 15 + 2);
        
        for (r = [45, -45])
        for (r2 = [0, 180])
        rotate([0, 0, r + r2])
        translate([0, (outer_dia - body_screw_insert_dia) / 2 - thread_adapter_screw_inset, 0]) {
            translate([0, 0, -1])
            cylinder(d = body_screw_dia, h = 50);
        }
    }
}

module thread_adapter() {
    difference() {
        cylinder(d = outer_dia, h = thread_adapter_h);
        
        translate([0, 0, -1])
        cylinder(d = inner_dia, h = thread_adapter_h + 2);
        
        for (r = [45, -45])
        rotate([0, 0, r])
        translate([0, (outer_dia - body_screw_insert_dia) / 2 - thread_adapter_screw_inset, -thread_adapter_in_body])
        cylinder(d = body_screw_insert_dia, h = body_screw_insert_height + 1);
    }
}

module half_body(right_side) {
    difference() {
        union() {
            // body
            cylinder(d = outer_dia, h = height);
            
            translate([0, 0, height])
            thread_adapter();
        }
        
        // inner tube
        translate([0, 0, -1])
        cylinder(d = inner_dia, h = height + 2);
        
        // remove half of cylinder
        translate([-outer_dia / 2 - 1, -outer_dia + body_gap / 2, -1])
        cube([outer_dia + 2, outer_dia, height + 2]);
        
        // led cutouts
        for (x = [1, -1])
        scale([x, 1, 1])
        for (z = [led_off, height - led_off])
        translate([inner_dia / 2 - 1, 0, z])
        rotate([0, 90, 0]) {
            cylinder(d = led_dia, h = led_l + led_ridge_h + 1);
            
            translate([0, 0, led_l + 1])
            cylinder(d = led_ridge_dia, h = led_ridge_h);
        }
        
        if (include_uv_leds)
        for (x = [1, -1])
        scale([x, 1, 1])
        translate([inner_dia / 2 - 1, 0, led_off / 2])
        rotate([0, 90, 0]) {
            cylinder(d = led_dia, h = led_l + led_ridge_h + 1);
            
            translate([0, 0, led_l + 1])
            cylinder(d = led_ridge_dia, h = led_ridge_h);
        }
        
        // TODO hacky sensor cable, arduino side
        for (z = [1, -1])
        translate([0, 0, height / 2])
        scale([right_side ? -1 : 1, 1, z])
        translate([0, 0, height / 2 - led_off])
        hull() {
            for (x = [0, 5])
            translate([-inner_dia / 2 - led_l - led_ridge_h - x, 0, 0])
            rotate([0, 90, 0])
            cylinder(d = led_ridge_dia, h = led_ridge_h);
            
            translate([-inner_dia / 2 - led_l - led_ridge_h - 5, 0, -10])
            cylinder(d = led_ridge_dia, h = led_ridge_h);
            
            if (include_uv_leds)
            if (z < 0)
            for (x = [0, 5])
            translate([-inner_dia / 2 - led_l - led_ridge_h - x, 0, led_off / 2])
            rotate([0, 90, 0])
            cylinder(d = led_ridge_dia, h = led_ridge_h);
        }
        
        // TODO hacky led cable, led side
        for (z = [1, -1])
        translate([0, 0, height / 2])
        scale([right_side ? 1 : -1, 1, z])
        translate([0, 0, height / 2 - led_off])
        hull() {
            for (x = [0, 5])
            translate([-inner_dia / 2 - led_l - led_ridge_h - x, 0, 0])
            rotate([0, 90, 0])
            cylinder(d = led_ridge_dia, h = led_ridge_h);
            
            translate([-inner_dia / 2 - led_l - led_ridge_h - 5, 0, -height / 2 + led_off - 1])
            cube([led_ridge_dia + 2, led_ridge_dia - 2, led_ridge_h]);
            
            if (include_uv_leds)
            if (z < 0)
            for (x = [0, 5])
            translate([-inner_dia / 2 - led_l - led_ridge_h - x, 0, led_off / 2])
            rotate([0, 90, 0])
            cylinder(d = led_ridge_dia, h = led_ridge_h);
        }
    }
}

module screw_holes(with_head) {
    for (x = [body_screw_pos, -body_screw_pos])
    for (z = [body_screw_off, height - body_screw_off])
    translate([x, 0, z])
    rotate([-90, 0, 0]) {
        translate([0, 0, -1])
        if (with_head)
        cylinder(d = body_screw_dia, h = outer_dia / 2 + 2);
        else
        cylinder(d = body_screw_insert_dia, h = body_screw_insert_height);
        
        if (with_head)
        translate([0, 0, outer_dia / 2 - circle_offset_deviation(body_screw_pos + body_screw_head / 2, outer_dia) - body_screw_depth - 2])
        cylinder(d = body_screw_head, h = 50);
    }
}

module left_half() {
    difference() {
        half_body(false);
        
        translate([-outer_dia / 2 - 1, -outer_dia / 2 - 1 + body_gap / 2, height - 1])
        cube([outer_dia + 2, outer_dia / 2 + 1, 50]);
        
        screw_holes(false);
        
        translate([0, outer_dia / 2 - circle_offset_deviation(lcd_pcb_h / 2, outer_dia) - lcd_pcb_d, height / 2 + lcd_off])
        rotate([0, 90, 0])
        translate([lcd_pcb_w / 2, 0, -lcd_pcb_h / 2])
        rotate([90, 0, 180])
        lcd_cutout();
        
        translate([-outer_dia / 2 + ((outer_dia / 2) - (inner_dia / 2) - arduino_w) / 2, arduino_d / 2, -arduino_h / 2 + height / 2])
        rotate([90, 0, 0])
        arduino_cutout();
        
        translate([0, outer_dia / 2 - circle_offset_deviation(switch_plate_w / 2, outer_dia), height / 2 - switch_off])
        rotate([0, 0, 180])
        switch_cutout();
        
        // TODO hacky switch cable
        translate([-16, -10, height / 2 - switch_off])
        rotate([-90, 0, -27])
        cylinder(d = switch_h - 2, h = outer_dia);
        
        // TODO hacky lcd cable
        translate([-15, -10, 60])
        rotate([-90, 0, -12])
        cylinder(d = 6.0, h = outer_dia);
        
        // TODO hacky led cable
        translate([0, 0, height / 2 + 3]) {
            translate([inner_dia / 2 + led_l + led_ridge_dia / 2, led_ridge_h + inner_dia / 2 + 2, 0])
            rotate([90, 0, 0])
            cylinder(d = led_ridge_dia, h = led_ridge_h + inner_dia / 2 + 2);
            
            hull() {
                translate([inner_dia / 2 + led_l + led_ridge_dia / 2, led_ridge_h + inner_dia / 2 + 2, 0])
                rotate([90, 0, 0])
                cylinder(d = led_ridge_dia, h = led_ridge_h);
            
                translate([inner_dia / 2 + led_l + led_ridge_dia / 2 - 5, led_ridge_h + inner_dia / 2 + 2, 0])
                rotate([0, 90, 0])
                cylinder(d = led_ridge_dia, h = led_ridge_h + 5);
            }
            
            translate([inner_dia / 2 + led_l + led_ridge_dia / 2 - 25, led_ridge_h + inner_dia / 2 + 2, 0])
            rotate([0, 90, 0])
            cylinder(d = led_ridge_dia, h = led_ridge_h + 25);
            
            hull() {
                translate([inner_dia / 2 + led_l + led_ridge_dia / 2 - 25, led_ridge_h + inner_dia / 2 + 2, 0])
                rotate([90, 0, 0])
                cylinder(d = led_ridge_dia, h = led_ridge_h + 10);
            
                translate([inner_dia / 2 + led_l + led_ridge_dia / 2 - 25, led_ridge_h + inner_dia / 2 + 2, 0])
                rotate([0, 90, 0])
                cylinder(d = led_ridge_dia, h = led_ridge_h);
            }
        }
        
        for (t = texts_left)
        rotate([0, 0, -t[4]])
        translate([0, outer_dia / 2 - t[3], (height + thread_adapter_h) / 2])
        rotate([0, -90, -90])
        linear_extrude(height = t[3] + 1)
        text(t[0], size = t[2], font = t[1], halign = "center", valign="center");
    }
}

module right_half() {
    difference() {
        half_body(true);
        
        translate([-outer_dia / 2 - 1, -outer_dia / 2 - 1 + body_gap / 2, height - 1])
        cube([outer_dia + 2, outer_dia / 2 + 1, 50]);
        
        screw_holes(true);
        
        translate([outer_dia / 2 - arduino_w -((outer_dia / 2) - (inner_dia / 2) - arduino_w) / 2, arduino_d / 2, -arduino_h / 2 + height / 2])
        rotate([90, 0, 0])
        arduino_cutout();
    }
}

module right_half_aaa_bat() {
    difference() {
        right_half();
        
        for (a = [0, bat_angle, -bat_angle])
        rotate([0, 0, a])
        translate([-bat_w / 2, outer_dia / 2 - bat_w, (height - bat_h) / 2])
        bat_cutout();
    }
}

module right_halt_aa_bat() {
    difference() {
        right_half();
        
        difference() {
            translate([-test_bat_w / 2, outer_dia / 2 - circle_offset_deviation(test_bat_w / 2, outer_dia), (height - test_bat_h) / 2])
            cube([test_bat_w, test_bat_d + 1, test_bat_h]);
            
            // TODO hacky
            if (enable_gap_support)
            translate([-0.5, 14 + 1, 20])
            cube([1, 12, test_bat_h + 2]);
        }
        
        for (x = [test_bat_off / 2, -test_bat_off / 2])
        translate([x, outer_dia / 2 - circle_offset_deviation(test_bat_w / 2, outer_dia) - test_bat_l, height / 2])
        rotate([-90, 0, 0])
        cylinder(d = test_bat_dia, h = outer_dia / 2);
        
        // TODO hacky power cable
        translate([15, -10, 60])
        rotate([-90, 0, 12])
        cylinder(d = 6.0, h = outer_dia);
    }
}

module lipo_pcb_cutout() {
    translate([-lipo_pcb_w / 2, 0, lipo_pcb_usb_wall])
    cube([lipo_pcb_w, lipo_pcb_d, lipo_pcb_h]);
    
    translate([-lipo_pcb_usb_w / 2, lipo_pcb_usb_off, -1])
    cube([lipo_pcb_usb_w, lipo_pcb_usb_h, lipo_pcb_usb_wall + 2]);
    
    for (z = [0, lipo_pcb_led_off_z])
    translate([lipo_pcb_w / 2 - lipo_pcb_led_off_x, 0, lipo_pcb_usb_wall + lipo_pcb_led_off_z + z])
    rotate([-90, 0, 0])
    cylinder(d = lipo_pcb_led_dia, h = 42);
}

module lipo_lid() {
    difference() {
        rotate([0, 0, 90 - lipo_lid_angle / 2])
        linear_extrude(lipo_lid_height - lipo_lid_gap * 2)
        difference() {
            pie_slice(outer_dia / 2, lipo_lid_angle);
            pie_slice(outer_dia / 2 - lipo_lid_d + lipo_lid_gap_d, lipo_lid_angle);
        }
        
        // screw holes
        for (z = [0, lipo_lid_height - 2 * lipo_lid_screw_off])
        for (r = [1, -1])
        rotate([0, 0, r * (lipo_lid_angle / 2 - circum_angle(lipo_lid_screw_area / 2, outer_dia))])
        translate([0, outer_dia / 2 + 1, lipo_lid_screw_off - lipo_lid_gap + z])
        rotate([90, 0, 0])
        cylinder(d = lipo_lid_screw_d_big, h = lipo_lid_d + 2);
    }
}

module right_half_lipo() {
    difference() {
        right_half();
        
        // space for lid
        translate([0, 0, (height - lipo_lid_height) / 2])
        rotate([0, 0, 90 - lipo_lid_angle_hole / 2])
        linear_extrude(lipo_lid_height)
        difference() {
            pie_slice(outer_dia / 2 + 1, lipo_lid_angle_hole);
            pie_slice(outer_dia / 2 - lipo_lid_d, lipo_lid_angle_hole);
        }
        
        // compartment behind lid
        translate([0, 0, (height - lipo_lid_height) / 2])
        rotate([0, 0, 90 - lipo_lid_angle_compartment / 2])
        linear_extrude(lipo_lid_height)
        difference() {
            pie_slice(outer_dia / 2 - lipo_lid_d + 1, lipo_lid_angle_compartment);
            pie_slice(outer_dia / 2 - lipo_lid_d - lipo_lid_compartment_d, lipo_lid_angle_compartment);
        }
        
        // screw holes
        for (z = [0, lipo_lid_height - 2 * lipo_lid_screw_off])
        for (r = [1, -1])
        rotate([0, 0, r * (lipo_lid_angle / 2 - circum_angle(lipo_lid_screw_area / 2, outer_dia))])
        translate([0, outer_dia / 2, (height - lipo_lid_height) / 2 + lipo_lid_screw_off + z])
        rotate([90, 0, 0])
        cylinder(d = lipo_lid_screw_d_small, h = lipo_lid_d + lipo_lid_screw_len);
        
        // charging pcb
        translate([0, outer_dia / 2 - 11, 0]) {
            lipo_pcb_cutout();
            
            %translate([-(lipo_pcb_w - 1) / 2, 0.5, lipo_pcb_usb_wall])
            cube([lipo_pcb_w - 1, lipo_pcb_d - 1, lipo_pcb_h + 1]);
        }
        
        translate([-lipo_w / 2, outer_dia / 2 - lipo_lid_d - lipo_d - circle_offset_deviation(lipo_w / 2, outer_dia - (lipo_lid_d * 2)) - 1, 32]) {
            cube([lipo_w, lipo_d + 20, lipo_h]);
            
            %cube([lipo_w, lipo_d, lipo_h]);
        }
        
        // TODO hacky power cable
        translate([15, -10, 27])
        rotate([-90, 0, 15])
        cylinder(d = 6.0, h = outer_dia);
        
        for (t = texts_lipo)
        rotate([0, 0, -t[4]])
        translate([0, outer_dia / 2 - t[3], (height + thread_adapter_h) / 2])
        rotate([0, -90, -90])
        linear_extrude(height = t[3] + 1)
        text(t[0], size = t[2], font = t[1], halign = "center", valign="center");
    }
    
    // TODO hacky
    if (enable_gap_support) {
        translate([-0.5, 10, 17.5])
        cube([1, 17, lipo_lid_height + 1]);
        
        for (x = [-12, 11])
        translate([x, 10, 31])
        cube([1, 10, 45]);
    }
}

module assembly_right_half_lipo() {
    right_half_lipo();
    
    color("green")
    translate([0, 0, (height - lipo_lid_height) / 2 + lipo_lid_gap])
    lipo_lid();
}

module assembly_closed() {
    //right_half_aaa_bat();
    //right_halt_aa_bat();
    assembly_right_half_lipo();
    
    rotate([0, 0, 180])
    left_half();
    
    translate([0, 0, height + thread_adapter_h + 0.5])
    thread_profile_adapter(thread_profiles[0], false);
}

module assembly_opened(angle) {
    translate([-outer_dia / 2, 0, 0]) {
        rotate([0, 0, angle / 2])
        translate([outer_dia / 2, 0, 0])
        //right_half_aaa_bat();
        //right_halt_aa_bat();
        assembly_right_half_lipo();
        
        rotate([0, 0, -angle / 2])
        translate([outer_dia / 2, 0, 0])
        rotate([0, 0, 180])
        left_half();
    }
}

module print_all_thread_adapters() {
    for (p = [0 : len(thread_profiles) - 1])
    translate([(p - floor(len(thread_profiles) / 2)) * (outer_dia + 5), -outer_dia / 2 - 5, 0])
    thread_profile_adapter(thread_profiles[p], true);
}

module print(all_thread_adapters) {
    translate([outer_dia / 2 + 5, 0, 0])
    left_half();
    
    translate([-outer_dia / 2 - 5, 0, 0])
    //right_half_aaa_bat();
    //right_halt_aa_bat();
    right_half_lipo();

    if (all_thread_adapters)
    print_all_thread_adapters();
}

//lcd_cutout();

//left_half();
//right_half();

//right_half_aaa_bat();
//right_halt_aa_bat();

//right_half_lipo();
//lipo_lid();
//assembly_right_half_lipo();

//assembly_closed();
//assembly_opened(90);

//print(true);
//print(false);

//print_all_thread_adapters();

//thread_profile_adapter(thread_profile_1911, true);
//thread_profile_adapter(thread_profile_m14_cw, true);
//thread_profile_adapter(thread_profile_m14_ccw, true);
//thread_profile_adapter(thread_profile_giant, true);

thread_profile_adapter(thread_profile_mac11, true);
//mac11_extender();
