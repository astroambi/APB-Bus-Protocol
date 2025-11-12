
class apb_env extends uvm_env ;

    `uvm_object_utils(apb_env);

    apb_agent age ;
    apb_scoreboard sco ;
    apb_reference temp ;


    function new(string path = "apb_env" , uvm_component parent = null);
        super.new(path , parent);
    endfunction


    function void build_phase(uvm_phase phase);
            super.buid_phase(phase);
            age = apb_agent::type_id::create("age");
            sco = apb_scoreboard::type_id::create("sco");
            temp = apb_reference::type_id::create("ref");
    endfunction

    function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            age.apb_mon.ap_port.connect(sco.mon_port);
            age.apb_mon.ap_port.connect(temp.mon_port);
            temp.put_port.connect(sco.ref_port);

    endfunction





endclass