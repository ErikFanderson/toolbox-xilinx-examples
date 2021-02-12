#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Author: Erik Anderson
# Email: erik.francis.anderson@gmail.com
# Date: 02/11/2021
"""Docstring for module send_blink_commands"""

# Imports - standard library

# Imports - 3rd party packages
import serial
import time

# Imports - local source

if __name__ == '__main__':
    # Open serial port
    ser = serial.Serial()
    ser.port = '/dev/ttyUSB0'
    ser.baudrate = 9600
    ser.timeout = 1
    ser.bytesize = 8
    ser.parity = serial.PARITY_NONE
    ser.rtscts = True 
    ser.open()

    # Send a new configuration every so often...
    for i in range(8):
        print(f"Writing byte: {i}")
        ser.write(bytes([1 << i]))
        time.sleep(2)

    ser.close()
