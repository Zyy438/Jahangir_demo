/*
writtern by Yuyang Zhou, 
for the MIPS32 processor Jahangir pipeline stage1
to increase the instruction address by 4 for every clk period
*/
module pc(
    input                   clk,
    input                   rst_n,
    //output siganl, the bitwidth of the instruction has 32 bits
    output  reg  [31:0]     pc,
    //to confirm whether the module is enabled or not
    output  reg             ce
);

//===================================================================
//the logic of signal ce, indicating that the address is being added by 4
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        ce<=1'b0;
    end
    else begin
        ce<=1'b1;
    end
end
//the module of signal pc, transmitted to the next module to tell the address of the next instruction
//the reason why we add 4 here is because that there are 4 bytes (8bits for 1 byte) in one instruction, 
//thus 4 bytes need to be skipped to jump to next instruction
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        pc<=32'h0000_0000;
    end
    else if(ce==1'b0)begin
        pc<=32'h0000_0000;
    end
    else begin
        pc<=pc+'h4;
    end
end

endmodule