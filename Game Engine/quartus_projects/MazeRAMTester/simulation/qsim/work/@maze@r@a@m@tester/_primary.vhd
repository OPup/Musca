library verilog;
use verilog.vl_types.all;
entity MazeRAMTester is
    port(
        OUTPUT          : out    vl_logic_vector(3 downto 0);
        CLK             : in     vl_logic
    );
end MazeRAMTester;
