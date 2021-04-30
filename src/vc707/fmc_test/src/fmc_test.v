`timescale 1ns/1ps
`default_nettype none

module fmc_test (
    i_sys_clk_p, 
    i_sys_clk_n, 
    i_rst,
    o_fmc_clk_p,
    o_fmc_gnd,
);

input wire i_sys_clk_p;
input wire i_sys_clk_n;
input wire i_rst;
output wire o_fmc_clk_p;
//output wire o_fmc_clk_n;
output [2:0] o_fmc_gnd;

wire clk, fmc_clk_p, fmc_clk_n;

assign o_fmc_gnd = 3'b000;

// Convert LVDS clock to internal clock signal
IBUFGDS #(
    .DIFF_TERM("FALSE"), // Differential termination
    .IBUF_LOW_PWR("TRUE"), // Low power="TRUE", High performance="FALSE"
    .IOSTANDARD("DEFAULT") // Specify input IO standard
) IBUFGDS_inst (
    .O(clk), // Clock output buffer
    .I(i_sys_clk_p), // Diff_p clock buffer input (connect directly to top-level port)
    .IB(i_sys_clk_n) // Diff_n clock buffer input (connect directly to top-level port)
);

// Output buffer for fmc clk p
OBUF #(
    .DRIVE(16), // Specify the output drive strength
    .IOSTANDARD("DEFAULT"), // Specify the output I/O standard
    .SLEW("FAST") // Specify the output slew rate
) obuf_clk_p (
    .O(o_fmc_clk_p),
    .I(fmc_clk_p)
);

//// Output buffer for fmc clk n 
//OBUF #(
//    .DRIVE(12), // Specify the output drive strength
//    .IOSTANDARD("DEFAULT"), // Specify the output I/O standard
//    .SLEW("SLOW") // Specify the output slew rate
//) obuf_clk_n (
//    .O(o_fmc_clk_n),
//    .I(fmc_clk_n)
//);

// Generate scan clock
scan_clk_gen #(.ScanClkDiv(20)) sclk_gen_inst (
    .i_clk(clk),
    .i_rst(i_rst),
    .o_scan_clk_p(fmc_clk_p),
    .o_scan_clk_n(fmc_clk_n)
);

endmodule 

`default_nettype wire
