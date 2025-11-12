class apb_sequencer extends uvm_sequence #(apb_trans);

    `uvm_component_utils(apb_sequencer);

    function new(string path = "apb_sequencer");
            super.new(path);
    endfunction

    function void buid_phase(uvm_phase phase);
            super.buid_phase(phase);
    endfunction

endclass