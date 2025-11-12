

`include "uvm_macros.svh"
`include "apb_pkg.sv"
import uvm_pkg::*;
import pkg::*;

module tb;

    bit clock;
    bit presetn;
    apb_aif aif (clock);

    assign aif.presetn = presetn ;
    
    initial begin
         clock = 0 ;
         forever begin
            #5 clock = ~clock ;
         end
    end

    initial begin
            presetn = 1'b0 ;
            #20;
            presetn = 1'b1 ;
    end

    apb_slave dut(

        .pclock(aif.pclock),
        .presetn(aif.presetn),
        .psel(aif.psel),
        .penable(aif.enable),
        .pwrite(aif.pwrite),
        .paddr(aif.paddr),
        .pwdata(aif.pwdata),
        .prdata(aif.prdata),
        .pslverr(aif.pslverr),
        .pready(aif.pready)
    );

    initial begin
        uvm_config_db #(virtual apb_aif)::set(null,"*","aif",aif);
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);
    end

    initial begin
        run_test("apb_test");
    end



endmodule