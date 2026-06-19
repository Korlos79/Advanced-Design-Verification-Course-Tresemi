//=============================================================
// Siemens:
// vlog sv_array.sv
// vsim -c top -do "run -a, quit"
// Cadence:
// xrun -c -uvm sv_array.sv
// xrun -uvm -top worklib.top
//=============================================================
//
// This lab is used to demonstrate how a two-dimensional array is initialized
//
class env;
	parameter MAX_REG = 7, MAX_BANK = 8;

	bit [31:0] err_arr [0:MAX_BANK-1] = '{
		32'h00000000,
		32'h10101010,
		32'h20202020,
		32'h30303030,
		32'h40404040,
		32'h50505050,
		32'h60606060,
		32'h70707070
		};
		
	function void print_arr;
		for (int i=0; i<MAX_BANK; i++)
				$display("i=%2d %x",i,err_arr[i]);
	endfunction
	
endclass

module top;
	env env0;
	
  initial begin
		env0 = new; // Instantiate the environment class
		env0.print_arr();
	end
		
endmodule
