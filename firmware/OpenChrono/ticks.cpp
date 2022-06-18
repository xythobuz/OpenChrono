/*
 * ticks.cpp
 *
 * OpenChrono BB speed measurement device.
 *
 * Copyright (c) 2022 Thomas Buck <thomas@xythobuz.de>
 *
 * Some notes about time calculations:
 * We have Timer1 running with 16MHz
 * which gives us a tick period of 62.5ns.
 *
 * The distance of the sensors is given in mm
 * in SENSOR_DISTANCE (eg. 70mm).
 *
 * period_in_s = 1 / F_CPU
 * period_in_s = 62.5 / 1000 / 1000 / 1000;
 * dist_in_m = SENSOR_DISTANCE * 0.1 * 0.01
 * travel_time_in_s = ticks * period_in_s;
 * speed = dist_in_m / travel_time_in_s;
 *
 * period_in_s = 0.0000000625
 * dist_in_m = 0.07m
 * ticks = 2000
 * travel_time_in_s = 0.000125
 * speed = 560 m/s
 *
 * speed = (SENSOR_DISTANCE / 1000) / (ticks * 62.5 / 1000 / 1000 / 1000)
 * speed = SENSOR_DISTANCE / (ticks * 62.5 / 1000 / 1000)
 * speed = SENSOR_DISTANCE / (ticks * 1000 / F_CPU)
 *
 * Because we can at max measure 0xFFFF ticks
 * this gives us a slowest speed we can measure.
 * 0xFFFF = 65535 ticks
 * speed = SENSOR_DISTANCE / (65535 * 1000 / F_CPU)
 * so we can measure from 17m/s (61km/h, approx. 0.03J @ 0.2g)
 * up to ridulous 1120000m/s (4032000km/h)
 */

#include <Arduino.h>

#include "ticks.h"
#include "config.h"

uint16_t tick_history[HISTORY_BUFFER] = DEBUG_TICK_DATA;
uint8_t tick_count = DEBUG_TICK_COUNT;

void tick_new_value(uint16_t ticks) {
    // store new value in history buffer
    if (tick_count < HISTORY_BUFFER) {
        tick_history[tick_count] = ticks;
        tick_count++;
    } else {
        for (uint8_t i = 0; i < HISTORY_BUFFER - 1; i++) {
            tick_history[i] = tick_history[i + 1];
        }
        tick_history[HISTORY_BUFFER - 1] = ticks;
    }
}

uint16_t tick_average() {
    if (tick_count == 0) {
        return 0;
    }

    uint64_t sum = 0;
    for (uint8_t i = 0; i < tick_count; i++) {
        sum += tick_history[i];
    }
    sum /= (uint64_t)tick_count;
    return (uint16_t)sum;
}

uint16_t tick_max() {
    if (tick_count == 0) {
        return 0;
    }

    uint16_t cmp = 0;
    for (uint8_t i = 0; i < tick_count; i++) {
        if (tick_history[i] > cmp) {
            cmp = tick_history[i];
        }
    }
    return cmp;
}

uint16_t tick_min() {
    if (tick_count == 0) {
        return 0;
    }

    uint16_t cmp = 0xFFFF;
    for (uint8_t i = 0; i < tick_count; i++) {
        if (tick_history[i] < cmp) {
            cmp = tick_history[i];
        }
    }
    return cmp;
}

double tick_to_metric(uint16_t ticks) {
    // v = d / t
    double period = 1000.0 / ((double)(F_CPU));
    double time = period * (double)ticks;
    double speed = (double)SENSOR_DISTANCE / time;
    return speed;
}

double metric_to_imperial(double speed) {
    // convert m/s to f/s
    speed *= 3.28084;
    return speed;
}

double metric_to_joules(double speed, double mass) {
    // e = 0.5 * m * v^2
    double energy = 0.5 * mass * speed * speed / 1000.0;
    return energy;
}
