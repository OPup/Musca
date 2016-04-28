library verilog;
use verilog.vl_types.all;
entity TestBench_vlg_check_tst is
    port(
        H_OUT           : in     vl_logic_vector(9 downto 0);
        S_OUT           : in     vl_logic_vector(9 downto 0);
        V_OUT           : in     vl_logic_vector(9 downto 0);
        sampler_rx      : in     vl_logic
    );
end TestBench_vlg_check_tst;
