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
    
    def __init__(self, **kwargs):
        self.ser = serial.Serial(**kwargs)
        #self.ser.port = port
        #self.ser.baudrate = baudrate
        #self.ser.timeout = 1 # Read timeout
        #self.ser.write_timeout = 1
        #self.ser.bytesize = 8
        #self.ser.parity = serial.PARITY_NONE
        #self.ser.rtscts = True
        #self.ser.stopbits = serial.STOPBITS_ONE

    def open(self):
        self.ser.open()
    
    def close(self):
        self.ser.reset_input_buffer()
        self.ser.reset_output_buffer()
        self.ser.close()

    def write_byte(self, address: int, data: int):
        #address = address.to_bytes(1, "big")
        #data = data.to_bytes(1, "big")
        #print([address, data])
        #self.ser.write([address, data])
        print(bytes([address, data]))
        num_bytes = self.ser.write(bytes([address, data]))
        print(f"Num bytes written: {num_bytes}")
    
    def read_byte(self, address: int) -> int:
        self.ser.write((address + 128).to_bytes(1, "big"))
        time.sleep(1)
        return int.from_bytes(self.ser.read(), "big")

if __name__ == '__main__':
    drv = UARTDriver(
        port="/dev/ttyUSB2",
        baudrate=9600,
        timeout=1,
        write_timeout=1,
        bytesize=serial.EIGHTBITS,
        rtscts=True,
        parity=serial.PARITY_NONE,
        stopbits=serial.STOPBITS_ONE)
    
    for i in range(100):
        num_bytes = drv.ser.write(bytes([0x55]))
        read_data = int.from_bytes(drv.ser.read(), "big")
        print(f"Write data: 0x55")
        print(f"Read data: {hex(read_data)}\n")
        #time.sleep(0.5)
        time.sleep(2)

    #for i in range(40, 100):    
    #    num_bytes = drv.ser.write(bytes([i]))
    #    read_data = int.from_bytes(drv.ser.read(), "big")
    #    print(f"Write data: {i}")
    #    print(f"Read data: {read_data}\n")
    #    #time.sleep(0.5)
    #    time.sleep(2)
    
    drv.close()
