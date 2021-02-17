//==============================================================================
// Author: Erik Anderson 
// Email: efa@eecs.berkeley.edu
// Description: Top level testbench for "led_blink"
// Naming conventions:
//    signals => snake_case
//    Parameters (aliasing signal values) => SNAKE_CASE with all caps
//    Parameters (not aliasing signal values) => CamelCase 
//==============================================================================

module top;
//-----------------------------------------------------------------------------
// Imports and macros 
//-----------------------------------------------------------------------------
import uvm_pkg::*;
import led_blink_pkg::*;
`include "uvm_macros.svh"
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// Instances
//-----------------------------------------------------------------------------
// Instantiate Bus Functional Model (BFM) interface
led_blink_bfm bfm();
 
// Instantiate Device Under Test (DUT) 
led_blink dut (
    .clk_p(bfm.clk_p),
    .clk_n(bfm.clk_n),
    .led(bfm.led)
);
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// Execute test
//-----------------------------------------------------------------------------
//`ifdef CSVDATA
//int fd;
//always @(posedge bfm.i_clk) begin
//    if (bfm.o_decision_trigger) begin
//        bfm.dec_counter = bfm.dec_counter + 1;
//        $fdisplay(fd,"%d,%d,%d", bfm.dec_counter, bfm.o_heat_out, bfm.o_current_power);
//        //$display("Decision: %d", dec_counter);
//    end
//end
//`endif

initial begin
//`ifdef CSVDATA
//    // Open file for writing
//    fd = $fopen("data.csv", "w");
//    $fdisplay(fd, "decision,heat_code,power,ring_lambda");
//`endif
    // Add BFM to global database
    uvm_config_db #(virtual interface led_blink_bfm)::set(null, "*", "bfm", bfm);
    // Run test defined by UVM_TESTNAME on CLI call  
    run_test();
end
//-----------------------------------------------------------------------------

endmodule : top
