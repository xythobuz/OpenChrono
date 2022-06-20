/*
 * timing.cpp
 *
 * OpenChrono BB speed measurement device.
 *
 * Copyright (c) 2022 Thomas Buck <thomas@xythobuz.de>
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
     */
    const static uint8_t pulse_length = 250;

    // initial value we count up from
    TCNT2 = 0xFF - pulse_length;

    // prescaler 64
    TCCR2B = (1 << CS22);
}

ISR(TIMER2_OVF_vect) {
    // turn off UV LED
    digitalWrite(UV_LED_PIN, LOW);

    // and also stop timer
    TCCR2B = 0;
}
