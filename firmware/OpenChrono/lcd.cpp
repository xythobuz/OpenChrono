/*
 * lcd.cpp
 *
 * OpenChrono BB speed measurement device.
 *
 * Copyright (c) 2022 Thomas Buck <thomas@xythobuz.de>
 *
 * SSD1306 OLED display connected via I2C.
 */

#include <Arduino.h>

#include "ticks.h"
#include "adc.h"
#include "lcd.h"
#include "config.h"

#include <Wire.h>
#include <U8g2lib.h>

static uint8_t screens[] = SCREEN_ROTATION;
static uint8_t lcd_screen = 0;
static uint64_t lcd_rotate_time = 0;

static LCD_TYPE u8g2(U8G2_R0, U8X8_PIN_NONE);

void lcd_init(void) {
    u8g2.begin();
    u8g2.setFontPosBottom();

    u8g2.clearBuffer();
    u8g2.setFlipMode(FLIP_SCREEN);

    String s = F("OpenChrono");
    u8g2.setFont(HEADING_FONT);
    uint8_t heading_height = u8g2.getMaxCharHeight();
    u8g2.drawStr(
        0,
        heading_height,
        s.c_str()
    );

    s = F("Version ");
    s += F(VERSION);
    u8g2.setFont(TEXT_FONT);
    u8g2.drawStr(
        (u8g2.getDisplayWidth() - u8g2.getStrWidth(s.c_str())) / 2,
        heading_height + u8g2.getMaxCharHeight() + 4,
        s.c_str()
    );

    s = String((double)SENSOR_DISTANCE, 0);
    s += F("mm");
    u8g2.setFont(TEXT_FONT);
    u8g2.drawStr(
        0,
        u8g2.getDisplayHeight() - u8g2.getMaxCharHeight() - 2,
        s.c_str()
    );

    s = String((double)readVcc() / 1000.0, 1);
    s += F("V");
    u8g2.setFont(TEXT_FONT);
    u8g2.drawStr(
        (u8g2.getDisplayWidth() - u8g2.getStrWidth(s.c_str())) / 2,
        u8g2.getDisplayHeight() - u8g2.getMaxCharHeight() - 2,
        s.c_str()
    );

    s = String((double)BB_WEIGHT, 2);
    s += F("g");
    u8g2.setFont(TEXT_FONT);
    u8g2.drawStr(
        u8g2.getDisplayWidth() - u8g2.getStrWidth(s.c_str()),
        u8g2.getDisplayHeight() - u8g2.getMaxCharHeight() - 2,
        s.c_str()
    );

    s = F("by xythobuz.de");
    u8g2.setFont(TEXT_FONT);
    u8g2.drawStr(
        (u8g2.getDisplayWidth() - u8g2.getStrWidth(s.c_str())) / 2,
        u8g2.getDisplayHeight() - 1,
        s.c_str()
    );

    u8g2.sendBuffer();
}

void lcd_new_value(void) {
    lcd_rotate_time = millis();
    lcd_screen = 0;
    lcd_draw(screens[lcd_screen]);
}

