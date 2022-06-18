# OpenChrono

Chronograph for Airsoft use, released as Free Open Source hardware and software!
Uses a 3D printed housing to hold an Arduino, an OLED, batteries and two photosensitive light barriers.

## Hardware

Take the STL files from the 'hardware' directory or modify the included OpenSCAD design and create your own custom STLs.

Required Materials:

TODO

## Software

This project uses the [U8g2 library by olikraus](https://github.com/olikraus/u8g2) to draw to the I2C OLED display.

You can compile and flash the software using either PlatformIO or the standard Arduino IDE.
In the latter case, install the U8g2 library using the Arduino IDE Library Manager and then flash as usual.
