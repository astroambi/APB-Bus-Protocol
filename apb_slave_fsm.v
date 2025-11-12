module apb_slave_fsm(pclock , presetn , pwrite , paddr , psel , penable , pdata , prddata , pslaverr , pready );

    input pclock ;
    input presetn ;
    input pwrite ;
    input [2:0] paddr ;
    input psel ;
    input enable ;
    input [7:0] pdata ;
    output reg [7:0] prddata ;
    output reg pslaverr ;
    output reg pready ;


    parameter  N  = 4 ;
    reg [7:0] mem [0:7]  // there is 8 X 8 memory count here
    reg transaction_active = 0 ;
    reg [2:0] wait_counter ;
    always @(posedge pclock  && negedge presetn) begin

        if(!presetn) begin
            pready <= 0 ;
            pslaverr <= 0;
            prddata <= 0 ;
            transaction_active <= 0;
            wait_counter <= 0;
            for( int i = 0 ; i < 8 ; i=i+1) begin
                    mem[i] <= 8'b0 ;
            end 
        end
        else begin 
            pslaverr <= 0 ;

            if(psel && penable && !transaction_active) begin
                if(wait_counter < N - 1) begin
                    wait_counter <= wait_counter + 1'b1 ;
                end
                else begin
                    pready <= 1 ;
                    transaction_active <= 0 ;

                    if(pwrite) begin
                        if( paddr >= 8'd9  && paddr <= 8'd15) begin
                                pslaverr <= 1 ;
                        end
                        else begin
                            mem[paddr] <= pdata ;
                        end
                    end
                    else begin
                        prddata <= mem[paddr];
                    end 

                end
            end
        end
        
    end
    

endmodule

// module apb_slave_fsm (
//   input         PCLK,
//   input         PRESETn,
//   input         PSEL,
//   input         PENABLE,
//   input         PWRITE,
//   input  [7:0]  PADDR,
//   input  [7:0]  PWDATA,
//   output reg [7:0] PRDATA,
//   output reg        PREADY,
//   output reg        PSLVERR
// );

//   parameter N = 4;  // Wait states
//   reg [7:0] mem [0:7];
//   reg [2:0] wait_counter;

//   // FSM states
//   typedef enum reg [2:0] {
//     IDLE    = 3'b000,
//     SETUP   = 3'b001,
//     ACCESS  = 3'b010,
//     WAIT_ST = 3'b011,
//     RESPOND = 3'b100
//   } state_t;

//   state_t state, next_state;

//   // State transition
//   always @(posedge PCLK or negedge PRESETn) begin
//     if (!PRESETn)
//       state <= IDLE;
//     else
//       state <= next_state;
//   end

//   // Next state logic
//   always @(*) begin
//     next_state = state;
//     case (state)
//       IDLE:    if (PSEL && !PENABLE) next_state = SETUP;
//       SETUP:   if (PSEL && PENABLE)  next_state = WAIT_ST;
//       WAIT_ST: if (wait_counter == N-1) next_state = RESPOND;
//       RESPOND: next_state = IDLE;
//       default: next_state = IDLE;
//     endcase
//   end

//   // Output + data handling
//   always @(posedge PCLK or negedge PRESETn) begin
//     if (!PRESETn) begin
//       PREADY <= 0;
//       PSLVERR <= 0;
//       wait_counter <= 0;
//     end else begin
//       case (state)
//         IDLE: begin
//           PREADY <= 0;
//           PSLVERR <= 0;
//           wait_counter <= 0;
//         end

//         SETUP: begin
//           PREADY <= 0;
//         end

//         WAIT_ST: begin
//           if (wait_counter < N-1)
//             wait_counter <= wait_counter + 1;
//         end

//         RESPOND: begin
//           PREADY <= 1;
//           if (PWRITE)
//             mem[PADDR[2:0]] <= PWDATA;
//           else
//             PRDATA <= mem[PADDR[2:0]];
//         end
//       endcase
//     end
//   end
// endmodule
