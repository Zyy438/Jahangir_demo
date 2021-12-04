/*
writtern by Yuyang Zhou, 
for the MIPS32 processor Jahangir pipeline stage1
to temporarily store the extracted instruction and ready to transmit it to next stage
the address bus gets 32 bits, the instruction bus gets 32 bits as well
the rom isnt included in this stage as the instructions may be changed.
it will be connected with the processor by using another top level entity.
*/
module ifid(
    input                   clk,
    input                   rst_n,
    //input signal, the input address and instructions
    input                   if_pc,
    input    [31:0]         if_inst,
    //output signal, output it to next stage
    output   reg            id_pc,
    output   reg  [31:0]    id_inst
);

//===================================================================
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        id_pc <= 1'b0;
    end
    else begin
        id_pc<= if_pc;
    end
end 
//load the instructions 
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        id_inst <= 32'h0000_0000;
    end
    else begin
        id_inst <= if_inst;
    end
end

endmodule