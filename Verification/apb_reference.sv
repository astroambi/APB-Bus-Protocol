class apb_reference extends uvm_component;


    `uvm_component_utils(apb_reference);

    uvm_analysis_imp #(apb_trans , apb_reference) port_mon; // get transaction from the mon ;

    uvm_blocking_put_port #(apb_trans) port_sco ; 
    // this is actually used for the transfering to the scoreboard here

    bit [DATA_WIDTH-1:0] mem [int];

    function new(string path = "apb_reference" , uvm_component parent = null);
            super.new(path,parent);
    endfunction


    function void build_phase(uvm_phase phase);
            super.buid_phase(phase);
    endfunction

    function void write(apb_trans temp);
        
    endfunction






endclass