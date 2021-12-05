library verilog;
use verilog.vl_types.all;
entity rom is
    port(
        pc              : in     vl_logic_vector(31 downto 0);
        ce              : in     vl_logic;
        inst            : out    vl_logic_vector(31 downto 0)
    );
end rom;
