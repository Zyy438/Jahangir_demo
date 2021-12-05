library verilog;
use verilog.vl_types.all;
entity id is
    port(
        rst_n           : in     vl_logic;
        in_pc           : in     vl_logic_vector(31 downto 0);
        in_inst         : in     vl_logic_vector(31 downto 0);
        in_reg1_data    : in     vl_logic_vector(31 downto 0);
        in_reg2_data    : in     vl_logic_vector(31 downto 0);
        out_reg1_enable : out    vl_logic;
        out_reg2_enable : out    vl_logic;
        out_reg1_data   : out    vl_logic_vector(31 downto 0);
        out_reg2_data   : out    vl_logic_vector(31 downto 0);
        out_reg1_address: out    vl_logic_vector(4 downto 0);
        out_reg2_address: out    vl_logic_vector(4 downto 0);
        out_alu_op      : out    vl_logic_vector(7 downto 0);
        out_alu_sel     : out    vl_logic_vector(2 downto 0);
        out_wr_address  : out    vl_logic_vector(4 downto 0);
        out_wr_enable   : out    vl_logic
    );
end id;
