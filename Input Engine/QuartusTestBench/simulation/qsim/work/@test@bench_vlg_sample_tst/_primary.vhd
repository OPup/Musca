library verilog;
use verilog.vl_types.all;
entity TestBench_vlg_sample_tst is
    port(
        B_IN            : in     vl_logic_vector(9 downto 0);
        clk             : in     vl_logic;
        G_IN            : in     vl_logic_vector(9 downto 0);
        R_IN            : in     vl_logic_vector(9 downto 0);
        sampler_tx      : out    vl_logic
    );
end TestBench_vlg_sample_tst;
