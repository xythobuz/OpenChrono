/*
 * timing.h
 *
 * OpenChrono BB speed measurement device.
 *
 * Copyright (c) 2022 Thomas Buck <thomas@xythobuz.de>
 *
 * Two phototransistors connected to external interrupts 0 and 1.
 */

#ifndef __TIMING_H__
#define __TIMING_H__

extern volatile uint8_t trigger_a, trigger_b;
extern volatile uint16_t time_a, time_b;

void interrupt_init();

void timer_init();
uint16_t timer_get();

#endif // __TIMING_H__
