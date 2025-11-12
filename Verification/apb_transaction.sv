class apb_trans extends uvm_sequence_item ;

    rand bit [ADDR_WIDTH-1:0] paddr ;
    rand bit [DATA_WIDTH-1:0] pwdata ;
    bit [DATA_WIDTH-1 : 0] prdata ;
    bit psel ;
    bit penable ;
    bit pready ;
    bit pslverr ;
    rand bit pwrite ;

    `uvm_object_utils_begin(apb_trans)

        `uvm_field_int(paddr , UVM_ALL_ON | UVM_DEC) ;
        `uvm_field_int(pwdata , UVM_ALL_ON | UVM_DEC) ;
        `uvm_field_int(prdata , UVM_ALL_ON | UVM_DEC) ;
        `uvm_field_int(psel ,  UVM_ALL_ON | UVM_DEC) ;
        `uvm_field_int(penable , UVM_ALL_ON | UVM_DEC) ;
        `uvm_field_int(pready , UVM_ALL_ON | UVM_DEC) ;
        `uvm_field_int(pslverr , UVM_ALL_ON | UVM_DEC) ;
        `uvm_field_int(pwrite , UVM_ALL_ON | UVM_DEC) ;
        
    `uvm_object_utils_end



    constraint pwrite_logic {
        pwrite dist { 1 := 70 , 0 := 30}
    }

    constraint address_range {
        soft paddr inside {[0:1]} ;
    }


endclass