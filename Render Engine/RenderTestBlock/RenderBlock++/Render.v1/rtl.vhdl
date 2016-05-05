-- ----------------------------------------------------------------------
--  HLS HDL:        VHDL Netlister
--  HLS Version:    2011a.126 Production Release
--  HLS Date:       Wed Aug  8 00:52:07 PDT 2012
-- 
--  Generated by:   cm2715@EEWS104A-016
--  Generated date: Wed May 04 14:31:14 2016
-- ----------------------------------------------------------------------

-- 
-- ------------------------------------------------------------------
--  Design Unit:    Render_core_fsm
--  FSM Module
-- ------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
LIBRARY mgc_hls;
USE mgc_hls.funcs.ALL;
USE work.Render_mux_pkg.ALL;


ENTITY Render_core_fsm IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    fsm_output : OUT STD_LOGIC_VECTOR (1 DOWNTO 0)
  );
END Render_core_fsm;

ARCHITECTURE v1 OF Render_core_fsm IS
  -- Default Constants

  -- FSM State Type Declaration for Render_core_fsm_1
  TYPE Render_core_fsm_1_ST IS (st_main, st_main_1);

  SIGNAL state_var : Render_core_fsm_1_ST;
  SIGNAL state_var_NS : Render_core_fsm_1_ST;

BEGIN
  -- Default Constant Signal Assignments

  Render_core_fsm_1 : PROCESS (state_var)
  BEGIN
    CASE state_var IS
      WHEN st_main =>
        fsm_output <= STD_LOGIC_VECTOR'("01");
        state_var_NS <= st_main_1;
      WHEN st_main_1 =>
        fsm_output <= STD_LOGIC_VECTOR'("10");
        state_var_NS <= st_main;
      WHEN OTHERS =>
        fsm_output <= "00";
        state_var_NS <= st_main;
    END CASE;
  END PROCESS Render_core_fsm_1;

  Render_core_fsm_1_REG : PROCESS (clk)
  BEGIN
    IF clk'event AND ( clk = '1' ) THEN
      IF ( rst = '1' ) THEN
        state_var <= st_main;
      ELSE
        state_var <= state_var_NS;
      END IF;
    END IF;
  END PROCESS Render_core_fsm_1_REG;

END v1;

-- ------------------------------------------------------------------
--  Design Unit:    Render_core
-- ------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
LIBRARY mgc_hls;
USE mgc_hls.funcs.ALL;
USE work.Render_mux_pkg.ALL;


ENTITY Render_core IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    X_pix_rsc_mgc_in_wire_d : IN STD_LOGIC_VECTOR (10 DOWNTO 0);
    Y_pix_rsc_mgc_in_wire_d : IN STD_LOGIC_VECTOR (10 DOWNTO 0);
    v_out_rsc_mgc_out_stdreg_d : OUT STD_LOGIC_VECTOR (11 DOWNTO 0)
  );
END Render_core;

ARCHITECTURE v1 OF Render_core IS
  -- Default Constants

  -- Output Reader Declarations
  SIGNAL v_out_rsc_mgc_out_stdreg_d_drv : STD_LOGIC_VECTOR (11 DOWNTO 0);

  -- Interconnect Declarations
  SIGNAL fsm_output : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL C3443_12_dfmergedata_sg3_lpi_dfm : STD_LOGIC;

  COMPONENT Render_core_fsm
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      fsm_output : OUT STD_LOGIC_VECTOR (1 DOWNTO 0)
    );
  END COMPONENT;
  SIGNAL Render_core_fsm_inst_fsm_output : STD_LOGIC_VECTOR (1 DOWNTO 0);

