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

module uart_loopback (
    o_uart_tx, 
    i_uart_rx,
    o_uart_rts_n,
    i_uart_cts_n,
    o_fmc_uart_test
);

//-----------------------------------------------------------------------------------
// I/O 
//-----------------------------------------------------------------------------------
output wire o_uart_tx;
input wire i_uart_rx;
output wire o_uart_rts_n; // Request to send (set this to high if ready to accept data)
input wire i_uart_cts_n; // Clear to send (if high then it is okay to send data)
output wire o_fmc_uart_test;
//-----------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------
// Looback 
//-----------------------------------------------------------------------------------
assign o_uart_tx = i_uart_rx;
assign o_uart_rts_n = 1'b0;
assign o_fmc_uart_test = i_uart_rx;
//-----------------------------------------------------------------------------------

endmodule 

`default_nettype wire 
