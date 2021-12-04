/*
writtern by Yuyang Zhou, 
for the MIPS32 processor Jahangir pipeline stage2
to load the incoming data from the second stage and thus transmitt it to next stage
(executive)    essentially it is just a register
*/
module idex(
    input                   clk,
    input                   rst_n,
    //incoming data
    input           [31:0]      in_reg1_data,
    input           [31:0]      in_reg2_data,
    input           [4:0]       in_wr_address,
    input                       in_wr_enable,
    input           [7:0]       in_alu_op,
    input           [2:0]       in_alu_sel,
    //output them all
    output  reg     [31:0]      out_reg1_data,
    output  reg     [31:0]      out_reg2_data,
    output  reg     [4:0]       out_wr_address,
    output  reg                 out_wr_enable,
    output  reg     [7:0]       out_alu_op,
    output  reg     [2:0]       out_alu_sel
);
//============================================================================
//just load the data at the rising edge of clk signal
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        out_reg1_data <= 32'h0000_0000;
        out_reg2_data <= 32'h0000_0000;
        out_wr_address <= 5'b0_0000;
        out_wr_enable <= 1'b0;
        out_alu_op <= 8'b0000_0000;
        out_alu_sel <= 3'b000;
    end
    else begin
        out_reg1_data <= in_reg1_data;
        out_reg2_data <= in_reg2_data;
        out_wr_address <= in_wr_address;
        out_wr_enable <= in_wr_enable;
        out_alu_op <= in_alu_op;
        out_alu_sel <= in_alu_sel;
    end
end
endmodule