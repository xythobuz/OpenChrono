/*
 * config.h
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

#ifndef __CONFIG_H__
#define __CONFIG_H__

// --------------------------------------

#define VERSION "0.0.1"

// --------------------------------------

#define SENSOR_DISTANCE 70.0 /* in mm */

#define BB_WEIGHT 0.25 /* in g */
#define BB_WEIGHTS { 0.20, 0.23, 0.25, 0.28, 0.475 } /* in g */

// --------------------------------------

// which unit to show on history screen

#define METRIC 0
#define IMPERIAL 1
#define JOULES 2

#define PREFERRED_UNITS METRIC

// --------------------------------------

// order and duration of screens

#define SCREEN_CURRENT 0
#define SCREEN_MIN 1
#define SCREEN_AVERAGE 2
#define SCREEN_MAX 3
#define SCREEN_HISTORY 4

#define SCREEN_ROTATION { \
    SCREEN_CURRENT,       \
    SCREEN_CURRENT,       \
    SCREEN_MIN,           \
    SCREEN_AVERAGE,       \
    SCREEN_MAX,           \
    SCREEN_HISTORY,       \
    SCREEN_HISTORY        \
}

#define SCREEN_TIMEOUT 2500 /* in ms */
#define FLIP_SCREEN 0

// --------------------------------------

// lcd config

#define LCD_TYPE U8G2_SSD1306_128X64_NONAME_F_HW_I2C

#define HEADING_FONT u8g2_font_VCR_OSD_tr
#define TEXT_FONT u8g2_font_NokiaLargeBold_tr
#define SMALL_FONT u8g2_font_helvB08_tr

// --------------------------------------

// history for graph of speeds.
// should not be too big!

#define HISTORY_BUFFER 50

// --------------------------------------

#define IR_LED_PIN 4
#define UV_LED_PIN 5

// --------------------------------------

// with a prescaler of 1, we can measure from 17m/s to 1120000m/s
// with a prescaler of 8, we can measure from 2.14m/s to 140000m/s
// with a prescaler of 64, we can measure from 0.27m/s to 17500m/s
// see comment in ticks.cpp

// allowed values: 1, 8, 64, 256, 1024
#define TIMER_PRESCALER 64

// values outside this range will be ignored
#define MIN_SPEED 0.3 /* in m/s */
#define MAX_SPEED 2000.0 /* in m/s */

// enable to keep UV LED on 100x as long
//#define DEBUG_LONG_UV_TIME

// --------------------------------------

// placeholder data for debugging purposes

#define DEBUG_TICK_COUNT 0
#define DEBUG_TICK_DATA {}

//#define DEBUG_TICK_COUNT 8
//#define DEBUG_TICK_DATA { 8000, 10000, 9000, 11000, 8500, 9500, 10000, 7000 }

// --------------------------------------

#endif // __CONFIG_H__
