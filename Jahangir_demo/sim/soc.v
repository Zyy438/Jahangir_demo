module soc(
  input             clk,
  input             rst_n
);
//define wires to connect different modules
wire              ce;
wire    [31:0]    pc;
wire    [31:0]    inst;

//instanciation modules
jahangir u_jahangir(
  .clk             (clk),
  .rst_n           (rst_n),
  .in_rom_data     (inst),
  .out_rom_address (pc),
  .out_rom_enable  (ce)
);

rom u_rom (
  .ce              (ce),
  .pc              (pc),
  .inst            (inst)
);

endmodule