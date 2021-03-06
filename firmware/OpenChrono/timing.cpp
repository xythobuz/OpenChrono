/*
 * timing.cpp
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
 * Two phototransistors connected to external interrupts 0 and 1.
 * Timer1 (16bit) used to count time between triggers.
 * Timer2 (8bit) used for timing UV LED pulse.
 */

#include <Arduino.h>

#include "timing.h"
#include "config.h"

volatile uint8_t trigger_a = 0, trigger_b = 0;
volatile uint16_t time_a = 0, time_b = 0;

#ifdef DEBUG_LONG_UV_TIME
volatile static uint8_t led_runs = 0;
#endif

void interrupt_init() {
    // trigger both on rising edge
    EICRA = (1 << ISC00) | (1 << ISC01);
    EICRA |= (1 << ISC10) | (1 << ISC11);

    // enable interrupts
    EIMSK = (1 << INT0) | (1 << INT1);
}

/*
 * this is supposed to be the "input" sensor,
 * the one that triggers first on firing.
 */
ISR(INT0_vect) {
    time_a = timer_get();
    trigger_a = 1;
}

/*
 * this is supposed to be the "output" sensor,
 * the one that triggers after the other sensor.
 */
ISR(INT1_vect) {
    time_b = timer_get();
    trigger_b = 1;

    // we now need to turn on the UV led
    // and make sure it will only be on shortly!
    timer_start();
    digitalWrite(UV_LED_PIN, HIGH);
}

// --------------------------------------

static void timer1_init() {
    // normal mode
    TCCR1A = 0;

    // prescaler
#if TIMER_PRESCALER == 1
    TCCR1B = (1 << CS10);
#elif TIMER_PRESCALER == 8
    TCCR1B = (1 << CS11);
#elif TIMER_PRESCALER == 64
    TCCR1B = (1 << CS11) | (1 << CS10);
#elif TIMER_PRESCALER == 256
    TCCR1B = (1 << CS12);
#elif TIMER_PRESCALER == 1024
    TCCR1B = (1 << CS12) | (1 << CS10);
#else
#error Invalid Prescaler for Timer1
#endif
}

static void timer2_init() {
    // normal mode, no clock source
    TCCR2A = 0;
    TCCR2B = 0;

    // enable overflow interrupt
    TIMSK2 = (1 << TOIE2);
}

void timer_init() {
    timer1_init();
    timer2_init();
}

uint16_t timer_get() {
    return TCNT1;
}

void timer_start() {
    /*
     * the distance between the second IR sensor
     * and the UV LEDs is 7.5mm.
     * Our bullet will travel with a speed of
     * ~10m/s up to ~300m/s approximately.
     * So it will move the 7.5mm in
     * 750us to 25us respectively.
     * So it makes sense to keep the UV LED
     * on for 1ms.
     *
     * We reach exactly 1ms when counting to 250
     * with a prescaler of 64 at 16MHz.
     *
     * If you __really__ want to increase the brightness
     * of the tracer, reduce the pulse length here.
     * Then you can also reduce the UV LED resistor for
     * higher currents, according to the datasheet of
     * your UV LED.
     * Make sure to keep within 40mA the AVR GPIO can provide.
     * Otherwise you need to add a transistor for switching.
     */
    const static uint8_t pulse_length = 250;

    // initial value we count up from
    TCNT2 = 0xFF - pulse_length;

#ifdef DEBUG_LONG_UV_TIME
    led_runs = 0;
#endif

    // prescaler 64
    TCCR2B = (1 << CS22);
}

ISR(TIMER2_OVF_vect) {
    /*
     * When a BB is only dropped through the device it moves
     * with something like 0.1m/s to 1m/s of velocity.
     * So in this case it only moves the 7.5mm to the UV LEDs
     * in 75ms to 7.5ms respectively.
     * So our 1ms pulse is not illuminating it at all!
     * In this case, we have to increase our pulse time by
     * approx. factor 100.
     */
#ifdef DEBUG_LONG_UV_TIME
    led_runs++;
    if (led_runs < 100) {
        // keep running for another millisecond
        TCNT2 = 0xFF - 250;
        return;
    }
#endif

    // turn off UV LED
    digitalWrite(UV_LED_PIN, LOW);

    // and also stop timer
    TCCR2B = 0;
}
