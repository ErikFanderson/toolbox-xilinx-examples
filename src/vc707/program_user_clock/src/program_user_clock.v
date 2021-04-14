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

module program_user_clock (
    i_clk_p, 
    i_clk_n,
    o_clk
);

// I/O 
input wire i_clk_p;
input wire i_clk_n;
output wire o_clk;

// Convert LVDS clock to internal clock signal
IBUFGDS #(
    .DIFF_TERM("FALSE"), // Differential termination
    .IBUF_LOW_PWR("TRUE"), // Low power="TRUE", High performance="FALSE"
    .IOSTANDARD("DEFAULT") // Specify input IO standard
) IBUFGDS_inst (
    .O(o_clk), // Clock output buffer
    .I(i_clk_p), // Diff_p clock buffer input (connect directly to top-level port)
    .IB(i_clk_n) // Diff_n clock buffer input (connect directly to top-level port)
);

endmodule 

`default_nettype wire 
