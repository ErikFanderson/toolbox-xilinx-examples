#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Author: Erik Anderson
# Email: erik.francis.anderson@gmail.com
# Date: 02/11/2021
"""Docstring for module main"""

# Imports - standard library

# Imports - 3rd party packages
import serial
import time

# Imports - local source
from UARTDriver import *

if __name__ == '__main__':
    drv = UARTDriver(
        port="/dev/ttyUSB0",
        baudrate=9600,
        timeout=1,
        write_timeout=1,
        bytesize=serial.EIGHTBITS,
        rtscts=False,
        parity=serial.PARITY_NONE,
        stopbits=serial.STOPBITS_ONE)
  
    print(f'Read leds 0: {drv.read_register("LED", "leds0")}')
    drv.write_register("LED", "leds0", "1")
    drv.write_register("LED", "leds1", "1")
    print(f'Read leds 1: {drv.read_register("LED", "leds1")}')
    print(f'Read all leds: {drv.read_all_bytes("LED", "leds1")}')
    
    for i in range(16):
        drv.write_register("LED", "leds0", f"{i:04b}")
        drv.write_register("LED", "leds1", f"{i:04b}")
        time.sleep(1)

    drv.close()
