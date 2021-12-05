library verilog;
use verilog.vl_types.all;
entity soc is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic
    );
end soc;
