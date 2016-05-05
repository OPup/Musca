library verilog;
use verilog.vl_types.all;
entity MazeRAMTester_vlg_check_tst is
    port(
        OUTPUT          : in     vl_logic_vector(3 downto 0);
        sampler_rx      : in     vl_logic
    );
end MazeRAMTester_vlg_check_tst;
