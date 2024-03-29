#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Author: Erik Anderson
# Email: erik.francis.anderson@gmail.com
# Date: 04/27/2021
"""Docstring for module main"""

# Imports - standard library
import time
from abc import ABC, abstractmethod

# Imports - 3rd party packages

# Imports - local source
from UARTDriver import *
from equipment.si570 import *
from si570_vc707_uart import *

def led_test():
    """LED test to make sure that the UART is functioning"""
    print("# BEGIN LED TEST #")
    for i in range(5):
        drv.write_register("LED", "leds", "01010101")
        print(drv.read_register("LED", "leds"))
        time.sleep(1)
        drv.write_register("LED", "leds", "10101010")
        print(drv.read_register("LED", "leds"))
        time.sleep(1)
    print("# FINISH LED TEST #")

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
 
    # Initialize UART mem to 0
    print("# BEGIN INIT MEMORY #")
    drv.write_register("RESET", "reset", "1")
    drv.write_register("RESET", "i2c_rst_n", "0")
    print(f"Field: Reset, Reg: reset, Read: {drv.read_register('RESET', 'reset')}")
    print(f"Field: Reset, Reg: i2c_rst_n, Read: {drv.read_register('RESET', 'i2c_rst_n')}")
    for field_name, field in drv._fields.items():
        for reg_name, reg in field["registers"].items():
            if field_name != "RESET":
                if reg["write"]:
                    drv.write_register(field_name, reg_name, "0")
                    rdata = drv.read_register(field_name, reg_name)
                    print(f"Field: {field_name}, Reg: {reg_name}, Written: 0, Read: {rdata}")
                else:
                    rdata = drv.read_register(field_name, reg_name)
                    print(f"Field: {field_name}, Reg: {reg_name}, Read: {rdata}")
    drv.write_register("RESET", "reset", "0")
    drv.write_register("RESET", "i2c_rst_n", "1")
    print(f"Field: Reset, Reg: reset, Read: {drv.read_register('RESET', 'reset')}")
    print(f"Field: Reset, Reg: i2c_rst_n, Read: {drv.read_register('RESET', 'i2c_rst_n')}")
    print("# FINISH INIT MEMORY #")

    # UART LED TEST
    #led_test()
    
    # I2C TEST - Si570 Clock
    #print("Si570 I2C Test")
    #for pos in range(8):
    #    print(pos)
    #    drv.i2c_write(0x74, 1 << pos)
    #    print(drv.i2c_read(0x74, 1 << pos))
    #    print(drv.i2c_read(0b1011101, 7))
    
    # I2C TEST - Si5324 Clock
    #print("Si570 I2C Test")
    #print(drv.i2c_read(0x74, 1 << 7))
    #print(drv.i2c_read(0b1101000, 0))
    
    # Create Si570 object
    clock = Si570_VC707_UART(114284672.05569899, drv)
    clock.configure_i2c_mux(0)
    
    # Default (156.25 MHz)
    if clock.set_output_frequency_raw(4, 8, 43.750398982316256):
        print(clock.get_string_config())
    time.sleep(1)
    
    ## (160 MHz)
    #if clock.set_output_frequency_raw(4, 8, 44.80040855789185):
    #    print(clock.get_string_config())
    #time.sleep(1)

    ## Default/2 (156.25/2 MHz)
    #if clock.set_output_frequency_raw(4, 16, 50.750398982316256):
    #    print(clock.get_string_config())
    #time.sleep(1)
    
    ## Default*2 (156.25*2 MHz)
    #if clock.set_output_frequency_raw(4, 4, 43.750398982316256):
    #    print(clock.get_string_config())
  
    #print(clock.calc_rfreq_frequency_limits())
    #print(clock.calc_rfreq_for_frequency(160e6))
    
    drv.close()
