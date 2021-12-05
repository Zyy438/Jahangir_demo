library verilog;
use verilog.vl_types.all;
entity ex is
    port(
        rst_n           : in     vl_logic;
        in_reg1_data    : in     vl_logic_vector(31 downto 0);
        in_reg2_data    : in     vl_logic_vector(31 downto 0);
        in_wr_address   : in     vl_logic_vector(4 downto 0);
        in_wr_enable    : in     vl_logic;
        in_alu_op       : in     vl_logic_vector(7 downto 0);
        in_alu_sel      : in     vl_logic_vector(2 downto 0);
        out_wr_address  : out    vl_logic_vector(4 downto 0);
        out_wr_data     : out    vl_logic_vector(31 downto 0);
        out_wr_enable   : out    vl_logic
    );
end ex;
