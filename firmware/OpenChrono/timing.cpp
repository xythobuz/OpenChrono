/*
 * timing.cpp
 *
 * OpenChrono BB speed measurement device.
 *
 * Copyright (c) 2022 Thomas Buck <thomas@xythobuz.de>
 *
 * Two phototransistors connected to external interrupts 0 and 1.
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

ISR(INT0_vect) {
    time_a = timer_get();
    trigger_a = 1;
}

ISR(INT1_vect) {
    time_b = timer_get();
    trigger_b = 1;
}

// --------------------------------------

void timer_init() {
    // normal mode, prescaler 1
    TCCR1A = 0;
    TCCR1B = (1 << CS10);
}

uint16_t timer_get() {
    return TCNT1;
}
