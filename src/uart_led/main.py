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

class UARTDriver():
    
    def __init__(self, port, baudrate):
        self.ser = serial.Serial()
        self.ser.port = port 
        self.ser.baudrate = baudrate 
        self.ser.timeout = 1 # Read timeout
        self.ser.write_timeout = 1
        self.ser.bytesize = 8
        self.ser.parity = serial.PARITY_NONE
        self.ser.rtscts = True

    def open(self):
        self.ser.open()
    
    def close(self):
        self.ser.reset_input_buffer()
        self.ser.reset_output_buffer()
        self.ser.close()

    def write_byte(self, address: int, byte: int):
        self.ser.write(address)
        #time.sleep(1)
        self.ser.write(byte)
    
    def read_byte(self, address: int) -> int:
        self.ser.write(128 + address)
        #time.sleep(1)
        return self.ser.read()

if __name__ == '__main__':
    drv = UARTDriver("/dev/ttyUSB2", 9600)
    drv.open()
    
    # Write something
    drv.ser.write(bytes([0]))
    print("Address byte written")
    #time.sleep(2)
    drv.ser.write(bytes([0x55]))
    print("Data byte written")
    #drv.write_byte(0, 0x55)
    
    drv.close()
