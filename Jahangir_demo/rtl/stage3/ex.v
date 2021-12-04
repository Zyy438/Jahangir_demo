/*
writtern by Yuyang Zhou, 
for the MIPS32 processor Jahangir pipeline stage3
to execute the incoming instruction
*/
module ex(
    //input                   clk,
    input                   rst_n,
    //incoming data from last stage
    input             [31:0]       in_reg1_data,
    input             [31:0]       in_reg2_data,
    input             [4:0]        in_wr_address,
    input                          in_wr_enable,
    input             [7:0]        in_alu_op,
    input             [2:0]        in_alu_sel,
    //output data 
    output     reg    [4:0]        out_wr_address,
    output     reg    [31:0]       out_wr_data,
    output     reg                 out_wr_enable
);
//============================================================================
//store the outcome temporartly 
reg       [31:0]      logicout;
//============================================================================
//the logic of the received opeartion instruction, do the operation accordingly 
//on the two incoming number(in_reg1_data & in_reg2_data)
always @(*)begin
    if(rst_n==1'b0)begin
        logicout <= 31'h0000_0000;
    end
    else begin
        case (in_alu_op)
            //ORI instruction
            8'b0010_0101: begin
                logicout <= in_reg1_data | in_reg2_data;    
            end
        default: begin
            logicout <= 31'h0000_0000;
        end
        endcase
    end
end
//=============================================================================
//the logic of the received operation instruction type. see the type and then decide where to write it
always @(*)begin
    out_wr_address <= in_wr_address;
    out_wr_enable <= in_wr_enable;
    case(in_alu_sel)
    //if the incoming instruction is logic type
    3'b001: begin
        out_wr_data <= logicout;    
    end

    default begin
        out_wr_data <= 32'h0000_0000;
    end
    endcase 
end
endmodule