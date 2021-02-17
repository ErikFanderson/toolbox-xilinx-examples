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
    output wire o_uart_rx_error,
    output wire [7:0] o_mem_leds,
    output wire o_mem_reset
);

//--------------------------------------------------------------------------------
// Signals
//--------------------------------------------------------------------------------
wire [7:0] wmem [127:0];
wire [7:0] rmem [127:0];
wire tx_en;
wire [7:0] tx_byte;
wire rx_done;
wire [7:0] rx_byte;
wire rx_busy;
wire tx_busy;
wire rx_data_valid;
wire rx_data_ready;
wire tx_data_valid;
wire tx_data_ready;
//--------------------------------------------------------------------------------

//--------------------------------------------------------------------------------
// Module instances
//--------------------------------------------------------------------------------
uart #(
    .baud_rate(BaudRate),
    .sys_clk_freq(SystemClockFrequency)
) uart_inst (
    .clk(i_clk),
    .rst(i_rst),
    .rx(i_uart_rx),
    .tx(o_uart_tx),
    .transmit(tx_en),
    .tx_byte(tx_byte),
    .received(rx_done),
    .rx_byte(rx_byte),
    .is_receiving(rx_busy),
    .is_transmitting(tx_busy),
    .recv_error(o_uart_rx_error)
);
uart_led_mem_map uart_led_mem_map_inst (
    .uart_led_write_mem(wmem),
    .uart_led_read_mem(rmem),
    .leds(o_mem_leds),
    .reset(o_mem_reset)
);
uart_mem_access #(
    .DataSize(8)
) uart_mem_access_inst (
    .i_clk(i_clk),
    .i_rst(i_rst),
    .i_rx_data(rx_byte),
    .i_rx_data_valid(rx_data_valid),
    .o_rx_data_ready(rx_data_ready),
    .o_tx_data(tx_byte),
    .o_tx_data_valid(tx_data_valid),
    .i_tx_data_ready(tx_data_ready),
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
assign rx_data_valid = rx_done;
assign o_uart_rts_n = !(rx_data_ready && rx_busy);
assign tx_data_ready = !(i_uart_cts_n || tx_busy);
assign tx_en = tx_data_valid;
//--------------------------------------------------------------------------------

endmodule
`default_nettype wire
