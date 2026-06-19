//============================================================================================================================
// Siemens:
// vlog phases.sv
// vsim -c top -do "run -a; quit"
// Cadence:
// xrun -c -uvm phases.sv
// xrun -uvm -top worklib.top
//============================================================================================================================
// This example shows the order phases are executed
//

import uvm_pkg::*;

`include "uvm_macros.svh"

//============================================================================================================================
// Environment layer
//============================================================================================================================
class env extends uvm_env;
	`uvm_component_utils(env)

	string my_name;

  //
  // NEW
  //
	function new(string name, uvm_component parent);
		super.new(name,parent);
		my_name = name;
    `uvm_info(my_name,"NEW is called",UVM_NONE)
	endfunction
  
  //
  // BUILD
  //
  function void build_phase(uvm_phase phase);
    `uvm_info(my_name,"BUILD is called",UVM_NONE)
  endfunction
  
  //
  // CONNECT
  //
  function void connect_phase(uvm_phase phase);
    `uvm_info(my_name,"CONNECT is called",UVM_NONE)
  endfunction
  
  //
  // END_OF_ELABORATION
  //
  function void end_of_elaboration_phase(uvm_phase phase);
    `uvm_info(my_name,"END_OF_ELABORATION is called",UVM_NONE)
  endfunction
  
  //
  // START_OF_SIMULATION
  //
  function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(my_name,"START_OF_SIMULATION is called",UVM_NONE)
  endfunction
  
  //
  // RUN
  //
  task run_phase(uvm_phase phase);
    // Raise the objection count by 1
    phase.raise_objection(this,"Objection raised by env_h");

    `uvm_info(my_name,"RUN is called",UVM_NONE)
    #10;

    // Lower objection count by 1. Simulation finishes when reaching 0
    phase.drop_objection(this,"Objection dropped by env_h");
  endtask
	
  //
  // CHECK
  //
  function void check_phase(uvm_phase phase);
    `uvm_info(my_name,"CHECK is called",UVM_NONE)
  endfunction
  
  //
  // REPORT
  //
  function void report_phase(uvm_phase phase);
    `uvm_info(my_name,"REPORT is called",UVM_NONE)
  endfunction
  
endclass

//============================================================================================================================
// Test layer
//============================================================================================================================
class demo_test extends uvm_test;

	`uvm_component_utils(demo_test)
	
	string my_name;

  env env_h;
	
  //
  // NEW
  //
	function new(string name, uvm_component parent);
		super.new(name,parent);
		my_name = name;
    `uvm_info(my_name,"NEW is called",UVM_NONE)
	endfunction
  
  //
  // BUILD
  //
  function void build_phase(uvm_phase phase);
    `uvm_info(my_name,"BUILD is called",UVM_NONE)
     env_h = env::type_id::create("env_h",this);
  endfunction
  
  //
  // CONNECT
  //
  function void connect_phase(uvm_phase phase);
    `uvm_info(my_name,"CONNECT is called",UVM_NONE)
  endfunction
  
  //
  // END_OF_ELABORATION
  //
  function void end_of_elaboration_phase(uvm_phase phase);
    `uvm_info(my_name,"END_OF_ELABORATION is called",UVM_NONE)
  endfunction
  
  //
  // START_OF_SIMULATION
  //
  function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(my_name,"START_OF_SIMULATION is called",UVM_NONE)
  endfunction
  
  //
  // RUN
  //
  task run_phase(uvm_phase phase);
    // Raise the objection count by 1
    phase.raise_objection(this,"Objection raised by demo_test");

    `uvm_info(my_name,"RUN is called",UVM_NONE)
    #10;

    // Lower objection count by 1. Simulation finishes when reaching 0
    phase.drop_objection(this,"Objection dropped by demo_test");
  endtask
	
  //
  // CHECK
  //
  function void check_phase(uvm_phase phase);
    `uvm_info(my_name,"CHECK is called",UVM_NONE)
  endfunction
  
  //
  // REPORT
  //
  function void report_phase(uvm_phase phase);
    `uvm_info(my_name,"REPORT is called",UVM_NONE)
  endfunction
  
endclass

//============================================================================================================================
// TOP
//============================================================================================================================
module top;

   initial
      begin
      run_test("demo_test");
      end

endmodule
