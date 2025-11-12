module apb_slave_fsm (
    input        pclock,
    input        presetn,
    input        pwrite,
    input  [2:0] paddr,
    input        psel,
    input        penable,
    input  [7:0] pdata,
    output reg [7:0] prddata,
    output reg   pslaverr,
    output reg   pready
);

    parameter N = 4;
    reg [7:0] mem [0:7];          // 8 x 8 memory
    reg       transaction_active;
    reg [2:0] wait_counter;

    // Sequential logic
    always @(posedge pclock or negedge presetn) begin
        if (!presetn) begin
            pready              <= 0;
            pslaverr            <= 0;
            prddata             <= 0;
            transaction_active  <= 0;
            wait_counter        <= 0;
            integer i;
            for (i = 0; i < 8; i = i + 1) begin
                mem[i] <= 8'b0;
            end
        end 
        else begin
            pslaverr <= 0;
            
            if (psel && penable && !transaction_active) begin
                if (wait_counter < N - 1) begin
                    wait_counter <= wait_counter + 1'b1;
                    pready <= 0;
                end 
                else begin
                    pready <= 1;
                    transaction_active <= 0;
                    wait_counter <= 0;

                    if (pwrite) begin
                        if (paddr >= 3'd7) begin    // Invalid address check (0-7 valid)
                            pslaverr <= 1;
                        end 
                        else begin
                            mem[paddr] <= pdata;
                        end
                    end 
                    else begin
                        if (paddr >= 3'd7) begin
                            pslaverr <= 1;
                            prddata <= 8'b0;
                        end 
                        else begin
                            prddata <= mem[paddr];
                        end
                    end
                end
            end
            else begin
                pready <= 0;
            end
        end
    end

endmodule