void lcd_draw(uint8_t screen) {
    // fall back to first screen when no more data available
    if (tick_count <= 1) {
        screen = SCREEN_CURRENT;
    }

    if ((screen == SCREEN_CURRENT) || (screen == SCREEN_AVERAGE)
            || (screen == SCREEN_MIN) || (screen == SCREEN_MAX)) {
        if (tick_count < 1) {
            u8g2.clearBuffer();
            u8g2.setFlipMode(FLIP_SCREEN);

            String s = F("Ready!");
            u8g2.setFont(HEADING_FONT);
            u8g2.drawStr(
                (u8g2.getDisplayWidth() - u8g2.getStrWidth(s.c_str())) / 2,
                (u8g2.getDisplayHeight() + u8g2.getMaxCharHeight()) / 2,
                s.c_str()
            );

            u8g2.sendBuffer();
            return;
        }

        uint16_t tick = 0;

        if (screen == SCREEN_CURRENT) {
            // only show most recent value
            tick = tick_history[tick_count - 1];
        } else if (screen == SCREEN_AVERAGE) {
            tick = tick_average();
        } else if (screen == SCREEN_MAX) {
            tick = tick_min();
        } else if (screen == SCREEN_MIN) {
            tick = tick_max();
        }

        double metric = tick_to_metric(tick);
        double imperial = metric_to_imperial(metric);

        double weights[] = BB_WEIGHTS;
        double joules[sizeof(weights) / sizeof(weights[0])];

        for (uint8_t i = 0; i < (sizeof(weights) / sizeof(weights[0])); i++) {
            joules[i] = metric_to_joules(metric, weights[i]);
        }

        u8g2.clearBuffer();
        u8g2.setFlipMode(FLIP_SCREEN);
        u8g2.setFont(TEXT_FONT);

        String s;

        if (screen == SCREEN_CURRENT) {
            s = F("Last Shot (No. ");
        } else if (screen == SCREEN_AVERAGE) {
            s = F("Average (of ");
        } else if (screen == SCREEN_MAX) {
            s = F("Maximum (of ");
        } else if (screen == SCREEN_MIN) {
            s = F("Minimum (of ");
        }
        s += String(tick_count);
        s += F(")");

        u8g2.drawStr(
            (u8g2.getDisplayWidth() - u8g2.getStrWidth(s.c_str())) / 2,
            u8g2.getMaxCharHeight(),
            s.c_str()
        );

        uint8_t left_off = (u8g2.getDisplayHeight() - (u8g2.getMaxCharHeight() * 4 + 3)) / 2;

        if (metric < 10.0) {
            s = String(metric, 1);
        } else {
            s = String(metric, 0);
        }
        s += F(" m/s");
        uint8_t l1 = u8g2.getStrWidth(s.c_str());
        u8g2.drawStr(
            0,
            u8g2.getMaxCharHeight() * 2 + 1 + left_off,
            s.c_str()
        );

        if (imperial < 10.0) {
            s = String(imperial, 1);
        } else {
            s = String(imperial, 0);
        }
        s += F(" FPS");
        uint8_t l2 = u8g2.getStrWidth(s.c_str());
        u8g2.drawStr(
            0,
            u8g2.getMaxCharHeight() * 3 + 2 + left_off,
            s.c_str()
        );

        uint8_t l3 = 0;
        for (uint8_t i = 0; i < (sizeof(weights) / sizeof(weights[0])); i++) {
            if (weights[i] == BB_WEIGHT) {
                s = String(joules[i], 2);
                s += F(" J");
                l3 = u8g2.getStrWidth(s.c_str());
                u8g2.drawStr(
                    0,
                    u8g2.getMaxCharHeight() * 4 + 3 + left_off,
                    s.c_str()
                );
                break;
            }
        }

        uint8_t l4 = 0;
        uint8_t h = u8g2.getMaxCharHeight() + 1;
        for (uint8_t i = 0; i < (sizeof(weights) / sizeof(weights[0])); i++) {
            if (weights[i] == BB_WEIGHT) {
                //u8g2.setFont(TEXT_FONT);
                continue;
            } else {
                u8g2.setFont(SMALL_FONT);
            }

            s = String(weights[i], 2);
            s += F("g ");
            s += String(joules[i], 2);
            s += F("J");

            uint8_t l = u8g2.getStrWidth(s.c_str());
            if (l > l4) {
                l4 = l;
            }

            h += u8g2.getMaxCharHeight() + 1;

            u8g2.drawStr(
                u8g2.getDisplayWidth() - l,
                h,
                s.c_str()
            );
        }

        uint8_t l_left = max(max(l1, l2), l3);
        uint8_t l_right = u8g2.getDisplayWidth() - l4;
        uint8_t lmax = (uint8_t)((((uint16_t)l_left) + ((uint16_t)l_right)) / 2);

        u8g2.setFont(TEXT_FONT);
        u8g2.drawLine(
            lmax, u8g2.getMaxCharHeight() + 2,
            lmax, u8g2.getDisplayHeight()
        );

        u8g2.sendBuffer();
    } else if (screen == SCREEN_HISTORY) {
        uint16_t min = tick_max();
        uint16_t max = tick_min();
        String s;

        u8g2.clearBuffer();
        u8g2.setFlipMode(FLIP_SCREEN);
        u8g2.setFont(TEXT_FONT);

        // max text
        double max_metric = tick_to_metric(max);
        if (PREFERRED_UNITS == METRIC) {
            if (max_metric < 10.0) {
                s = String(max_metric, 1);
            } else {
                s = String(max_metric, 0);
            }
        } else if (PREFERRED_UNITS == IMPERIAL) {
            double max_imperial = metric_to_imperial(max_metric);
            if (max_imperial < 10.0) {
                s = String(max_imperial, 1);
            } else {
                s = String(max_imperial, 0);
            }
        } else {
            s = String(metric_to_joules(max_metric, BB_WEIGHT), 2);
        }
        uint8_t l1 = u8g2.getStrWidth(s.c_str());
        u8g2.drawStr(
            0,
            u8g2.getMaxCharHeight(),
            s.c_str()
        );

        // unit indicator
        uint8_t l2;
        if (PREFERRED_UNITS == METRIC) {
            s = F("m/s");
            l2 = u8g2.getStrWidth(s.c_str());
            u8g2.drawStr(
                0,
                (u8g2.getDisplayHeight() + u8g2.getMaxCharHeight()) / 2,
                s.c_str()
            );
        } else if (PREFERRED_UNITS == IMPERIAL) {
            s = F("FPS");
            l2 = u8g2.getStrWidth(s.c_str());
            u8g2.drawStr(
                0,
                (u8g2.getDisplayHeight() + u8g2.getMaxCharHeight()) / 2,
                s.c_str()
            );
        } else {
            s = F("J");
            l2 = u8g2.getStrWidth(s.c_str());
            u8g2.drawStr(
                0,
                (u8g2.getDisplayHeight() + u8g2.getMaxCharHeight()) / 2,
                s.c_str()
            );
        }

        // min text
        double min_metric = tick_to_metric(min);
        if (PREFERRED_UNITS == METRIC) {
            if (min_metric < 10.0) {
                s = String(min_metric, 1);
            } else {
                s = String(min_metric, 0);
            }
        } else if (PREFERRED_UNITS == IMPERIAL) {
            double min_imperial = metric_to_imperial(min_metric);
            if (min_imperial < 10.0) {
                s = String(min_imperial, 1);
            } else {
                s = String(min_imperial, 0);
            }
        } else {
            s = String(metric_to_joules(min_metric, BB_WEIGHT), 2);
        }
        uint8_t l3 = u8g2.getStrWidth(s.c_str());
        u8g2.drawStr(
            0,
            u8g2.getDisplayHeight() - 1,
            s.c_str()
        );

        uint8_t lmax = max(max(l1, l2), l3);
        uint8_t graph_start = lmax + 1;

        // graph lines
        uint8_t segment_w = (u8g2.getDisplayWidth() - graph_start) / (tick_count - 1);
        for (int i = 0; i < tick_count - 1; i++) {
            u8g2.drawLine(
                graph_start + (i * segment_w),
                map(tick_history[i], min, max, u8g2.getDisplayHeight() - 1, 0),
                graph_start + ((i + 1) * segment_w),
                map(tick_history[i + 1], min, max, u8g2.getDisplayHeight() - 1, 0)
            );
        }

        u8g2.sendBuffer();
    }
}

void lcd_loop(void) {
    if ((millis() - lcd_rotate_time) > SCREEN_TIMEOUT) {
        lcd_rotate_time = millis();
        lcd_screen++;
        if (lcd_screen >= (sizeof(screens) / sizeof(screens[0]))) {
            lcd_screen = 0;
        }

        lcd_draw(screens[lcd_screen]);
    }
}
