
//=============================================================
// Siemens:
// vlog sv_constraint.sv
// vsim -c top -do "run -a, quit"
// Cadence:
// xrun -c -uvm sv_constraint.sv
// xrun -uvm -top worklib.top
//=============================================================
//
// This lab is used to demonstrate how constraint random is implemented
// compile: vlog sv_constraint.sv
// run: vsim -c top -do "run -a"
//
class trans;
  rand bit [31:0] addr;

  constraint default_c {
    addr[1:0] == 0;
    addr dist {
      [32'h0000_0000:32'h1fff_ffff] := 1,
      [32'h2000_0000:32'h4fff_ffff] := 1,
      [32'h5000_0000:32'h7fff_ffff] := 1,
      [32'h8000_0000:32'hafff_ffff] := 1,
      [32'hb000_0000:32'hffff_ffff] := 1
    };
  }
  
endclass

class env;

  trans trans0;

  function void print_addr;
    trans0 = new;
    for (int i=0; i<10; i++) begin
      assert(trans0.randomize());
      $display("i=%2d %x",i,trans0.addr);
    end
  endfunction

endclass

module top;

  env env0;
  
  initial begin
    env0 = new;
    env0.print_addr();
  end
    
endmodule
