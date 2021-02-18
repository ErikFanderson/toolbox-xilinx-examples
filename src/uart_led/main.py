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
        #print(bytes([address, data]))
        num_bytes = self.ser.write(bytes([address, data]))
        #print(f"Num bytes written: {num_bytes}")
    
    def read_byte(self, address: int) -> int:
        self.ser.write((address + 128).to_bytes(1, "big"))
        #time.sleep(1)
        return int.from_bytes(self.ser.read(), "big")

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
    
    # Sending single bytes
    #for i in range(50):
    #    print(f"[{i}] Sending 0x55")
    #    drv.ser.write(bytes([0x55]))
    #    time.sleep(2)
    #    print(f"[{i}] Sending 0xaa")
    #    drv.ser.write(bytes([0xaa]))
    #    time.sleep(2)
    #    #time.sleep(2)
    #    #drv.write_byte(0, 0x55)
    #    #print(drv.read_byte(0))
    
    #drv.ser.write(bytes([0x0]))
    #drv.ser.write(bytes([0x55]))
    
    #for i in range(50):
    #    drv.ser.write(bytes([i]))
    #    time.sleep(2)
    
    #print(drv.write_byte(0, 0x55))
    #time.sleep(1)
    #drv.write_byte(0, 0xaa)

    #drv.ser.write(bytes([128]))
    #print(int(drv.ser.read()))
    #drv.open()
    #drv.write_byte(0, 0)
    #time.sleep(1)
    #print(hex(99))
    #drv.write_byte(0, 99)
    for i in range(100):
        print(f"LED write: {i}")
        drv.write_byte(0, i)
        print(f"LED read: {drv.read_byte(0)}")
        time.sleep(1)
    
    ## Write something
    #drv.ser.write(bytes([0]))
    #print("Address byte written")
    #drv.ser.write(bytes([0x55]))
    #print("Data byte written")
    #drv.write_byte(0, 0x55)
    
    drv.close()
