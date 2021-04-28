`default_nettype none
`timescale 1ns/1ps
module uart_i2c_user_clock #(
    parameter BaudRate = 9600,
    parameter SystemClockFrequency = 156250000
) (
    input wire i_clk,
    input wire i_rst,
    output wire o_uart_tx,
    input wire i_uart_rx,
    output wire o_uart_rts_n,
    input wire i_uart_cts_n,
    output wire [7:0] o_mem_leds,
    output wire o_mem_reset,
    output wire o_mem_rv0_valid_pulse,
    input wire i_mem_rv0_ready,
    output wire [6:0] o_mem_rv0_slave_address,
    output wire [1:0] o_mem_rv0_burst_count_wr,
    output wire [1:0] o_mem_rv0_burst_count_rd,
    output wire [7:0] o_mem_rv0_wdata0,
    output wire [7:0] o_mem_rv0_wdata1,
    output wire [7:0] o_mem_rv0_wdata2,
    output wire [7:0] o_mem_rv0_wdata3,
    output wire o_mem_rv0_rd_wrn,
    input wire i_mem_rv1_valid,
    output wire o_mem_rv1_ready,
    input wire i_mem_rv1_nack,
    input wire [7:0] i_mem_rv1_rdata0,
    input wire [7:0] i_mem_rv1_rdata1,
    input wire [7:0] i_mem_rv1_rdata2,
    input wire [7:0] i_mem_rv1_rdata3
);

//--------------------------------------------------------------------------------
// Signals
//--------------------------------------------------------------------------------
wire [7:0] wmem [127:0];
wire [7:0] rmem [127:0];
wire tx_valid;
wire tx_ready;
wire [7:0] tx_data;
wire rx_valid;
wire rx_ready;
wire [7:0] rx_data;
//--------------------------------------------------------------------------------

//--------------------------------------------------------------------------------
// Module instances
//--------------------------------------------------------------------------------
uart #(
    .BaudRate(BaudRate),
    .SystemClockFrequency(SystemClockFrequency),
    .DataSize(8)
) uart_inst (
    .i_clk(i_clk),
    .i_rst(i_rst),
    .i_rx(i_uart_rx),
    .o_tx(o_uart_tx),
    .i_cts_n(i_uart_cts_n),
    .o_rts_n(o_uart_rts_n),
    .o_tx_ready(tx_ready),
    .i_tx_valid(tx_valid),
    .i_tx_data(tx_data),
    .i_rx_ready(rx_ready),
    .o_rx_valid(rx_valid),
    .o_rx_data(rx_data)
);
uart_i2c_user_clock_mem_map uart_i2c_user_clock_mem_map_inst (
    .uart_i2c_user_clock_write_mem(wmem),
    .uart_i2c_user_clock_read_mem(rmem),
    .leds(o_mem_leds),
    .reset(o_mem_reset),
    .rv0_valid_pulse(o_mem_rv0_valid_pulse),
    .rv0_ready(i_mem_rv0_ready),
    .rv0_slave_address(o_mem_rv0_slave_address),
    .rv0_burst_count_wr(o_mem_rv0_burst_count_wr),
    .rv0_burst_count_rd(o_mem_rv0_burst_count_rd),
    .rv0_wdata0(o_mem_rv0_wdata0),
    .rv0_wdata1(o_mem_rv0_wdata1),
    .rv0_wdata2(o_mem_rv0_wdata2),
    .rv0_wdata3(o_mem_rv0_wdata3),
    .rv0_rd_wrn(o_mem_rv0_rd_wrn),
    .rv1_valid(i_mem_rv1_valid),
    .rv1_ready(o_mem_rv1_ready),
    .rv1_nack(i_mem_rv1_nack),
    .rv1_rdata0(i_mem_rv1_rdata0),
    .rv1_rdata1(i_mem_rv1_rdata1),
    .rv1_rdata2(i_mem_rv1_rdata2),
    .rv1_rdata3(i_mem_rv1_rdata3)
);
uart_mem_access #(
    .DataSize(8)
) uart_mem_access_inst (
    .i_clk(i_clk),
    .i_rst(i_rst),
    .i_rx_data(rx_data),
    .i_rx_valid(rx_valid),
    .o_rx_ready(rx_ready),
    .o_tx_data(tx_data),
    .o_tx_valid(tx_valid),
    .i_tx_ready(tx_ready),
    .o_wmem(wmem),
    .i_rmem(rmem)
);
//--------------------------------------------------------------------------------

//--------------------------------------------------------------------------------
// Task declarations
//--------------------------------------------------------------------------------
//--------------------------------------------------------------------------------

//--------------------------------------------------------------------------------
// Initial statements
//--------------------------------------------------------------------------------
//--------------------------------------------------------------------------------

//--------------------------------------------------------------------------------
// Internals of module
//--------------------------------------------------------------------------------
//--------------------------------------------------------------------------------

endmodule
`default_nettype wire
