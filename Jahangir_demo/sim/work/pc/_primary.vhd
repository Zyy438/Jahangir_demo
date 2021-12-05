library verilog;
use verilog.vl_types.all;
entity pc is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        pc              : out    vl_logic_vector(31 downto 0);
        ce              : out    vl_logic
    );
end pc;
