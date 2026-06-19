`timescale 1ns / 10ps
//===================================================================================
// Siemens:
// vlog interface.sv
// vsim -c top -do "run -a"
// Cadence:
// xrun -c -uvm interface.sv
// xrun -uvm -top worklib.top
//===================================================================================

import uvm_pkg::*;

`include "uvm_macros.svh"
//============================================================================================================================
// Clock Reset interface
//============================================================================================================================
interface clk_rst_if (output logic clk, output logic rst);

	// Assert reset for num clocks
  task do_reset (integer num);
    `uvm_info("clk_rst_if","Asserting reset",UVM_NONE)
		@(negedge clk);
		rst = 1;
    repeat (num) @(negedge clk);
    rst = 0;
    `uvm_info("clk_rst_if","Deasserting reset",UVM_NONE)
  endtask
                  
	// Wait for num clocks
  task do_wait (integer num);
    repeat (num) @(posedge clk);
  endtask
                  
	// Clock generator
	initial begin
		#1; 
		clk = 1;
		forever begin
			#20 clk = ~clk;
		end 
	end 

endinterface

//===================================================================================
// TOP
//===================================================================================
module top;

  wire   clk;
  wire   rst;
   
  // Create an interface instance
  clk_rst_if  if0(.clk(clk),.rst(rst));

  initial begin
    if0.do_reset(5);
    #2us;
    $finish;
  end
    
endmodule
