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
    hs_div_dict =  {"000": 4, "001": 5, "010": 6, "011": 7, "101": 9, "111": 11}

    def __init__(self):
        pass

    @abstractmethod
    def i2c_write(self, reg: int, data: int):
        pass
    
    @abstractmethod
    def i2c_read(self, reg: int):
        pass
    
    #--------------------------------------------------------------------------
    # Read register methods 
    #--------------------------------------------------------------------------
   
    def get_div_registers(self):
        """Reads and translates the important div/mult registers"""
        rdata = self.i2c_read(7)
        hs_div = rdata[0:3]
        n1 = rdata[3:]
        rdata = self.i2c_read(8)
        n1 = n1 + rdata[0:2]
        rfreq = rdata[2:] 
        rfreq += self.i2c_read(9)
        rfreq += self.i2c_read(10)
        rfreq += self.i2c_read(11)
        rfreq += self.i2c_read(12)
        # Convert and calculate
        hs_div = self.hs_div_dict[hs_div]
        n1 = int(n1, 2) + 1
        rfreq = int(rfreq, 2) / (2**28)
        return (hs_div, n1, rfreq)

    #--------------------------------------------------------------------------
    # Get and calculate frequency methods
    #--------------------------------------------------------------------------

    def get_xtal_frequency(self, output_frequency):
        """Calculates the xtal frequency based off the output frequency"""
        hs_div, n1, rfreq = self.get_div_registers()
        return self.calc_xtal_frequency(output_frequency, hs_div, n1, rfreq) 
    
    def calc_xtal_frequency(self, output_frequency, hs_div, n1, rfreq):
        return (output_frequency * hs_div * n1) / (rfreq)

    def get_output_frequency(self):
        """Gets the current output frequency"""
        hs_div, n1, rfreq = self.get_div_registers()
        return self.calc_output_frequency(hs_div, n1, rfreq) 
    
    def calc_output_frequency(self, hs_div, n1, rfreq):
        return (self.xtal_frequency * rfreq) / (hs_div * n1)
    
    #--------------------------------------------------------------------------
    # Set frequency methods
    #--------------------------------------------------------------------------

    def set_output_frequency_raw(self, hs_div, n1, rfreq):
        """converts to binary numbers/strings and write to registers"""
        # Check for valid inputs
        if hs_div not in self.hs_div_dict.values():
            return None 
        if n1 % 2 == 1 or n1 <= 0:
            return None 
        # Convert to binary strings 
        hs_div_bin = f"{hs_div - 4:03b}"
        n1_bin = f"{n1 - 1:07b}"
        rfreq_bin = f"{int(rfreq * 2**28):038b}"
        # Write to registers
        reg_7 = hs_div_bin + n1_bin[0:5]
        reg_8 = n1_bin[5:] + rfreq_bin[0:6]
        reg_9 = rfreq_bin[6:14]
        reg_10 = rfreq_bin[14:22]
        reg_11 = rfreq_bin[22:30]
        reg_12 = rfreq_bin[30:]
        self.i2c_write(7, int(reg_7, 2))
        self.i2c_write(8, int(reg_8, 2))
        self.i2c_write(9, int(reg_9, 2))
        self.i2c_write(10, int(reg_10, 2))
        self.i2c_write(11, int(reg_11, 2))
        self.i2c_write(12, int(reg_12, 2))
        return True 

class Si570_VC707(Si570):
    """Just uses the i2c commands from uart_to_i2c"""
    def __init__(self, i2c_uart_drv):
        super(Si570_VC707, self).__init__()
        self._drv = i2c_uart_drv
        self.configure_i2c_mux(0)
        self.xtal_frequency = self.get_xtal_frequency(156.25e6)

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
        self._drv.i2c_write(0x5D, [reg, data])
    
    def i2c_read(self, reg: int):
        return self._drv.i2c_read(0x5D, reg)
