library verilog;
use verilog.vl_types.all;
entity idex is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        in_reg1_data    : in     vl_logic_vector(31 downto 0);
        in_reg2_data    : in     vl_logic_vector(31 downto 0);
        in_wr_address   : in     vl_logic_vector(4 downto 0);
        in_wr_enable    : in     vl_logic;
        in_alu_op       : in     vl_logic_vector(7 downto 0);
        in_alu_sel      : in     vl_logic_vector(2 downto 0);
        out_reg1_data   : out    vl_logic_vector(31 downto 0);
        out_reg2_data   : out    vl_logic_vector(31 downto 0);
        out_wr_address  : out    vl_logic_vector(4 downto 0);
        out_wr_enable   : out    vl_logic;
        out_alu_op      : out    vl_logic_vector(7 downto 0);
        out_alu_sel     : out    vl_logic_vector(2 downto 0)
    );
end idex;
