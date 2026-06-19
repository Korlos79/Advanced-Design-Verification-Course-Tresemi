//***************************************************************************************************************
// Author: Van Le
// vanleatwork@yahoo.com
// Phone: VN: 0396221156, US: 5125841843
//***************************************************************************************************************
class mux_in_driver #(type REQ = uvm_sequence_item, type RSP = uvm_sequence_item) extends mux_in_driver_base #(REQ,RSP);

  `uvm_component_param_utils(mux_in_driver #(REQ,RSP))

  string   my_name;
  
  virtual interface mux_in_if vif;
  virtual interface clk_rst_if clk_rst_vif;
 
  //
  // NEW
  //
  function new(string name, uvm_component parent);
    super.new(name,parent);
    my_name = name;
  endfunction
  
  //
  // CONNECT phase
  //
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    //
    // Getting the interface handle via get_config_object call
    //
    if( !uvm_config_db #(virtual mux_in_if)::get(this,"","mux_in_vif",vif) ) begin
      `uvm_error(my_name, "Could not retrieve virtual mux_in_if");
    end
  endfunction
 
  //
  // RUN phase
  //
  virtual task run_phase(uvm_phase phase);
    `uvm_info(my_name,"Running ...",UVM_MEDIUM)
    if( !uvm_config_db #(virtual clk_rst_if)::get(this,"","CLK_RST_VIF",clk_rst_vif) ) begin
      `uvm_error(my_name, "Could not retrieve virtual clk_rst_if");
    end     
    get_and_drive();
  endtask
  
  //
  // This task executes a forever loop. Each loop, it receives an incoming packet from the
  // sequencer. If the packet is a reset packet, it will call do_reset. Otherwise, it calls
  // send_data to send the packet to the DUT
  //
  task get_and_drive;
    string   msg;
    REQ req_pkt;
    RSP rsp_pkt;
    
    `uvm_info(my_name,"Starting get_and_drive",UVM_NONE)
    forever @(posedge vif.clk) begin
      //
      // seq_item_port object is part of the uvm_driver class
      // get_next_item method is part of the interface api between uvm_driver and uvm_sequencer
      //
      seq_item_port.get_next_item(req_pkt); // blocking call
      if (req_pkt == null) begin
        `uvm_info(my_name,"No packet available",UVM_NONE)
        continue;
      end
      `uvm_info(my_name,"Packet available",UVM_NONE)
      if (req_pkt.to_reset == 1)
      	clk_rst_vif.do_reset(5); // Assert reset for 5 clocks
      else
	      send_data(req_pkt); // Call task send_data to send the packet to the DUT
      
      //
      // Send coverage data
      //
			if (req_pkt.to_reset != 1) begin
      	cov_port.write(req_pkt);
			end
      //
      // Send the response packet to the sequence
      //
      rsp_pkt_cnt++;
      rsp_pkt = RSP::type_id::create($psprintf("rsp_pkt_id_%d",rsp_pkt_cnt));
      rsp_pkt.set_id_info(req_pkt);
      rsp_pkt.copy(req_pkt);
      seq_item_port.item_done(rsp_pkt);
    end
  endtask
  
  //
  // This task sends the chan/data to the DUT
  //
 	virtual task send_data(input REQ w_obj);
  	@(posedge vif.clk) begin
  		if (vif.rst == 0 && vif.q_full == 0) begin   	
  			vif.req <= 1;
     		vif.in_data <= w_obj.data;
     		vif.chan <= w_obj.chan;
   		end
   	end
  	@(posedge vif.clk) begin
  		vif.req <= 0;
  	end
  endtask
  
endclass
  
