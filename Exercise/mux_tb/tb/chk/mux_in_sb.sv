//***************************************************************************************************************
// Author: Van Le
// vanleatwork@yahoo.com
// Phone: VN: 0396221156, US: 5125841843
//***************************************************************************************************************
class mux_in_sb #(type REQ = uvm_sequence_item) extends uvm_scoreboard;

  `uvm_component_param_utils(mux_in_sb #(REQ))
  
  uvm_tlm_analysis_fifo #(REQ) ref_ap_fifo;
  uvm_tlm_analysis_fifo #(REQ) act_ap_fifo;
 
  string   my_name;
  
  mux_cfg   sb_cfg;
  
  //
  // NEW
  //
  function new(string name, uvm_component parent);
     super.new(name,parent);
     my_name = name;
  endfunction
  
  //
  // BUILD phase
  // Create instances of reference queue and actual queue
  //
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ref_ap_fifo = new("ref_ap_fifo",this);
    act_ap_fifo = new("act_ap_fifo",this);
  endfunction
  
  //
  // CONNECT phase
  // Connect ports to queues
  //
  function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     assert(uvm_resource_db #(mux_cfg)::read_by_name(get_full_name(),"TB_CONFIG",sb_cfg));
  endfunction
  

  //
  // START_OF_SIMULATION phase
  //
  function void start_of_simulation_phase(uvm_phase phase);
    if (sb_cfg.verbosity_control_arr["scoreboard"] == IS_ENABLE)
      set_report_verbosity_level(UVM_MEDIUM + 1);
    else
      set_report_verbosity_level(UVM_MEDIUM - 1);
  endfunction
  
  //
  // RUN phase
  //
  task run_phase(uvm_phase phase);
    REQ ref_pkt;
    REQ act_pkt;
    
    //
    // When an act_pkt arrives, pull the act_pkt and ref_pkt and perform the comparison
    //
    forever begin
			act_ap_fifo.get(act_pkt);
			if (ref_ap_fifo.is_empty()) begin
				`uvm_error(my_name,"ref_ap_fifo is empty")
			end else begin
				ref_ap_fifo.get(ref_pkt);
				if (ref_pkt.compare(act_pkt)) begin
					`uvm_info(my_name,$psprintf("Matched chan = %0d",act_pkt.chan),UVM_NONE)
				end else begin
					`uvm_error(my_name,$psprintf("Mismatched ref chan = %0d, act chan = %0d",ref_pkt.chan,act_pkt.chan))
				end
			end
    end

  endtask
   
endclass

