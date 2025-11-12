
`include "apb_define.sv"

interface apb_aif (input pclock);

    logic psel ;
    logic presetn ;
    logic penable ;
    logic pwrite ;
    logic pready ;
    logic pslverr ;
    logic [ADDR_WIDTH-1 : 0] paddr  ;
    logic [DATA_WIDTH-1 : 0] pwdata ;
    logic [DATA_WIDTH-1 : 0] prdata ;

    clocking DRV_CB @(posedge pclock);
        
        default input #1 output #1 ;
        output psel,presetn,penable,pwrite,paddr ;
        input pslverr , prdata , pready ;

    endclocking

    clocking DRV_MON @(posedge pclock);
        default input #1 output #1;
        input psel , presetn , penable ,pwrite , paddr ;
        input pslverr , prdata , pready ;
    endclocking

endinterface