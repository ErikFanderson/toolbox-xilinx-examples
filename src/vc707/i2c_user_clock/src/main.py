#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Author: Erik Anderson
# Email: erik.francis.anderson@gmail.com
# Date: 04/27/2021
"""Docstring for module main"""

# Imports - standard library

# Imports - 3rd party packages

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
 
    for i in range(50):
        drv.write_register("LED", "leds", "01010101")
        print(drv.read_register("LED", "leds"))
        time.sleep(1)
        drv.write_register("LED", "leds", "10101010")
        print(drv.read_register("LED", "leds"))
        time.sleep(1)
    
    drv.close()
