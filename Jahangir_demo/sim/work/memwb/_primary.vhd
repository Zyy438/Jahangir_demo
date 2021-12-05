library verilog;
use verilog.vl_types.all;
entity memwb is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        in_wr_data      : in     vl_logic_vector(31 downto 0);
        in_wr_address   : in     vl_logic_vector(4 downto 0);
        in_wr_enable    : in     vl_logic;
        out_wr_data     : out    vl_logic_vector(31 downto 0);
        out_wr_address  : out    vl_logic_vector(4 downto 0);
        out_wr_enable   : out    vl_logic
    );
end memwb;
