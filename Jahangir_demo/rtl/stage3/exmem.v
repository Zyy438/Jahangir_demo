/*
writtern by Yuyang Zhou, 
for the MIPS32 processor Jahangir pipeline stage3
to load the data coming from the third(execute) stage
actually just a register
*/
module exmem(
    input                   clk,
    input                   rst_n,
    //incoming data from last stage
    input        [4:0]     in_wr_address,
    input        [31:0]    in_wr_data,
    input                  in_wr_enable,
    //output them into next stage
    output  reg  [4:0]     out_wr_address,
    output  reg  [31:0]    out_wr_data,
    output  reg            out_wr_enable
);
//============================================================================
//woring as a register thus transmit the incoming data into next stage at every
//rising edge of the clk signal.
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        out_wr_address <= 5'b0_0000;
        out_wr_data <= 32'h0000_0000;
        out_wr_enable <= 1'b0;
    end
    else begin
        out_wr_address <= in_wr_address;
        out_wr_data <= in_wr_data;
        out_wr_enable <= in_wr_enable;
    end
end

endmodule