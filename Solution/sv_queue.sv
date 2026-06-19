//=============================================================
// Siemens:
// vlog sb.sv
// vsim -c top -do "run -a"
// Cadence:
// xrun -c -uvm sb.sv
// xrun -uvm -top worklib.top
//=============================================================
class env;

  integer aqueue[$];

  function void push_fifo(integer ii);
		aqueue.push_back(ii);
  endfunction
		
  function integer pop_fifo;
		return aqueue.pop_front();
  endfunction
		
	function void print_queue;
		integer ii;
		while (aqueue.size() != 0) begin
			ii = pop_fifo();
			$display("%0d",ii);
		end
	endfunction
	
endclass

//=============================================================
// TOP
//=============================================================
module top;
	env env0;
	
  initial begin
		env0 = new;
    for (int ii=0; ii<10; ii++) begin
      env0.push_fifo(ii);
    end
		env0.print_queue();
	end
		
endmodule
