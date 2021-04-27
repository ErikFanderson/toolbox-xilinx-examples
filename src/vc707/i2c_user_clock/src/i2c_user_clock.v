//==============================================================================
// Author: Erik Anderson
// Description: <> 
// Naming conventions:
//    signals => snake_case
//    Parameters (aliasing signal values) => SNAKE_CASE with all caps
//    Parameters (not aliasing signal values) => CamelCase 
//==============================================================================

`timescale 1ns/1ps
`default_nettype none

module i2c_user_clock (
    i_sys_clk_p, 
    i_sys_clk_n,
    
    i_user_clk_p, 
    i_user_clk_n,
    
    o_uart_tx,
    i_uart_rx,
    o_uart_rts_n,
    i_uart_cts_n,
    
    o_leds,
    
    o_user_clk
);

// I/O
input wire i_sys_clk_p;
input wire i_sys_clk_n;

input wire i_user_clk_p;
input wire i_user_clk_n;

output wire o_uart_tx;
input wire i_uart_rx;
output wire o_uart_rts_n;
input wire i_uart_cts_n;

output wire [7:0] o_leds;
output wire o_user_clk;

// Signals
wire sys_clk, div_clk;
wire rst;
wire rv0_valid, rv0_ready;
wire [6:0] rv0_slave_address;
wire [7:0] rv0_reg_address;
wire [1:0] rv0_burst_count;
wire rv0_rd_wrn;
wire [3:0] [7:0] rv0_wdata;
wire rv1_valid, rv1_ready;
wire [3:0] [7:0] rv1_rdata;

// Convert LVDS clock to internal clock signal
IBUFGDS #(
    .DIFF_TERM("FALSE"), // Differential termination
    .IBUF_LOW_PWR("TRUE"), // Low power="TRUE", High performance="FALSE"
    .IOSTANDARD("DEFAULT") // Specify input IO standard
) user_clk_ibufgds (
    .O(o_user_clk), // Clock output buffer
    .I(i_user_clk_p), // Diff_p clock buffer input (connect directly to top-level port)
    .IB(i_user_clk_n) // Diff_n clock buffer input (connect directly to top-level port)
);

// Convert LVDS clock to internal clock signal
IBUFGDS #(
    .DIFF_TERM("FALSE"), // Differential termination
    .IBUF_LOW_PWR("TRUE"), // Low power="TRUE", High performance="FALSE"
    .IOSTANDARD("DEFAULT") // Specify input IO standard
) sys_clk_ibufgds (
    .O(sys_clk), // Clock output buffer
    .I(i_sys_clk_p), // Diff_p clock buffer input (connect directly to top-level port)
    .IB(i_sys_clk_n) // Diff_n clock buffer input (connect directly to top-level port)
);

// Clock divider (DIVIDE BY 20)
flex_clk_div #(
    .CntWidth(5)
) clk_div (
    .i_ref_clk(sys_clk),
    .i_rst(1'b0),
    .i_div_cnt(5'd19),
    .i_high_cnt(5'd10),
    .i_low_cnt(5'd0),
    .o_out_clk(div_clk)
);

// UART interface
uart_i2c_user_clock #(
    .BaudRate(9600),
    .SystemClockFrequency(10000000) // (200 MHz) / 20 = 10 MHz
) (
    .i_clk(div_clk),
    .i_rst(1'b0),
    .o_uart_tx(o_uart_tx),
    .i_uart_rx(i_uart_rx),
    .o_uart_rts_n(o_uart_rts_n),
    .i_uart_cts_n(i_uart_cts_n),
    .o_mem_leds(o_leds),
    .o_mem_reset(rst),
    .o_mem_rv0_valid(rv0_valid),
    .i_mem_rv0_ready(rv0_ready),
    .o_mem_rv0_slave_address(rv0_slave_address),
    .o_mem_rv0_reg_address(rv0_reg_address),
    .o_mem_rv0_burst_count(rv0_burst_count),
    .o_mem_rv0_wdata0(rv0_wdata[0]),
    .o_mem_rv0_wdata1(rv0_wdata[1]),
    .o_mem_rv0_wdata2(rv0_wdata[2]),
    .o_mem_rv0_wdata3(rv0_wdata[3]),
    .o_mem_rv0_rd_wrn(rv0_rd_wrn),
    .i_mem_rv1_valid(rv1_valid),
    .o_mem_rv1_ready(rv1_ready),
    .i_mem_rv1_rdata0(rv1_rdata[0]),
    .i_mem_rv1_rdata1(rv1_rdata[1]),
    .i_mem_rv1_rdata2(rv1_rdata[2]),
    .i_mem_rv1_rdata3(rv1_rdata[3])
);

// I2C controller for configuring user clock frequency
i2c_master i2c_master_inst (
    .i_clk(div_clk),
    .i_rst(rst),
    .o_sda_oe_n(), // TODO
    .o_scl_oe_n(), // TODO
    .i_sda(), // TODO
    .i_scl(), // TODO
    .i_rv0_valid(rv0_valid),
    .o_rv0_ready(rv0_ready),
    .i_rv0_slave_address(rv0_slave_address),
    .i_rv0_reg_address(rv0_reg_address),
    .i_rv0_wdata(rv0_wdata),
    .i_rv0_burst_count(rv0_burst_count),
    .i_rv0_rd_wrn(rv0_rd_wrn),
    .o_rv1_valid(rv1_valid),
    .i_rv1_ready(rv1_ready),
    .o_rv1_rdata(rv1_rdata)
);

endmodule 

`default_nettype wire 
