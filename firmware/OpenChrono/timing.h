/*
 * timing.h
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
 */

#ifndef __TIMING_H__
#define __TIMING_H__

extern volatile uint8_t trigger_a, trigger_b;
extern volatile uint16_t time_a, time_b;

void interrupt_init();

void timer_init();
uint16_t timer_get();

void timer_start();

#endif // __TIMING_H__
