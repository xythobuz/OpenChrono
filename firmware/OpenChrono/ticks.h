/*
 * ticks.h
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