BEGIN
  -- Default Constant Signal Assignments

  -- Output Reader Assignments
  v_out_rsc_mgc_out_stdreg_d <= v_out_rsc_mgc_out_stdreg_d_drv;

  Render_core_fsm_inst : Render_core_fsm
    PORT MAP(
      clk => clk,
      rst => rst,
      fsm_output => Render_core_fsm_inst_fsm_output
    );
  fsm_output <= Render_core_fsm_inst_fsm_output;

  C3443_12_dfmergedata_sg3_lpi_dfm <= (readindex(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(TO_STDLOGICVECTOR('1')
      & (NOT Y_pix_rsc_mgc_in_wire_d)) + CONV_SIGNED(UNSIGNED'("1100000001"), 12),
      12)), 11)) OR (readindex(STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(Y_pix_rsc_mgc_in_wire_d(10
      DOWNTO 8)), 4) + CONV_UNSIGNED(CONV_SIGNED('1', 1), 4), 4)), 3)) OR (readindex(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(TO_STDLOGICVECTOR('1')
      & (NOT X_pix_rsc_mgc_in_wire_d)) + CONV_SIGNED(UNSIGNED'("1111000001"), 12),
      12)), 11)) OR (readindex(STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(X_pix_rsc_mgc_in_wire_d(10
      DOWNTO 6)), 6) + CONV_UNSIGNED(SIGNED'("1011"), 6), 6)), 5)) OR (NOT((readindex(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(TO_STDLOGICVECTOR('1')
      & (NOT Y_pix_rsc_mgc_in_wire_d)) + CONV_SIGNED(UNSIGNED'("1010011101"), 12),
      12)), 11)) OR (readindex(STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(Y_pix_rsc_mgc_in_wire_d(10
      DOWNTO 2)), 10) + CONV_UNSIGNED(SIGNED'("10100111"), 10), 10)), 9)) OR (readindex(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(TO_STDLOGICVECTOR('1')
      & (NOT X_pix_rsc_mgc_in_wire_d)) + CONV_SIGNED(UNSIGNED'("1101011101"), 12),
      12)), 11)) OR (readindex(STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(X_pix_rsc_mgc_in_wire_d(10
      DOWNTO 2)), 10) + CONV_UNSIGNED(SIGNED'("10010111"), 10), 10)), 9))));
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        v_out_rsc_mgc_out_stdreg_d_drv <= STD_LOGIC_VECTOR'("000000000000");
      ELSE
        v_out_rsc_mgc_out_stdreg_d_drv <= MUX_v_12_2_2(v_out_rsc_mgc_out_stdreg_d_drv
            & (STD_LOGIC_VECTOR'("11") & TO_STDLOGICVECTOR(C3443_12_dfmergedata_sg3_lpi_dfm)
            & TO_STDLOGICVECTOR('1') & TO_STDLOGICVECTOR(C3443_12_dfmergedata_sg3_lpi_dfm)
            & STD_LOGIC_VECTOR'("111") & STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(C3443_12_dfmergedata_sg3_lpi_dfm,
            1),2)) & STD_LOGIC_VECTOR'("11")), fsm_output(0));
      END IF;
    END IF;
  END PROCESS;
END v1;

-- ------------------------------------------------------------------
--  Design Unit:    Render
--  Generated from file(s):
--    2) $PROJECT_HOME/src/Render.cpp
-- ------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
LIBRARY mgc_hls;
USE mgc_hls.funcs.ALL;
USE work.Render_mux_pkg.ALL;


ENTITY Render IS
  PORT(
    X_pix_rsc_z : IN STD_LOGIC_VECTOR (10 DOWNTO 0);
    Y_pix_rsc_z : IN STD_LOGIC_VECTOR (10 DOWNTO 0);
    v_out_rsc_z : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC
  );
END Render;

