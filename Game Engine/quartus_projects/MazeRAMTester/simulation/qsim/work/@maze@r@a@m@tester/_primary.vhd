library verilog;
use verilog.vl_types.all;
entity MazeRAMTester is
    port(
        WRITE           : out    vl_logic;
        CLK             : in     vl_logic;
        COL             : out    vl_logic_vector(5 downto 0);
        \OUT\           : out    vl_logic_vector(3 downto 0);
        ROW             : out    vl_logic_vector(5 downto 0)
    );
end MazeRAMTester;
