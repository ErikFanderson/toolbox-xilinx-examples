#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Author: Erik Anderson
# Email: erik.francis.anderson@gmail.com
# Date: 04/27/2021
"""This is an I2C software driver that assumes a UARTDriver with specific I2C fields"""

# Imports - standard library
import time
from abc import ABC, abstractmethod
from typing import List
from time import sleep 

# Imports - 3rd party packages

# Imports - local source
from UARTDriver import *

class Si570_VC707_UART(Si570_VC707):
    
    def __init__(self, xtal_frequency, drv_uart):
        super(Si570_VC707_UART, self).__init__(xtal_frequency)
        self._drv = drv_uart

    def toggle_rv0_valid_pulse(self):
        valid_pulse = self._drv.read_register("I2C", "rv0_valid_pulse")
        if valid_pulse == "1":
            self._drv.write_register("I2C", "rv0_valid_pulse", "0")
        else:
            self._drv.write_register("I2C", "rv0_valid_pulse", "1")

    def i2c_write(self, addr: int, data: List[int]):
        """Single or multiple byte write"""
        if type(data) is int: 
            data = [data]
        burst = len(data) - 1
        self._drv.write_register("I2C", "rv0_slave_address", f"{addr:07b}")
        for i, dat in enumerate(data):
            self._drv.write_register("I2C", f"rv0_wdata{i}", f"{data[i]:08b}")
        self._drv.write_register("I2C", "rv0_burst_count_wr", f"{burst:02b}")
        self._drv.write_register("I2C", "rv0_burst_count_rd", "00")
        self._drv.write_register("I2C", "rv0_rd_wrn", "0")
        self._drv.write_register("I2C", "rv1_ready", "1")
        self.toggle_rv0_valid_pulse()
        # Wait for controller to finish 
        while (self._drv.read_register("I2C", "rv0_ready") != "1"):
            print("Waiting for I2C controller to be ready...")
            sleep(0.1)
        # Check if nack received
        nack = self._drv.read_register("I2C", "rv1_nack")
        if (nack == "1"):
            print(f"NACK received for I2C Write (Addr: {addr}, Data {data})")

    def i2c_read(self, addr: int, reg: int):
        """Single byte read"""
        self._drv.write_register("I2C", "rv0_slave_address", f"{addr:07b}")
        self._drv.write_register("I2C", "rv0_wdata0", f"{reg:08b}")
        self._drv.write_register("I2C", "rv0_burst_count_wr", "00")
        self._drv.write_register("I2C", "rv0_burst_count_rd", "00")
        self._drv.write_register("I2C", "rv0_rd_wrn", "1")
        self._drv.write_register("I2C", "rv1_ready", "1")
        self.toggle_rv0_valid_pulse()
        # Wait for controller to finish 
        while (self._drv.read_register("I2C", "rv0_ready") != "1"):
            print("Waiting for I2C controller to be ready...")
            sleep(0.1)
        nack = self._drv.read_register("I2C", "rv1_nack")
        # Check if nack received
        if (nack == "1"):
            print(f"NACK received for I2C Read (Addr: {addr}, Register: {reg})")
        return self._drv.read_register("I2C", "rv1_rdata0")
