-- ----------------------------------------------------------------------
--  HLS HDL:        VHDL Netlister
--  HLS Version:    2011a.126 Production Release
--  HLS Date:       Wed Aug  8 00:52:07 PDT 2012
-- 
--  Generated by:   kjr115@EEWS104A-009
--  Generated date: Tue May 03 14:26:49 2016
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
    fsm_output : OUT STD_LOGIC_VECTOR (5 DOWNTO 0);
    st_main_1_for_1_tr0 : IN STD_LOGIC
  );
END Render_core_fsm;

ARCHITECTURE v14 OF Render_core_fsm IS
  -- Default Constants

  -- FSM State Type Declaration for Render_core_fsm_1
  TYPE Render_core_fsm_1_ST IS (st_main, st_main_1_for, st_main_1_for_1, st_main_1,
      st_main_2_for, st_main_2_for_1);

  SIGNAL state_var : Render_core_fsm_1_ST;
  SIGNAL state_var_NS : Render_core_fsm_1_ST;

BEGIN
  -- Default Constant Signal Assignments

  Render_core_fsm_1 : PROCESS (st_main_1_for_1_tr0, state_var)
  BEGIN
    CASE state_var IS
      WHEN st_main =>
        fsm_output <= STD_LOGIC_VECTOR'("000001");
        state_var_NS <= st_main_1_for;
      WHEN st_main_1_for =>
        fsm_output <= STD_LOGIC_VECTOR'("000010");
        state_var_NS <= st_main_1_for_1;
      WHEN st_main_1_for_1 =>
        fsm_output <= STD_LOGIC_VECTOR'("000100");
        IF ( st_main_1_for_1_tr0 = '1' ) THEN
          state_var_NS <= st_main_1;
        ELSE
          state_var_NS <= st_main_1_for;
        END IF;
      WHEN st_main_1 =>
        fsm_output <= STD_LOGIC_VECTOR'("001000");
        state_var_NS <= st_main_2_for;
      WHEN st_main_2_for =>
        fsm_output <= STD_LOGIC_VECTOR'("010000");
        state_var_NS <= st_main_2_for_1;
      WHEN st_main_2_for_1 =>
        fsm_output <= STD_LOGIC_VECTOR'("100000");
        IF ( st_main_1_for_1_tr0 = '1' ) THEN
          state_var_NS <= st_main;
        ELSE
          state_var_NS <= st_main_2_for;
        END IF;
      WHEN OTHERS =>
        fsm_output <= "000000";
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

END v14;

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
    v_out_rsc_mgc_out_stdreg_d : OUT STD_LOGIC_VECTOR (11 DOWNTO 0)
  );
END Render_core;

ARCHITECTURE v14 OF Render_core IS
  -- Default Constants

  -- Output Reader Declarations
  SIGNAL v_out_rsc_mgc_out_stdreg_d_drv : STD_LOGIC_VECTOR (11 DOWNTO 0);

  -- Interconnect Declarations
  SIGNAL fsm_output : STD_LOGIC_VECTOR (5 DOWNTO 0);
  SIGNAL for_i_2_sva : STD_LOGIC_VECTOR (20 DOWNTO 0);
  SIGNAL for_i_2_sva_1 : STD_LOGIC_VECTOR (20 DOWNTO 0);
  SIGNAL for_i_1_sva : STD_LOGIC_VECTOR (20 DOWNTO 0);
  SIGNAL z_out : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL z_out_2 : STD_LOGIC_VECTOR (20 DOWNTO 0);
  SIGNAL reg_main_1_for_slc_itm_cse : STD_LOGIC;

  SIGNAL mux_nl : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL mux_3_nl : STD_LOGIC_VECTOR (20 DOWNTO 0);
  COMPONENT Render_core_fsm
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      fsm_output : OUT STD_LOGIC_VECTOR (5 DOWNTO 0);
      st_main_1_for_1_tr0 : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL Render_core_fsm_inst_fsm_output : STD_LOGIC_VECTOR (5 DOWNTO 0);
  SIGNAL Render_core_fsm_inst_st_main_1_for_1_tr0 : STD_LOGIC;

