class apb_agent extends uvm_agent ;

    `uvm_component_utils(apb_agent);

    apb_driver apb_drv ;
    apb_monitor apb_mon;
    apb_sequence apb_seq ;


    function new(string path ="apb_agent" , uvm_component parent =  null);
            super.new(path , parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.buid_phase(phase);

        apb_drv = apb_driver::type_id::create("apb_drv");
        apb_mon = apb_monitor::type_id::create("apb_mon");
        apb_seq = apb_sequence::type_id::create("apb_seq");

    endfunction

    function void connect_phase(uvm_phase phase);

            super.connect_phase(phase);
            `uvm_info("apb_agent",$sformatf("connect the all the component"),UVM_LOW);
            apb_drv.seq_item_port.connect(apb_seq.seq_item_export);
            
    endfunction


endclass