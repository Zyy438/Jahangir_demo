/*
writtern by Yuyang Zhou, 
for the MIPS32 processor Jahangir pipeline stage2
the main module for the second stage
to analysis the incoming instruction, if any data needs to be read, then read from the registers
according to their address. if there is no read enable signal, the immidiate number will be load.
*/
module id(
    //no need to connect the clk signal as we have only combined logic here
    input                        rst_n,
    //input signal from last stage
    input           [31:0]       in_pc,        //32bits input address from last stage
    input           [31:0]       in_inst,      //32bits input instruction from last stage
    //data coming from the registers
    input           [31:0]       in_reg1_data,
    input           [31:0]       in_reg2_data,
    //register read enable signal 
    output    reg                out_reg1_enable,
    output    reg                out_reg2_enable,
    //register data out
    output    reg   [31:0]       out_reg1_data,
    output    reg   [31:0]       out_reg2_data,
    //register address out
    output    reg   [4:0]        out_reg1_address,
    output    reg   [4:0]        out_reg2_address,
    //========================================
    //alu operation type (and subtype)
    output    reg   [7:0]        out_alu_op,
    output    reg   [2:0]        out_alu_sel,
    //if there is an writting request
    output    reg   [4:0]        out_wr_address,
    output    reg                out_wr_enable
);  
//============================================================================
//define registers to save the immidiate number
reg             [31:0]          imm;
//signal indicating whether the instruction is valid or not
reg                             instvalid;
//divide the incoming instruction
wire            [5:0]           op;
wire            [4:0]           op2;
wire            [5:0]           op3;
wire            [4:0]           op4;
//============================================================================
//first instruction
assign   op = in_inst[31:26];
assign   op2 = in_inst[10:6];
assign   op3 = in_inst[5:0];
assign   op4 = in_inst[20:16];
//============================================================================
always @(*)begin
    if(rst_n == 1'b0)begin
        out_reg1_enable <= 1'b0;
        out_reg2_enable <= 1'b0;
        out_reg1_address <= 5'b0_0000;
        out_reg2_address <= 5'b0_0000;
        out_alu_op <= 8'b0000_0000;
        out_alu_sel <= 3'b000;
        out_wr_address <= 5'b0_0000;
        out_wr_enable <= 1'b0;
        instvalid <= 1'b0;
        imm <= 32'h0000_0000;
    end
    //we use begin and end structure, thus the codes here will be executed by order(from top to bottom)
    //it is combined logic and blocked assignment
    //then we can construct a case structure to define how to analysis the incoming instruction
    //firstly we load the address of the utilized registers
    else begin
        out_reg1_enable <= 1'b0;
        out_reg2_enable <= 1'b0;
        //read the address of the registers
        out_reg1_address <= in_inst[25:21];
        out_reg2_address <= in_inst[20:16];
        out_alu_op <= 8'b0000_0000;
        out_alu_sel <= 3'b000;
        //if there is, the address of the written register is in the 15-11 bits in the instruction
        out_wr_address <= in_inst[15:11];
        //but we do not start writing yet cause the instruction hasnt been confirmed yet
        out_wr_enable <= 1'b0;
        instvalid <= 1'b0;
        imm <= 32'h0000_0000;
        //then we start to identify the incoming instruction
        case (op) 
        //=============ORI OPERATION======================
        //the instruction of ori operation is 001101
        //it is an i type instruction:6bits instruction,5bits rs,5 bits rt,16bits immidiate number
        6'b001_101:begin
            //need to read data from the first register
            out_reg1_enable <= 1'b1;
            //no need to read data from the second register
            out_reg2_enable <= 1'b0;
            //the opration is ori, its code is 00100101
            out_alu_op <= 8'b0010_0101;
            //the type of operation is LOGIC operation the code for logic inst is 001
            out_alu_sel <= 3'b001;
            //now we can write
            out_wr_enable <= 1'b1;
            //address write the data 
            out_wr_address <= in_inst[20:16];
            //instruction being activited
            instvalid <= 1'b1;
            //immidiate number,we set the high numbers as zeros to make the immidiate number have 32bits
            imm <= {16'h0,in_inst[15:0]};
        end    

        default:begin
        end
        endcase
    end
end
//the output address is now determined according to the incoming instruction, it will be connected to the registers and thus a 
//data will be givien back
//============================================================================
//now determine the output register data according to the incoming data from the registers
always @(*)begin
    if(rst_n==1'b0)begin
        out_reg1_data <= 32'h0000_0000;
    end
    //if it is enabled then we assign this output value as the data from the correspoding register
    else if(out_reg1_enable ==1'b1)begin
        out_reg1_data <= in_reg1_data;
    end
    //if it is not enabled then we assign this output value as immidiate value
    else if(out_reg1_enable ==1'b0)begin
        out_reg1_data <= imm;
    end
    else begin
        out_reg1_data <= 32'h0000_0000;
    end
end
//============================================================================
//now determine the second output register data according to the incoming data from the registers
always @(*)begin
    if(rst_n==1'b0)begin
        out_reg2_data <= 32'h0000_0000;
    end
    //if it is enabled then we assign this output value as the data from the correspoding register
    else if(out_reg1_enable ==1'b1)begin
        out_reg2_data <= in_reg2_data;
    end
    //if it is not enabled then we assign this output value as immidiate value
    else if(out_reg2_enable ==1'b0)begin
        out_reg2_data <= imm;
    end
    else begin
        out_reg2_data <= 32'h0000_0000;
    end
end

endmodule