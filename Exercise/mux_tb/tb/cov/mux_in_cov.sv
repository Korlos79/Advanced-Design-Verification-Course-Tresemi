//***************************************************************************************************************
// Author: Van Le
// vanleatwork@yahoo.com
// Phone: VN: 0396221156, US: 5125841843
// This class provides coverage for the REQ transactions. 
// To view coverage data, use the command
//    vsim -viewcov <filename>.ucdb
//***************************************************************************************************************
class mux_in_cov #(type REQ = uvm_sequence_item) extends uvm_component;

  `uvm_component_param_utils(mux_in_cov #(REQ))

  uvm_analysis_imp #(REQ,mux_in_cov #(REQ)) cov_imp;

  string   my_name;
 
  mux_in_data_t  data;
  mux_in_chan_t 	chan;
 
  //
  // covergroup is a user-defined construct. It can be declared outside or inside a class declaration.
  // Declaring it inside a class makes the code easier to read.
  // Here we are interested in monitoring coverage of the address and transaction types for all tlm transactions.
  //
  covergroup mux_in_cov_grp;
    //
    // Declare coverpoint for address. Coverage is divided into bins where each bin represents a range 
    // of values that the address falls into.
    //
    chan_cov: coverpoint chan {
        bins chan_3 = {3};
        bins chan_2 = {2};
        bins chan_1 = {1};
        bins chan_0 = {0};
        bins out_of_range = default;
    }
  endgroup
  
  //
  // NEW
  //
  function new(string name, uvm_component parent);
    super.new(name,parent);
    my_name = name;
    // Create an instance of covergroup
    mux_in_cov_grp = new;  // can't do this in build
    cov_imp = new("COV_IMP",this);
  endfunction
 
  //
  // BUILD phase
  // Create an instance of cover queue
  //
  function void build;
    super.build();
  endfunction
  
  //
  // Implement the write function for the cov_imp
  //
  function void write(REQ pkt);
    `uvm_info(my_name,$psprintf("chan=%d",pkt.chan),UVM_NONE)
    chan = pkt.chan;
    data = pkt.data;
    mux_in_cov_grp.sample();
  endfunction
   
endclass
