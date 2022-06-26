/*
 * lcd.h
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
 * SSD1306 OLED display connected via I2C.
 */

#ifndef __LCD_H__
#define __LCD_H__

void lcd_init(void);
void lcd_new_value(void);
void lcd_draw(uint8_t screen);
void lcd_loop(void);

#endif // __LCD_H__
