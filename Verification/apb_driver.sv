class apb_driver extends uvm_driver ;

    `uvm_component_utils(apb_driver);

    virtual apb_aif aif ;
    apb_trans req ;

    function new(string path = "" , uvm_component parent = null);
        super.new(path , parent);
    end 
    function void buid_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #( virtual aif)::get(this, "" , "aif" , aif))`uvm_fatal("apb_driver","interface is failed connect");
    endfunction

    task run_phase(uvm_phase phase);
        
        seq_item_port.get_next_item(req);
            send_to_dut(req) ;
        seq_item_port.item_done();


    endtask 

    task send_to_dut(apb_trans temp);

    // ------------ setup phase-------
    @(posedge aif.pclock);
    aif.DRV_CB.paddr <= temp.paddr ;
    aif.DRV_CB.pwrite <= temp.pwrite ;
    aif.DRV_CB.pwdata <= temp.pwdata ;
    aif.DRV_CB.psel  <= 1 ;
    aif.DRV_CB.penable <= 0 ;
    aif.DRV_CB.presetn <= 1 ;

    @(posedge aif.pclock);

    aif.DRV_CB.penable <= 1 ; // after one clock we have to apply the penable signak here 

    wait (aif.DRV_CB.pready == 1) ;

    aif.DRV_CB.psel <= 1 ;
    aif.DRV_CB.penable <= 0 ; // then again goes down here

    `uvm_info("apb_driver", sformatf("APB %0s addr is %0d , data is %0d  completed" , (temp.pwrite ? "write":"read") , paddr , (temp.write)? temp.pwdata : aif.DRV_CB.prdata),UVM_MEADIUM);
    endtask

endclass