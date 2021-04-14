//==============================================================================
// Author: Erik Anderson 
// Email: erik@ayarlabs.com 
// Description: <Insert Description Here> 
// Naming conventions:
//    signals => snake_case
//    Parameters (aliasing signal values) => SNAKE_CASE with all caps
//    Parameters (not aliasing signal values) => CamelCase 
//==============================================================================

class simple_tester extends base_tester;
    // Register w/ factory
    `uvm_component_utils(simple_tester)

    // Constructor 
    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    // Run phase! Do testing...
    task run_phase(uvm_phase phase);
    
        // Begin test
        phase.raise_objection(this);
        
        // do stuff
        `uvm_info("TEST", "Default tester does nothing", UVM_MEDIUM);

        // End test
        phase.drop_objection(this);
    
    endtask : run_phase

endclass
