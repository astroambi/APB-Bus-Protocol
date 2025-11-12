class apb_monitor extends uvm_monitor ;

    `uvm_component_utils(apb_monitor);

    function new(string path = "apb_monitor" , uvm_component parent = null);
        super.new(path , parent);
    endfunction

    uvm_analysis_port #(apb_trans) ap_port ;

    virtual apb_aif aif ;

    apb_trans req ;


    function void  build_phase (uvm_phase phase);
            super.build_phase(phase);

            if(!uvm_config_db #(virtual aif )::get(this,"","aif",aif)) begin
                `uvm_fatal("apb_monitor" , " interface is failed at monitor");
            end

            `uvm_info("apb_monitor","Build_phase  is completed here ",UVM_LOW);

    endfunction

    task run_phase(uvm_phase phase);

        `uvm_info("apb_monitor","RUN phase is started ", UVM_LOW);

        forever begin
             get_from_dut();
        end

    endtask


    task get_from_dut();
        @(aif.MON_CB) if (aif.MON_CB.psel && aif.MON_CB.penable && aif.MON_CB.pready) begin

            `uvm_info("apb_monitor","MONITOR INVOKED" , UVM_LOW);

        end
        
        // create id 
        req = apb_trans::type_id::create("req");

        // sample signal here 

        req.paddr = aif.MON_CB.paddr ;
        req.pwrite = aif.MON_CB.pwrite;
        req.pslverr = aif.MON_CB.pslverr;

        if(req.pwrite)  begin
            req.pwdata = aif.MON_CB.pwdata ;
            `uvm_info("apb_monitor",$sformatf("MONITOR write is %0d address %0d data is %0d ", req.pwrite , req.paddr, req.pwdata));
        end

        else begin
            req.prdata = aif.MON_CB.prdata ;
            `uvm_info("apb_monitor", $sformatf("MONITOR write is %0d address is %0d data is %0d ", req.pwrite , req.paddr , req.prdata));
        end
        
    endtask

endclass