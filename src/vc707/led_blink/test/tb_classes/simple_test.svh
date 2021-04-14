//==============================================================================
// Author: Erik Anderson 
// Email: erik@ayarlabs.com 
// Description: <Insert Description Here> 
// Naming conventions:
//    signals => snake_case
//    Parameters (aliasing signal values) => SNAKE_CASE with all caps
//    Parameters (not aliasing signal values) => CamelCase 
//==============================================================================

class simple_test extends uvm_test;
    // Register w/ factory
    `uvm_component_utils(simple_test)

    // Define members
    env env_h;

    // Build phase! Set factory override and instantiate environment 
    function void build_phase(uvm_phase phase);
        base_tester::type_id::set_type_override(simple_tester::get_type());
        env_h = env::type_id::create("env_h", this);
    endfunction : build_phase

    // Constructor 
    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

endclass
