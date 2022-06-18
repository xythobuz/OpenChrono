/*
 * config.h
 *
 * OpenChrono BB speed measurement device.
 *
 * Copyright (c) 2022 Thomas Buck <thomas@xythobuz.de>
 */

#ifndef __CONFIG_H__
#define __CONFIG_H__

// --------------------------------------

#define VERSION "0.0.1"

// --------------------------------------

// hardware details

#define SENSOR_DISTANCE 70.0 /* in mm */
#define BB_WEIGHT 0.25 /* in g */

// --------------------------------------

// which unit to show on history screen

#define METRIC 0
#define IMPERIAL 1
#define JOULES 2

#define PREFERRED_UNITS JOULES

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

// --------------------------------------

// lcd config

#define LCD_TYPE U8G2_SSD1306_128X64_NONAME_F_HW_I2C

#define HEADING_FONT u8g2_font_VCR_OSD_tr
#define TEXT_FONT u8g2_font_NokiaLargeBold_tr

// --------------------------------------

// history for graph of speeds.
// should not be too big!

#define HISTORY_BUFFER 50

// --------------------------------------

// placeholder data for debugging purposes

#define DEBUG_TICK_COUNT 0
#define DEBUG_TICK_DATA {}

//#define DEBUG_TICK_COUNT 8
//#define DEBUG_TICK_DATA { 8000, 10000, 9000, 11000, 8500, 9500, 10000, 7000 }

// --------------------------------------

#endif // __CONFIG_H__
