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

bat_h = bat_l + bat_spring_dist + 2 * bat_wall + 2 * bat_tab_d;

$fn = 42;

echo("sensor_distance", height - 2 * led_off);

// https://dkprojects.net/openscad-threads/ 
include <extern/threads.scad>

// 1911
thread_profile_1911 = [
    true, // type is_male
    12.0, // diameter
    1.0, // pitch
    0.0, // offset
    9.0 // length
];

// M14x1.0 female thread
thread_profile_m14 = [
    false, // type is_male
    14.0, // diameter
    1.0, // pitch
    0.0, // offset
    12.0 // length
];

// ASG / KWC Cobray Ingram M11 CO2 NBB 6mm
thread_profile_mac11 = [
    false, // type is_male
    16.5, // diameter
    1.5, // pitch
    8.0, // offset
    10.0 // length
];

// debug / testing
thread_profile_none = [ false, 0, 0, 0, 0 ];

thread_profiles = [
    thread_profile_1911,
    thread_profile_m14,
    thread_profile_mac11
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

enable_gap_support = true;

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

texts_left = [ text1, text2 ];

include_uv_leds = true;

// how deep things on the outside have to be set in
function circle_offset_deviation(off, dia) =
    dia * (1 - sin(acos(off * 2 / dia))) / 2;

module lcd_cutout() {
    difference() {
        cube([lcd_pcb_w, lcd_pcb_h, lcd_pcb_d + 10]);
        
        for (x = [0, lcd_pcb_w - lcd_hole_w])
        for (y = [0, lcd_pcb_h - lcd_hole_w])
        translate([x, y, -1])
        cube([lcd_hole_w, lcd_hole_w, lcd_hole_h + 1]);
        
        // TODO hacky
        if (enable_gap_support)
        translate([0, (lcd_pcb_w - 1) / 2, 0])
        cube([lcd_pcb_w, 1, 9]);
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
                cylinder(d = outer_dia, h = thread_base);
                metric_thread(profile[1], profile[2], profile[4] + thread_base, test=!thread_draw);
            }
            
            translate([0, 0, -1])
            cylinder(d = inner_dia, h = profile[4] + thread_base + 2);
        }
    } else {
        // female thread
        difference() {
            cylinder(d = outer_dia, h = thread_base + profile[4] + profile[3]);
            
            metric_thread(profile[1], profile[2], profile[4] + thread_base + 1, true, test=!thread_draw);
            
            translate([0, 0, thread_base + profile[4]])
            cylinder(d = profile[1] + 2, h = profile[3] + 1);
            
            translate([0, 0, -1])
            cylinder(d = inner_dia, h = profile[4] + thread_base + profile[3] + 2);
        } 
    }
}

module thread_profile_adapter(profile, draw_profile) {
    difference() {
        thread(profile, draw_profile);
        
        for (r = [45, -45])
        for (r2 = [0, 180])
        rotate([0, 0, r + r2])
        translate([0, (outer_dia - body_screw_insert_dia) / 2 - thread_adapter_screw_inset, -1])
        cylinder(d = body_screw_dia, h = 100);
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

module right_half_testing() {
    difference() {
        right_half();
        
        difference() {
            translate([-test_bat_w / 2, outer_dia / 2 - circle_offset_deviation(test_bat_w / 2, outer_dia), (height - test_bat_h) / 2])
            cube([test_bat_w, test_bat_d + 1, test_bat_h]);
            
            // TODO hacky
            if (enable_gap_support)
            translate([-0.5, 14, 20])
            cube([1, 13, test_bat_h + 2]);
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

module assembly_closed() {
    //right_half_aaa_bat();
    right_half_testing();
    
    rotate([0, 0, 180])
    left_half();
    
    translate([0, 0, height + thread_adapter_h + 0.5])
    thread_profile_adapter(thread_profiles[0], false);
}

module assembly_opened(angle) {
    translate([-outer_dia / 2, 0, 0]) {
        //rotate([0, 0, angle / 2])
        //translate([outer_dia / 2, 0, 0])
        //right_half_aaa_bat();
        
        rotate([0, 0, angle / 2])
        translate([outer_dia / 2, 0, 0])
        right_half_testing();
        
        rotate([0, 0, -angle / 2])
        translate([outer_dia / 2, 0, 0])
        rotate([0, 0, 180])
        left_half();
    }
}

module print(all_thread_adapters) {
    translate([outer_dia / 2 + 5, 0, 0])
    left_half();
    
    //translate([-outer_dia / 2 - 5, 0, 0])
    //right_half_aaa_bat(true);
    
    translate([-outer_dia / 2 - 5, 0, 0])
    right_half_testing();

    if (all_thread_adapters)
    for (p = [0 : len(thread_profiles) - 1])
    translate([(p - floor(len(thread_profiles) / 2)) * (outer_dia + 5), -outer_dia / 2 - 5, 0])
    thread_profile_adapter(thread_profiles[p], true);
}

//lcd_cutout();

//left_half();
//right_half();

//assembly_closed();
//assembly_opened(90);

//print(true);
print(false);
