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
    def __init__(self, xtal_frequency):
        """The XTAL frequency should be calculated using default output settings
        This will change from device to device
        self.xtal_frequency = self.get_xtal_frequency(156.25e6)"""
        self.xtal_frequency = xtal_frequency
        self.min_rfreq = 4.85e9 / self.xtal_frequency
        self.max_rfreq = 5.67e9 / self.xtal_frequency

    @abstractmethod
    def i2c_write(self, reg: int, data: int):
        pass
    
    @abstractmethod
    def i2c_read(self, reg: int):
        pass
    
    #--------------------------------------------------------------------------
    # Valid setting methods 
    #--------------------------------------------------------------------------
    
    def is_valid_hs_div(self, hs_div):
        if hs_div in [4, 5, 6, 7, 9, 11]:
            return True
        else:
            return False
    
    def is_valid_n1(self, n1):
        if n1 % 2 == 0 and n1 >= 2 and n1 <= 128:
            return True
        else:
            return False
    
    def is_valid_rfreq(self, rfreq):
        if rfreq > self.min_rfreq and rfreq < self.max_rfreq:
            return True
        else:
            return False

    def is_valid_setting(self, hs_div, n1, rfreq):
        return self.is_valid_hs_div(hs_div) and self.is_valid_n1(n1) and self.is_valid_rfreq(rfreq)
    
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
        hs_div = int(hs_div, 2) + 4
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
    
    def calc_dco_frequency(self, rfreq):
        return (self.xtal_frequency * rfreq)
    
    def calc_rfreq_frequency_limits(self):
        """Calculates the minimum and maximum achievable frequency with only changing rfreq"""
        ofreq = self.get_output_frequency()
        hs_div, n1, rfreq = self.get_div_registers()
        maxf = self.calc_output_frequency(hs_div, n1, self.max_rfreq)
        minf = self.calc_output_frequency(hs_div, n1, self.min_rfreq)
        return (minf, maxf)
   
    def calc_rfreq_for_frequency(self, freq):
        ofreq = self.get_output_frequency()
        hs_div, n1, rfreq = self.get_div_registers()
        return (freq/ofreq) * rfreq 

    #--------------------------------------------------------------------------
    # Set frequency methods
    #--------------------------------------------------------------------------

    def set_output_frequency_raw(self, hs_div, n1, rfreq):
        """converts to binary numbers/strings and write to registers"""
        # Check for valid inputs
        if not self.is_valid_setting(hs_div, n1, rfreq):
            return False 
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
        self.freeze()
        self.i2c_write(7, int(reg_7, 2))
        self.i2c_write(8, int(reg_8, 2))
        self.i2c_write(9, int(reg_9, 2))
        self.i2c_write(10, int(reg_10, 2))
        self.i2c_write(11, int(reg_11, 2))
        self.i2c_write(12, int(reg_12, 2))
        self.unfreeze()
        return True

    def freeze(self):
        self.i2c_write(137, int("00010000", 2))
        
    def unfreeze(self):
        self.i2c_write(137, 0)
        self.i2c_write(135, int("0100000", 2))
    
    #--------------------------------------------------------------------------
    # Misc 
    #--------------------------------------------------------------------------

    def get_string_config(self):
        rstr = ""
        ofreq = self.get_output_frequency()
        hs_div, n1, rfreq = self.get_div_registers()
        rstr += "# BEGIN SI570 CONFIG #\n"
        rstr += f"Output frequency: {ofreq * 1e-6} [MHz]\n"
        rstr += f"DCO frequency: {self.calc_dco_frequency(rfreq) * 1e-9} [GHz]\n"
        rstr += f"hs_div: {hs_div}\n"
        rstr += f"n1: {n1}\n"
        rstr += f"rfreq: {rfreq}\n"
        rstr += "# FINISH SI570 CONFIG #"
        return rstr

class Si570_VC707(Si570):
    """Just uses the i2c commands from uart_to_i2c"""
    def __init__(self, i2c_uart_drv, xtal_frequency):
        super(Si570_VC707, self).__init__(xtal_frequency)
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
        self._drv.i2c_write(0x5D, [reg, data])
    
    def i2c_read(self, reg: int):
        return self._drv.i2c_read(0x5D, reg)
