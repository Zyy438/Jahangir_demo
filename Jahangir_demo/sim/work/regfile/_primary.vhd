library verilog;
use verilog.vl_types.all;
entity regfile is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        in_wr_address   : in     vl_logic_vector(4 downto 0);
        in_wr_data      : in     vl_logic_vector(31 downto 0);
        in_wr_enable    : in     vl_logic;
        in_rd_address1  : in     vl_logic_vector(4 downto 0);
        out_rd_data1    : out    vl_logic_vector(31 downto 0);
        in_rd_enable1   : in     vl_logic;
        in_rd_address2  : in     vl_logic_vector(4 downto 0);
        out_rd_data2    : out    vl_logic_vector(31 downto 0);
        in_rd_enable2   : in     vl_logic
    );
end regfile;
