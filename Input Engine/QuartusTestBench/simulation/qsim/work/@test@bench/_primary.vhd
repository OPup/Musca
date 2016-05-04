library verilog;
use verilog.vl_types.all;
entity TestBench is
    port(
        H_OUT           : out    vl_logic_vector(9 downto 0);
        clk             : in     vl_logic;
        B_IN            : in     vl_logic_vector(9 downto 0);
        G_IN            : in     vl_logic_vector(9 downto 0);
        R_IN            : in     vl_logic_vector(9 downto 0);
        S_OUT           : out    vl_logic_vector(9 downto 0);
        V_OUT           : out    vl_logic_vector(9 downto 0)
    );
end TestBench;
