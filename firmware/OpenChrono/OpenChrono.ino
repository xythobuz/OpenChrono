/*
 * OpenChrono.ino
 *
 * OpenChrono BB speed measurement device.
 *
 * Copyright (c) 2022 Thomas Buck <thomas@xythobuz.de>
 *
 * OpenChrono is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * OpenChrono is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with OpenChrono.  If not, see <https://www.gnu.org/licenses/>.
 *
 * The goal is to measure the speed of a BB moving through the device.
 */

#include "timing.h"
#include "ticks.h"
#include "lcd.h"
#include "config.h"

static void calculate(uint16_t a, uint16_t b) {
    uint16_t ticks = 0;

    if (b >= a) {
        // simple case - just return difference
        ticks = b - a;
    } else {
        // the timer overflowed between measurements!
        int32_t tmp = ((int32_t)b) - ((int32_t)a);
        tmp += 0x10000;
        ticks = (uint16_t)tmp;
    }

    double speed = tick_to_metric(ticks);
    if ((speed >= MIN_SPEED) && (speed <= MAX_SPEED)) {
        // only register realistic velocities
        tick_new_value(ticks);
        lcd_new_value();
    }
}

static void measure() {
    cli(); // disable interrupts before interacting with values

    // reset interrupts
    trigger_a = 0;
    trigger_b = 0;

    uint16_t a = time_a, b = time_b;

    sei(); // enable interrupts immediately afterwards

    calculate(a, b);
}

void setup() {
    // we simply turn on the IR LEDs all the time
    pinMode(IR_LED_PIN, OUTPUT);
    digitalWrite(IR_LED_PIN, HIGH);

    // but the UV LEDs will only be pulsed on firing!
    pinMode(UV_LED_PIN, OUTPUT);
    digitalWrite(UV_LED_PIN, LOW);

    lcd_init();
    delay(SCREEN_TIMEOUT); // show splash screen

    timer_init();
    interrupt_init();
}

void loop() {
    if (trigger_b) {
        if (trigger_a) {
            // we got an event on both inputs
            measure();
        } else {
            // we got a false second trigger!
            // clear so next calculation will be correct
            trigger_b = 0;
        }
    }

    lcd_loop();
}
