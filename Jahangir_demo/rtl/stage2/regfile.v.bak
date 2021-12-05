/*
writtern by Yuyang Zhou, 
for the MIPS32 processor Jahangir pipeline stage2
to define 32 registers(bitidth: 32bit), they are temporarily saving the intermidiate data
support writing and reading operation.
the writting operation comes from the last stage, write back.(including enable signal, address and data)
the read operation comes from another module in this stage: id
*/
module regfile(
    input                    clk,
    input                    rst_n,
    //the input and output writting signals, the address of each registers contains 5 bits
    input         [4:0]      in_wr_address,
    input         [31:0]     in_wr_data,
    input                    in_wr_enable,
    //the input and output reading signals for port1, the address of each registers contains 5 bits
    input         [4:0]      in_rd_address1,
    output  reg   [31:0]     out_rd_data1,
    input                    in_rd_enable1,
    //the input and output reading signals for port1, the address of each registers contains 5 bits
    input         [4:0]      in_rd_address2,
    output  reg   [31:0]     out_rd_data2,
    input                    in_rd_enable2
);
//============================================================================
//defining 32 registers, datawidth for each register is 32
reg   [31:0]    regs[0:31];
//============================================================================
//let the writting module receive the data if there is a call
//the data of the first register(address 5'd0) need to be 0 as always, thus if the writting address is given as 0, we  
//are not gonna write the data
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        regs[0] <= 32'h0000_0000;
    end
    else if((in_wr_enable ==1'b1) && (in_wr_address!=5'h0))begin
        regs[in_wr_address] <= in_wr_data;
    end
    else begin
        regs[in_wr_address]<=regs[in_wr_address];
    end
end
//============================================================================
//the reading port1 to receive the address and the data, use combined logic here thus the output will respond immidiatly.
//when the stage 5 wanna write a value into a register and at the same time we wanna read the value from the same register,
//we just directly read the data to be written
always @(*)begin
    if(!rst_n)begin
        out_rd_data1 <= 32'h0000_0000;
    end
    else if (in_rd_address1==5'h0)begin
        out_rd_data1 <= 32'h0000_0000;
    end
    else if((in_rd_enable1==1'b1)&&(in_wr_enable==1'b1)&&(in_rd_address1==in_wr_address))begin
        out_rd_data1 <= in_wr_data;
    end
    else if(in_rd_enable1==1'b1)begin
        out_rd_data1 <= regs[in_rd_address1];
    end
    else begin
        out_rd_data1 <= 32'h0000_0000;
    end
end
//============================================================================
//the reading port2 to receive the address and the data, use combined logic here thus the output will respond immidiatly.
//when the stage 5 wanna write a value into a register and at the same time we wanna read the value from the same register,
//we just directly read the data to be written
always @(*)begin
    if(!rst_n)begin
        out_rd_data2 <= 32'h0000_0000;
    end
    else if (in_rd_address2==5'h0)begin
        out_rd_data2 <= 32'h0000_0000;
    end
    else if((in_rd_enable2==1'b1)&&(in_wr_enable==1'b1)&&(in_rd_address2==in_wr_address))begin
        out_rd_data2 <= in_wr_data;
    end
    else if(in_rd_enable1==1'b1)begin
        out_rd_data2 <= regs[in_rd_address2];
    end
    else begin
        out_rd_data2 <= 32'h0000_0000;
    end
end

endmodule