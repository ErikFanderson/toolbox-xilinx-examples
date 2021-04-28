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
 
    # Initialize all values to 0
    drv.write_register("RESET", "reset", "1")
    print(f"Field: Reset, Reg: reset, Read: {drv.read_register('RESET', 'reset')}")
    for field_name, field in drv._fields.items():
        for reg_name, reg in field["registers"].items():
            if field_name != "RESET" or reg_name != "reset":
                if reg["write"]:
                    drv.write_register(field_name, reg_name, "0")
                    rdata = drv.read_register(field_name, reg_name)
                    print(f"Field: {field_name}, Reg: {reg_name}, Written: 0, Read: {rdata}")
                else:
                    rdata = drv.read_register(field_name, reg_name)
                    print(f"Field: {field_name}, Reg: {reg_name}, Read: {rdata}")
    drv.write_register("RESET", "reset", "0")
    print(f"Field: Reset, Reg: reset, Read: {drv.read_register('RESET', 'reset')}")
    print("# FINISH INIT MEMORY #")

    ## LED test to make sure that the UART is functioning
    #for i in range(5):
    #    drv.write_register("LED", "leds", "01010101")
    #    print(drv.read_register("LED", "leds"))
    #    time.sleep(1)
    #    drv.write_register("LED", "leds", "10101010")
    #    print(drv.read_register("LED", "leds"))
    #    time.sleep(1)
   
    ## Try and read something from I2C
    #print("Reset i2c controller")
    #drv.write_register("RESET", "reset", "1")
    #time.sleep(0.25)
    #drv.write_register("RESET", "reset", "0")
    #time.sleep(0.25)

    ## Initiate I2C read
    #drv.write_register("I2C", "rv0_valid", "0")
    #print("Initiate I2C read")
    #drv.write_register("I2C", "rv0_slave_address", "1110100") # Address: 0x74
    #drv.write_register("I2C", "rv0_wdata0", "00000000")
    #drv.write_register("I2C", "rv0_burst_count_wr", "00")
    #drv.write_register("I2C", "rv0_burst_count_rd", "00")
    #drv.write_register("I2C", "rv0_rd_wrn", "1")
    #drv.write_register("I2C", "rv0_valid", "1")
    #time.sleep(0.25)
    #print(drv.read_register("I2C", "rv1_rdata0"))

    drv.close()
