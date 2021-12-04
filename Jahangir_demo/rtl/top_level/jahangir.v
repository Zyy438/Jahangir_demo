/*
written by Yuyang Zhou 
used for Jahanjir processor
5 stage pipline structure: pc-->id-->exe-->mom-->wb
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
especially the fifth stage (write back) is implemented in the 
file 'regfile' in the folder 'stage2'
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
*/
module jahangir(
    input                       clk,
    input                       rst_n,
    //the instruction coming from the rom, connected to the 
    //register between first and second stage, will be identified
    //in the second stage
    input            [31:0]     in_rom_data,
    output           [31:0]     out_rom_address,
    output                      out_rom_enable
);
//============================================================
//                  wire definition
//============================================================
//================first stage=================================
wire     [31:0]         stage1_pc;
//================second stage================================
wire     [31:0]         stage2_pc;
wire     [31:0]         stage2_inst;
wire                    stage2_reg1_enable;
wire                    stage2_reg2_enable;
wire     [31:0]         stage2_reg1_data_final;
wire     [31:0]         stage2_reg2_data_final;
wire     [4:0]          stage2_reg1_address;
wire     [4:0]          stage2_reg2_address;
wire     [7:0]          stage2_alu_op;
wire     [2:0]          stage2_alu_sel;
wire     [4:0]          stage2_wr_address;
wire                    stage2_wr_enable;
wire     [31:0]         stage2_reg1_data_inter;
wire     [31:0]         stage2_reg2_data_inter;
//================third stage=================================
wire     [31:0]         stage3_reg1_data;
wire     [31:0]         stage3_reg2_data;
wire     [7:0]          stage3_alu_op;
wire     [2:0]          stage3_alu_sel;
wire     [4:0]          stage3_wr_address;
wire                    stage3_wr_enable;
wire     [4:0]          stage3_wr_address_final;
wire                    stage3_wr_enable_final;
wire     [31:0]         stage3_wr_data;
//================fourth stage================================
wire     [4:0]          stage4_wr_address;
wire                    stage4_wr_enable;
wire     [31:0]         stage4_wr_data;
wire     [4:0]          stage4_wr_address_final;
wire                    stage4_wr_enable_final;
wire     [31:0]         stage4_wr_data_final;
//================fifth stage=================================
wire     [4:0]          stage5_wr_address;
wire                    stage5_wr_enable;
wire     [31:0]         stage5_wr_data;

//============================================================
//                  initiallization
//============================================================
//============================================================
//================first stage=================================
//============================================================
assign out_rom_address = stage1_pc;
//initiallization of first stage
pc u_pc (
    .clk                 (clk),
    .rst_n               (rst_n),
    .pc                  (stage1_pc),
    .ce                  (out_rom_enable)
);
//initiallization of the register between the 1&2 stage
ifid u_ifid (
    .clk                 (clk),
    .rst_n               (rst_n),
    .if_pc               (stage1_pc),
    .if_inst             (in_rom_data),
    //output 
    .id_pc               (stage2_pc),
    .id_inst             (stage2_inst)
);
//============================================================
//================second stage================================
//============================================================
//main module of this stage
id u_id (
    .rst_n               (rst_n),
    //input from last stage
    .in_pc               (stage2_pc),
    .in_inst             (stage2_inst),
    //input from registers
    .in_reg1_data        (stage2_reg1_data_inter),
    .in_reg2_data        (stage2_reg2_data_inter),
    //output
    .out_reg1_enable     (stage2_reg1_enable),
    .out_reg2_enable     (stage2_reg2_enable),
    .out_reg1_data       (stage2_reg1_data_final),
    .out_reg2_data       (stage2_reg2_data_final),
    .out_reg1_address    (stage2_reg1_address),
    .out_reg2_address    (stage2_reg2_address),
    .out_alu_op          (stage2_alu_op),
    .out_alu_sel         (stage2_alu_sel),
    .out_wr_address      (stage2_wr_address),
    .out_wr_enable       (stage2_wr_enable)
);
//initiallization of the registers
regfile u_regfile (
    .clk                 (clk),
    .rst_n               (rst_n),
    //signal coming from stage 5
    .in_wr_address       (stage5_wr_address),
    .in_wr_data          (stage5_wr_data),
    .in_wr_enable        (stage5_wr_enable),
    //signal coming from the id module and output
    .in_rd_address1      (stage2_reg1_address),
    .out_rd_data1        (stage2_reg1_data_inter),
    .in_rd_enable1       (stage2_reg1_enable),
    .in_rd_address2      (stage2_reg2_address),
    .out_rd_data2        (stage2_reg2_data_inter),
    .in_rd_enable2       (stage2_reg2_enable)
);
//initiallization of the register between the 2&3 stage
idex u_idex (
    .clk                 (clk),
    .rst_n               (rst_n),
    //input
    .in_reg1_data        (stage2_reg1_data_final),
    .in_reg2_data        (stage2_reg2_data_final),
    .in_wr_address       (stage2_wr_address),
    .in_wr_enable        (stage2_wr_enable),
    .in_alu_op           (stage2_alu_op),
    .in_alu_sel          (stage2_alu_sel),
    //output
    .out_reg1_data       (stage3_reg1_data),
    .out_reg2_data       (stage3_reg2_data),
    .out_wr_address      (stage3_wr_address),
    .out_wr_enable       (stage3_wr_enable),
    .out_alu_op          (stage3_alu_op),
    .out_alu_sel         (stage3_alu_sel)
);
//============================================================
//================third stage=================================
//============================================================
//main module of this stage
ex u_ex (
    .rst_n               (rst_n),
    //input from last stage
    .in_reg1_data        (stage3_reg1_data),
    .in_reg2_data        (stage3_reg2_data),
    .in_wr_address       (stage3_wr_address),
    .in_wr_enable        (stage3_wr_enable),
    .in_alu_op           (stage3_alu_op),
    .in_alu_sel          (stage3_alu_sel),
    //output 
    .out_wr_address      (stage3_wr_address_final),
    .out_wr_data         (stage3_wr_data), 
    .out_wr_enable       (stage3_wr_enable_final)
);
//initiallization of the register between the 3&4 stage
exmem u_exmem (
    .clk                 (clk),
    .rst_n               (rst_n),
    //input signal
    .in_wr_address       (stage3_wr_address_final),
    .in_wr_data          (stage3_wr_data),
    .in_wr_enable        (stage3_wr_enable_final),
    //output signal
    .out_wr_address      (stage4_wr_address),                                                         
    .out_wr_data         (stage4_wr_data),
    .out_wr_enable       (stage4_wr_enable)
);
//============================================================
//================fourth stage================================
//============================================================
//main module of this stage
mem u_mem (
    .rst_n               (rst_n),
    //input signal
    .in_wr_address       (stage4_wr_address),
    .in_wr_enable        (stage4_wr_enable),
    .in_wr_data          (stage4_wr_data),
    //output signal
    .out_wr_address      (stage4_wr_address_final),
    .out_wr_data         (stage4_wr_data_final),
    .out_wr_enable       (stage4_wr_enable_final)
);
//initiallization of the register between the 4&5 stage
memwb u_memwb (
    .clk                 (clk),
    .rst_n               (rst_n),
    //input signal
    .in_wr_data           (stage4_wr_data_final),
    .in_wr_address        (stage4_wr_address_final),
    .in_wr_enable         (stage4_wr_enable_final),
    //output signal
    .out_wr_data          (stage5_wr_data),
    .out_wr_address       (stage5_wr_address),
    .out_wr_enable        (stage5_wr_enable)
);

endmodule