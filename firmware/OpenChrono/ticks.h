/*
 * ticks.h
 *
 * OpenChrono BB speed measurement device.
 *
 * Copyright (c) 2022 Thomas Buck <thomas@xythobuz.de>
 */

#ifndef __TICKS_H__
#define __TICKS_H__

extern uint16_t tick_history[];
extern uint8_t tick_count;

void tick_new_value(uint16_t ticks);
uint16_t tick_average();
uint16_t tick_max();
uint16_t tick_min();
double tick_to_metric(uint16_t ticks);
double metric_to_imperial(double speed);
double metric_to_joules(double speed, double mass);

#endif // __TICKS_H__
