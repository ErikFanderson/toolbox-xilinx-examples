#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Author: Erik Anderson
# Email: erik.francis.anderson@gmail.com
# Date: 04/27/2021
"""Docstring for module main"""

# Imports - standard library
import time

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
 
    ## LED test to make sure that the UART is functioning
    #for i in range(5):
    #    drv.write_register("LED", "leds", "01010101")
    #    print(drv.read_register("LED", "leds"))
    #    time.sleep(1)
    #    drv.write_register("LED", "leds", "10101010")
    #    print(drv.read_register("LED", "leds"))
    #    time.sleep(1)
   
    # Try and read something from I2C
    print("Reset i2c controller")
    drv.write_register("RESET", "reset", "1")
    time.sleep(0.25)
    drv.write_register("RESET", "reset", "0")
    time.sleep(0.25)

    # Initiate I2C read
    drv.write_register("I2C", "rv0_valid", "0")
    print("Initiate I2C read")
    drv.write_register("I2C", "rv0_slave_address", "1110100") # Address: 0x74
    drv.write_register("I2C", "rv0_reg_address", "00000010")
    drv.write_register("I2C", "rv0_burst_count", "00")
    drv.write_register("I2C", "rv0_rd_wrn", "1")
    drv.write_register("I2C", "rv0_valid", "1")
    time.sleep(0.25)
    print(drv.read_register("I2C", "rv1_rdata0"))

    drv.close()
