//***************************************************************************************************************
// Author: Van Le
// vanleatwork@yahoo.com
// Phone: VN: 0396221156, US: 5125841843
//***************************************************************************************************************
class apb_driver #(type REQ = uvm_sequence_item, type RSP = uvm_sequence_item) extends uvm_driver #(REQ,RSP);

  `uvm_component_param_utils(apb_driver #(REQ,RSP))

  //
  // NEW
  //
  function new(string name, uvm_component parent);
     super.new(name,parent);
  endfunction
  
  //
  // CONNECT phase
  // Retrieve a handle to the apb_if and spi_cfg
  //
 
  //
  // RUN phase
  // Retrieve a transaction packet and act on it:
  //

endclass
  
