class apb_scoreboard extends uvm_scoreboard ;

    `uvm_component_utils(apb_scoreboard);

    uvm_analysis_imp #(apb_trans , apb_scoreboard)  mon_port; // this is for the checking of the from the monitor 

    uvm_blocking_put_imp #(apb_trans , apb_scoreboard) ref_port ; 

    apb_trans actual_q[$];
    apb_trans  expected_q[$];

    function new(string path ="apb_scorecard" , uvm_component parent = null);
        super.new(path,parent);
        mon_port = new("mon_port", this);
        ref_port = new("ref_port", this);

    endfunction

    function void build_phase(uvm_phase phase);
        super.buid_phase(phase);
    endfunction

    function void write(apb_trans req);

        `uvm_info("apb_scoreboard",$sformatf("Received DUT transaction ADDR is %0d data is %0d ", req.paddr , (req.pwrite ? pwdata : prdata)), UVM_LOW);

        compare();

    endfunction


    // -------- recieve golden transaction from the refernece modal here ----
    task put(apb_trans ref_trans);

        expected_q.push_back(apb_trans ref_trans);
        `uvm_info("apb_scoreboard",$sformatf("Received Golden Transaction from the addr  %0d , data is %0d " , ref_trans.paddr , ref_trans.prdata),UVM_LOW);
    endtask

    task run_phase(uvm_phase phase);
            forever begin
                compare();
            end
    endtask


    function void compare();

        apb_trans actual = actual_q.pop_front();
        apb_trans expect = expected_q.pop_front();

        if(!actual.pwrite) begin
            if(actual.prdata !== expect.prdata) begin
                    `uvm_info("scoreboard" ,$sformatf("MISMATCH is %0d addr %0d and expect data  is %0d and actual got it %0d",expect.paddr ,  expect.prdata , actual.prdata), UVM_LOW);
            end

            else begin 

                    `uvm_info("scoreboard" , $sformatf("MATCH is  addr is %0d expect data %0d and actual data %0d",expect.paddr,expect.prdata,actual.prdata),UVM_LOW);

            end
        end




    endfunction





endclass