library verilog;
use verilog.vl_types.all;
entity MazeRAMTester_vlg_check_tst is
    port(
        COL             : in     vl_logic_vector(5 downto 0);
        \OUT\           : in     vl_logic_vector(3 downto 0);
        ROW             : in     vl_logic_vector(5 downto 0);
        WRITE           : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end MazeRAMTester_vlg_check_tst;
