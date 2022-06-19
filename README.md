# OpenChrono

Chronograph for Airsoft use, released as Free Open Source hardware and software!
Uses a 3D printed housing to hold an Arduino, an OLED, batteries and two photosensitive light barriers.

## Hardware

Take the STL files from the 'hardware' directory or modify the included OpenSCAD design and create your own custom STLs.

### Required Parts

| Description        | Type          | Count  |
| ------------------ | ------------- | ------ |
| Arduino Nano       |               | 1x     |
| LCD 128x64 I2C     | SSD1306 0.96" | 1x     |
| Slide Switch       |               | 1x     |
| IR Phototransistor | SFH 309 FA-5  | 2x     |
| IR LED 3mm         |               | 2x     |
| Resistor           | **TODO**      | 2x     |
| Resistor           | **TODO**      | 1x     |
| Screw              | M2 10mm       | 4x     |
| Screw              | M2.5 10mm     | 2x     |
| Screw              | M3 10mm       | 4x     |
| Heatmelt Insert    | M3 8mm        | 4x     |
| AAA Battery        |               | 3x     |
| Bat. Terminal Neg. |               | 3x     |
| Bat. Terminal Pos. |               | 3x     |

## Software

This project uses the [U8g2 library by olikraus](https://github.com/olikraus/u8g2) to draw to the I2C OLED display.

You can compile and flash the software using either PlatformIO or the standard Arduino IDE.
In the latter case, install the U8g2 library using the Arduino IDE Library Manager and then flash as usual.