ARCHITECTURE v1 OF Render IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL X_pix_rsc_mgc_in_wire_d : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL Y_pix_rsc_mgc_in_wire_d : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL v_out_rsc_mgc_out_stdreg_d : STD_LOGIC_VECTOR (11 DOWNTO 0);

  SIGNAL X_pix_rsc_mgc_in_wire_d_1 : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL X_pix_rsc_mgc_in_wire_z : STD_LOGIC_VECTOR (10 DOWNTO 0);

  SIGNAL Y_pix_rsc_mgc_in_wire_d_1 : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL Y_pix_rsc_mgc_in_wire_z : STD_LOGIC_VECTOR (10 DOWNTO 0);

  SIGNAL v_out_rsc_mgc_out_stdreg_d_1 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL v_out_rsc_mgc_out_stdreg_z : STD_LOGIC_VECTOR (11 DOWNTO 0);

  COMPONENT Render_core
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      X_pix_rsc_mgc_in_wire_d : IN STD_LOGIC_VECTOR (10 DOWNTO 0);
      Y_pix_rsc_mgc_in_wire_d : IN STD_LOGIC_VECTOR (10 DOWNTO 0);
      v_out_rsc_mgc_out_stdreg_d : OUT STD_LOGIC_VECTOR (11 DOWNTO 0)
    );
  END COMPONENT;
  SIGNAL Render_core_inst_X_pix_rsc_mgc_in_wire_d : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL Render_core_inst_Y_pix_rsc_mgc_in_wire_d : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL Render_core_inst_v_out_rsc_mgc_out_stdreg_d : STD_LOGIC_VECTOR (11 DOWNTO
      0);

BEGIN
  -- Default Constant Signal Assignments

  X_pix_rsc_mgc_in_wire : mgc_hls.mgc_ioport_comps.mgc_in_wire
    GENERIC MAP(
      rscid => 1,
      width => 11
      )
    PORT MAP(
      d => X_pix_rsc_mgc_in_wire_d_1,
      z => X_pix_rsc_mgc_in_wire_z
    );
  X_pix_rsc_mgc_in_wire_d <= X_pix_rsc_mgc_in_wire_d_1;
  X_pix_rsc_mgc_in_wire_z <= X_pix_rsc_z;

  Y_pix_rsc_mgc_in_wire : mgc_hls.mgc_ioport_comps.mgc_in_wire
    GENERIC MAP(
      rscid => 2,
      width => 11
      )
    PORT MAP(
      d => Y_pix_rsc_mgc_in_wire_d_1,
      z => Y_pix_rsc_mgc_in_wire_z
    );
  Y_pix_rsc_mgc_in_wire_d <= Y_pix_rsc_mgc_in_wire_d_1;
  Y_pix_rsc_mgc_in_wire_z <= Y_pix_rsc_z;

  v_out_rsc_mgc_out_stdreg : mgc_hls.mgc_ioport_comps.mgc_out_stdreg
    GENERIC MAP(
      rscid => 3,
      width => 12
      )
    PORT MAP(
      d => v_out_rsc_mgc_out_stdreg_d_1,
      z => v_out_rsc_mgc_out_stdreg_z
    );
  v_out_rsc_mgc_out_stdreg_d_1 <= v_out_rsc_mgc_out_stdreg_d;
  v_out_rsc_z <= v_out_rsc_mgc_out_stdreg_z;

  Render_core_inst : Render_core
    PORT MAP(
      clk => clk,
      rst => rst,
      X_pix_rsc_mgc_in_wire_d => Render_core_inst_X_pix_rsc_mgc_in_wire_d,
      Y_pix_rsc_mgc_in_wire_d => Render_core_inst_Y_pix_rsc_mgc_in_wire_d,
      v_out_rsc_mgc_out_stdreg_d => Render_core_inst_v_out_rsc_mgc_out_stdreg_d
    );
  Render_core_inst_X_pix_rsc_mgc_in_wire_d <= X_pix_rsc_mgc_in_wire_d;
  Render_core_inst_Y_pix_rsc_mgc_in_wire_d <= Y_pix_rsc_mgc_in_wire_d;
  v_out_rsc_mgc_out_stdreg_d <= Render_core_inst_v_out_rsc_mgc_out_stdreg_d;

END v1;


