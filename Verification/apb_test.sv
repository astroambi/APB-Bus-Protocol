class apb_test  extends uvm_test ;

    `uvm_component_utils(test);
    
    apb_env env ;
    apb_sequence seq ;
    
    function new(string path = "test" , uvm_component parent = null);
        super.new(path , parent);
    endfunction

    function void buid_phase(uvm_phase phase);

        super.build_phase(phase);
        env = apb_env::type_id::create("env",this);
        seq = apb_sequence::type_id::create("seq",this);
        
    endfunction

    task run_phase(uvm_phase phase);

        uvm.raise_objection(this);
             seq.start(env.age.seq);
        uvm.drop_objection(this);

    endtask

    


endclass