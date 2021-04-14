//==============================================================================
// Author: Erik Anderson 
// Email: efa@eecs.berkeley.edu 
// Description: Package for "led_blink"
// Naming conventions:
//    signals => snake_case
//    Parameters (aliasing signal values) => SNAKE_CASE with all caps
//    Parameters (not aliasing signal values) => CamelCase 
//==============================================================================

package led_blink_pkg;
    import uvm_pkg::*;
`include "uvm_macros.svh"
   
`include "base_tester.svh"
`include "env.svh"
`include "simple_tester.svh"
`include "simple_test.svh"

//include "command_monitor.svh"
//include "scoreboard.svh"

//// Structs
//struct {
//    
//} decision_data;

endpackage : led_blink_pkg
