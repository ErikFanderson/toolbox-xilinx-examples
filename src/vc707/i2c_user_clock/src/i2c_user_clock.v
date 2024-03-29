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
    
    o_user_clk,

    io_sda,
    io_scl,
    o_i2c_rst_n
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

inout wire io_sda;
inout wire io_scl;
output wire o_i2c_rst_n;

// Signals
wire sys_clk, div_clk, i2c_clk;
wire rst;
wire rv0_valid, rv0_valid_pulse, rv0_ready;
wire [6:0] rv0_slave_address;
wire [1:0] rv0_burst_count_wr;
wire [1:0] rv0_burst_count_rd;
wire rv0_rd_wrn;
wire [3:0] [7:0] rv0_wdata;
wire rv1_valid, rv1_ready, rv1_nack;
wire [3:0] [7:0] rv1_rdata;
wire sda, scl, sda_oe_n, scl_oe_n;

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

// SDA I2C I/O buffer
IOBUF #(
    .DRIVE(12), // Specify the output drive strength
    .IBUF_LOW_PWR("TRUE"), // Low Power - "TRUE", High Performance = "FALSE"
    .IOSTANDARD("DEFAULT"), // Specify the output I/O standard
    .SLEW("SLOW") // Specify the output slew rate
) sda_iobuf (
    .O(sda), // Buffer output
    .IO(io_sda), // Buffer inout port (connect directly to top-level port)
    .I(1'b0), // Buffer input
    .T(sda_oe_n) // 3-state enable input, high=input, low=output
);

// SCL I2C I/O buffer
IOBUF #(
    .DRIVE(12), // Specify the output drive strength
    .IBUF_LOW_PWR("TRUE"), // Low Power - "TRUE", High Performance = "FALSE"
    .IOSTANDARD("DEFAULT"), // Specify the output I/O standard
    .SLEW("SLOW") // Specify the output slew rate
) scl_iobuf (
    .O(scl), // Buffer output
    .IO(io_scl), // Buffer inout port (connect directly to top-level port)
    .I(1'b0), // Buffer input
    .T(scl_oe_n) // 3-state enable input, high=input, low=output
);

// Clock divider (DIVIDE BY 20)
flex_clk_div #(
    .CntWidth(5)
) div_clk_div (
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
    .o_mem_rv0_valid_pulse(rv0_valid_pulse),
    .i_mem_rv0_ready(rv0_ready),
    .o_mem_rv0_slave_address(rv0_slave_address),
    .o_mem_rv0_burst_count_wr(rv0_burst_count_wr),
    .o_mem_rv0_burst_count_rd(rv0_burst_count_rd),
    .o_mem_rv0_wdata0(rv0_wdata[0]),
    .o_mem_rv0_wdata1(rv0_wdata[1]),
    .o_mem_rv0_wdata2(rv0_wdata[2]),
    .o_mem_rv0_wdata3(rv0_wdata[3]),
    .o_mem_rv0_rd_wrn(rv0_rd_wrn),
    .i_mem_rv1_valid(rv1_valid),
    .o_mem_rv1_ready(rv1_ready),
    .i_mem_rv1_nack(rv1_nack),
    .i_mem_rv1_rdata0(rv1_rdata[0]),
    .i_mem_rv1_rdata1(rv1_rdata[1]),
    .i_mem_rv1_rdata2(rv1_rdata[2]),
    .i_mem_rv1_rdata3(rv1_rdata[3]),
    .o_mem_i2c_rst_n(o_i2c_rst_n)
);

// Clock divider (DIVIDE BY 40) => 
flex_clk_div #(
    .CntWidth(6)
) i2c_clk_div (
    .i_ref_clk(div_clk),
    .i_rst(1'b0),
    .i_div_cnt(6'd39),
    .i_high_cnt(6'd20),
    .i_low_cnt(6'd0),
    .o_out_clk(i2c_clk)
);

// Pulse gen
pulse_generator valid_pulse (
    .i_clk(i2c_clk),
    .i_rst(rst),
    .i_in(rv0_valid_pulse),
    .o_out(rv0_valid)
);

// I2C controller for configuring user clock frequency
i2c_master i2c_master_inst (
    .i_clk(i2c_clk),
    .i_rst(rst),
    .o_sda_oe_n(sda_oe_n),
    .o_scl_oe_n(scl_oe_n),
    .i_sda(sda),
    .i_scl(scl),
    .i_rv0_valid(rv0_valid),
    .o_rv0_ready(rv0_ready),
    .i_rv0_slave_address(rv0_slave_address),
    .i_rv0_wdata(rv0_wdata),
    .i_rv0_burst_count_wr(rv0_burst_count_wr),
    .i_rv0_burst_count_rd(rv0_burst_count_rd),
    .i_rv0_rd_wrn(rv0_rd_wrn),
    .o_rv1_valid(rv1_valid),
    .i_rv1_ready(rv1_ready),
    .o_rv1_rdata(rv1_rdata),
    .o_rv1_nack(rv1_nack)
);

endmodule 

`default_nettype wire 
