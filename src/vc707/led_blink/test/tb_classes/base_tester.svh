//==============================================================================
// Author: Erik Anderson 
// Email: efa@eecs.berkeley.edu 
// Description: The base class for all tester classes 
// Naming conventions:
//    signals => snake_case
//    Parameters (aliasing signal values) => SNAKE_CASE with all caps
//    Parameters (not aliasing signal values) => CamelCase 
//==============================================================================

class base_tester extends uvm_component;
    // Register w/ factory
    `uvm_component_utils(base_tester)

    // Define members 
    virtual led_blink_bfm bfm;

    // Get global BFM for tester
    function void build_phase(uvm_phase phase);
        if(!uvm_config_db #(virtual led_blink_bfm)::get(null, "*", "bfm", bfm))
            `uvm_fatal("BUILDFATAL", "Failed to get BFM")
    endfunction : build_phase

    // Constructor 
    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    // Define functions/tasks common to all testers!
    //// Run phase! Do testing...
    //task run_phase(uvm_phase phase);
    //
    //    // Begin test
    //    phase.raise_objection(this);
    //    
    //    // End test
    //    phase.drop_objection(this);
    //
    //endtask : run_phase

endclass
