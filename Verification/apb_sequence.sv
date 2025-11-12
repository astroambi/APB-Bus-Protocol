class apb_sequence extends uvm_sequence #(apb_trans);

    `uvm_object_utils(apb_sequence);

    apb_trans ap ;

    function new(string path = "apb_sequence");
        super.new(path);
    endfunction

    task body ();

        repeat(10) begin
            ap = apb_trans::type_id::create("ap");
            `uvm_info("apb_trans",sformtf("Task Body is called"), UVM_LOW);

            start_item(ap);

            assert(ap.randomize()) else `uvm_fatal("apb_trans","Randomization is failed");

            finish_item(ap);

            ap.print();
            
        end

    endtask




endclass