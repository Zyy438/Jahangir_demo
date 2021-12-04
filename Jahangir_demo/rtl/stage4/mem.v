/*
writtern by Yuyang Zhou, 
for the MIPS32 processor Jahangir pipeline stage4

*/
module mem(
    input                        rst_n,
    //incoming data
    input           [31:0]       in_wr_data,
    input           [4:0]        in_wr_address,
    input                        in_wr_enable,
    //output data
    output   reg    [31:0]       out_wr_data,
    output   reg    [4:0]        out_wr_address,
    output   reg                 out_wr_enable
);
//============================================================================
always @(*) begin
    if(rst_n == 1'b0) begin
        out_wr_data <= 32'h0000_0000;
        out_wr_address <= 5'b0_0000;
        out_wr_enable <= 1'b0;
    end
    else begin
        out_wr_data <= in_wr_data;
        out_wr_address <= in_wr_address;
        out_wr_enable <= in_wr_enable;
    end
end

endmodule