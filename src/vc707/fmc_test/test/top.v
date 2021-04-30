`timescale 1ns/1ps
`default_nettype none

module top ();

reg clk_p, clk_n, rst;
wire fmc_clk_p, fmc_clk_n;

// DUT
fmc_test dut (
    .i_sys_clk_p(clk_p), 
    .i_sys_clk_n(clk_n), 
    .i_rst(rst), 
    .o_fmc_clk_p(fmc_clk_p),
    .o_fmc_clk_n(fmc_clk_n)
);

// Clocks
initial begin
    clk_p = 0;
    clk_n = 1;
    forever begin
        #(1);
        clk_p = ~clk_p;
        clk_n = ~clk_n;
    end
end

// Test
initial begin
    rst = 1'b1;
    #(2);
    rst = 1'b0;
    #(200);
    $finish();
end

endmodule 

`default_nettype wire 
