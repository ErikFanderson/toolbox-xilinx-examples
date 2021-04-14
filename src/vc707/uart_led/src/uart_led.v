`default_nettype none
`timescale 1ns/1ps
module uart_led #(
    parameter BaudRate = 9600,
    parameter SystemClockFrequency = 156250000
) (
    input wire i_clk,
    input wire i_rst,
    output wire o_uart_tx,
    input wire i_uart_rx,
    output wire o_uart_rts_n,
    input wire i_uart_cts_n,
    output wire [3:0] o_mem_leds0,
    output wire [3:0] o_mem_leds1,
    output wire o_mem_reset
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
uart_led_mem_map uart_led_mem_map_inst (
    .uart_led_write_mem(wmem),
    .uart_led_read_mem(rmem),
    .leds0(o_mem_leds0),
    .leds1(o_mem_leds1),
    .reset(o_mem_reset)
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
