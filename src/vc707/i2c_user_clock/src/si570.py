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
from uart_to_i2c import *

class Si570(ABC):
    def __init__(self):
        pass

    @abstractmethod
    def i2c_write(self, reg: int, data: int):
        pass
    
    @abstractmethod
    def i2c_read(self, reg: int):
        pass

    @staticmethod
    def calculate_output_frequency():
        """Just returns the output frequency"""
        print("yello")

class Si570_VC707(Si570):
    """Just uses the i2c commands from uart_to_i2c"""

    def __init__(self, i2c_uart_drv):
        self._drv = i2c_uart_drv
        self.configure_i2c_mux(0)

    def configure_i2c_mux(self, position):
        """
        Position 0 => USER_CLK_SDL/SCL (Si570 Clock)
        Position 1 => FMC1_HPC_IIC_SDA/SCL
        Position 2 => FMC2_HPC_IIC_SDA/SCL
        Position 3 => EEPROM_IIC_SDA/SCL (M24C08 EEPROM) 
        Position 4 => SDP_IIC_SDA/SCL (SFP Module) 
        Position 5 => IIC_SDA/SCL_HDMI (ADV7512 HDMI) 
        Position 6 => IIC_SDA/SCL_DDR3 (DDR3 SODIMM) 
        Position 7 => Si5324_SDA/SCL (Si5324 Clock) 
        """
        return self._drv.i2c_read(0x74, 1 << position)

    def i2c_write(self, reg: int, data: int):
        self._drv.i2c_write(0x5D, data)
    
    def i2c_read(self, reg: int):
        return self._drv.i2c_read(0x5D, reg)