BEGIN
  -- Default Constant Signal Assignments

  -- Output Reader Assignments
  v_out_rsc_mgc_out_stdreg_d <= v_out_rsc_mgc_out_stdreg_d_drv;

  Render_core_fsm_inst : Render_core_fsm
    PORT MAP(
      clk => clk,
      rst => rst,
      fsm_output => Render_core_fsm_inst_fsm_output,
      st_main_1_for_1_tr0 => Render_core_fsm_inst_st_main_1_for_1_tr0
    );
  fsm_output <= Render_core_fsm_inst_fsm_output;
  Render_core_fsm_inst_st_main_1_for_1_tr0 <= NOT reg_main_1_for_slc_itm_cse;

  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        for_i_2_sva <= STD_LOGIC_VECTOR'("000000000000000000000");
        v_out_rsc_mgc_out_stdreg_d_drv <= STD_LOGIC_VECTOR'("000000000000");
        reg_main_1_for_slc_itm_cse <= '0';
        for_i_2_sva_1 <= STD_LOGIC_VECTOR'("000000000000000000000");
        for_i_1_sva <= STD_LOGIC_VECTOR'("000000000000000000000");
      ELSE
        for_i_2_sva <= for_i_2_sva_1 AND STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(fsm_output(2),
            1),21));
        v_out_rsc_mgc_out_stdreg_d_drv <= MUX1HOT_v_12_3_2(STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(z_out(3),
            1),12)) & STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(z_out(3), 1),12))
            & v_out_rsc_mgc_out_stdreg_d_drv, STD_LOGIC_VECTOR'((fsm_output(1)) &
            (fsm_output(4)) & (NOT((fsm_output(4)) OR (fsm_output(1))))));
        reg_main_1_for_slc_itm_cse <= readindex(STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(UNSIGNED(z_out_2(20
            DOWNTO 18)), 4) + SIGNED'("1011"), 4)), 3);
        for_i_2_sva_1 <= z_out_2;
        for_i_1_sva <= for_i_2_sva_1 AND STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(fsm_output(5),
            1),21));
      END IF;
    END IF;
  END PROCESS;
  mux_nl <= MUX_v_4_2_2((for_i_2_sva(20 DOWNTO 17)) & (for_i_1_sva(20 DOWNTO 17)),
      fsm_output(4));
  z_out <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(mux_nl) + UNSIGNED'("1011"), 4));
  mux_3_nl <= MUX_v_21_2_2(for_i_2_sva & for_i_1_sva, fsm_output(4));
  z_out_2 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(mux_3_nl) + UNSIGNED'("000000000000000000001"),
      21));
END v14;

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
    v_out_rsc_z : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC
  );
END Render;

ARCHITECTURE v14 OF Render IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL v_out_rsc_mgc_out_stdreg_d : STD_LOGIC_VECTOR (11 DOWNTO 0);

  SIGNAL v_out_rsc_mgc_out_stdreg_d_1 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL v_out_rsc_mgc_out_stdreg_z : STD_LOGIC_VECTOR (11 DOWNTO 0);

  COMPONENT Render_core
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      v_out_rsc_mgc_out_stdreg_d : OUT STD_LOGIC_VECTOR (11 DOWNTO 0)
    );
  END COMPONENT;
  SIGNAL Render_core_inst_v_out_rsc_mgc_out_stdreg_d : STD_LOGIC_VECTOR (11 DOWNTO
      0);

BEGIN
  -- Default Constant Signal Assignments

  v_out_rsc_mgc_out_stdreg : mgc_hls.mgc_ioport_comps.mgc_out_stdreg
    GENERIC MAP(
      rscid => 1,
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
      v_out_rsc_mgc_out_stdreg_d => Render_core_inst_v_out_rsc_mgc_out_stdreg_d
    );
  v_out_rsc_mgc_out_stdreg_d <= Render_core_inst_v_out_rsc_mgc_out_stdreg_d;

END v14;



