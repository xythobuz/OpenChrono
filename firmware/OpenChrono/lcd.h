/*
 * lcd.h
 *
 * OpenChrono BB speed measurement device.
 *
 * Copyright (c) 2022 Thomas Buck <thomas@xythobuz.de>
 *
 * SSD1306 OLED display connected via I2C.
 */

#ifndef __LCD_H__
#define __LCD_H__

void lcd_init(void);
void lcd_new_value(void);
void lcd_draw(uint8_t screen);
void lcd_loop(void);

#endif // __LCD_H__
