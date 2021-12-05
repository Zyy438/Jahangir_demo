library verilog;
use verilog.vl_types.all;
entity ifid is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        if_pc           : in     vl_logic;
        if_inst         : in     vl_logic_vector(31 downto 0);
        id_pc           : out    vl_logic;
        id_inst         : out    vl_logic_vector(31 downto 0)
    );
end ifid;
