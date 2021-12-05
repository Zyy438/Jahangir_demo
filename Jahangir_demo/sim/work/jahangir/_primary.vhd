library verilog;
use verilog.vl_types.all;
entity jahangir is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        in_rom_data     : in     vl_logic_vector(31 downto 0);
        out_rom_address : out    vl_logic_vector(31 downto 0);
        out_rom_enable  : out    vl_logic
    );
end jahangir;
