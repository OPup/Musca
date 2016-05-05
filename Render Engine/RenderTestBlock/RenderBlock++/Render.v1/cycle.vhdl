-- ----------------------------------------------------------------------
--  HLS HDL:        VHDL Netlister
--  HLS Version:    2011a.126 Production Release
--  HLS Date:       Wed Aug  8 00:52:07 PDT 2012
-- 
--  Generated by:   cm2715@EEWS104A-016
--  Generated date: Wed May 04 14:31:11 2016
-- ----------------------------------------------------------------------

-- 
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

BEGIN
  -- Default Constant Signal Assignments

  core : PROCESS
    -- Interconnect Declarations
    VARIABLE X_pix_1_sva : STD_LOGIC_VECTOR (10 DOWNTO 0);
    VARIABLE Y_pix_1_sva : STD_LOGIC_VECTOR (10 DOWNTO 0);
    VARIABLE slc_svs : STD_LOGIC;
    VARIABLE land_2_sva_1 : STD_LOGIC;
    VARIABLE land_2_lpi_dfm : STD_LOGIC;
    VARIABLE land_1_sva_1 : STD_LOGIC;
    VARIABLE land_1_lpi_dfm : STD_LOGIC;
    VARIABLE land_sva_1 : STD_LOGIC;
    VARIABLE slc_1_svs : STD_LOGIC;
    VARIABLE land_5_sva_1 : STD_LOGIC;
    VARIABLE land_5_lpi_dfm : STD_LOGIC;
    VARIABLE land_4_sva_1 : STD_LOGIC;
    VARIABLE land_4_lpi_dfm : STD_LOGIC;
    VARIABLE land_3_sva_1 : STD_LOGIC;
    VARIABLE C3443_12_dfmergedata_sg3_lpi_dfm : STD_LOGIC;

  BEGIN
    main : LOOP
      -- C-Step 0 of Loop 'main'
      WAIT UNTIL clk'EVENT AND ( clk = '1' );
      EXIT main WHEN ( rst = '1' );
      -- C-Step 1 of Loop 'main'
      land_3_sva_1 := '0';
      land_4_sva_1 := '0';
      land_5_sva_1 := '0';
      land_sva_1 := '0';
      land_1_sva_1 := '0';
      land_2_sva_1 := '0';
      X_pix_1_sva := X_pix_rsc_mgc_in_wire_d;
      Y_pix_1_sva := Y_pix_rsc_mgc_in_wire_d;
      slc_svs := readindex(STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(X_pix_1_sva(10
          DOWNTO 6)), 6) + CONV_UNSIGNED(SIGNED'("1011"), 6), 6)), 5);
      IF ( slc_svs = '1' ) THEN
      ELSE
        land_2_sva_1 := NOT (readindex(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(TO_STDLOGICVECTOR('1')
            & (NOT X_pix_1_sva)) + CONV_SIGNED(UNSIGNED'("1111000001"), 12), 12)),
            11));
      END IF;
      land_2_lpi_dfm := land_2_sva_1 AND (NOT slc_svs);
      IF ( land_2_lpi_dfm = '1' ) THEN
        land_1_sva_1 := NOT (readindex(STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(Y_pix_1_sva(10
            DOWNTO 8)), 4) + CONV_UNSIGNED(CONV_SIGNED('1', 1), 4), 4)), 3));
      END IF;
      land_1_lpi_dfm := land_1_sva_1 AND land_2_lpi_dfm;
      IF ( land_1_lpi_dfm = '1' ) THEN
        land_sva_1 := NOT (readindex(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(TO_STDLOGICVECTOR('1')
            & (NOT Y_pix_1_sva)) + CONV_SIGNED(UNSIGNED'("1100000001"), 12), 12)),
            11));
      END IF;
      slc_1_svs := readindex(STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(X_pix_1_sva(10
          DOWNTO 2)), 10) + CONV_UNSIGNED(SIGNED'("10010111"), 10), 10)), 9);
      IF ( slc_1_svs = '1' ) THEN
      ELSE
        land_5_sva_1 := NOT (readindex(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(TO_STDLOGICVECTOR('1')
            & (NOT X_pix_1_sva)) + CONV_SIGNED(UNSIGNED'("1101011101"), 12), 12)),
            11));
      END IF;
      land_5_lpi_dfm := land_5_sva_1 AND (NOT slc_1_svs);
      IF ( land_5_lpi_dfm = '1' ) THEN
        land_4_sva_1 := NOT (readindex(STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(Y_pix_1_sva(10
            DOWNTO 2)), 10) + CONV_UNSIGNED(SIGNED'("10100111"), 10), 10)), 9));
      END IF;
      land_4_lpi_dfm := land_4_sva_1 AND land_5_lpi_dfm;
      IF ( land_4_lpi_dfm = '1' ) THEN
        land_3_sva_1 := NOT (readindex(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(TO_STDLOGICVECTOR('1')
            & (NOT Y_pix_1_sva)) + CONV_SIGNED(UNSIGNED'("1010011101"), 12), 12)),
            11));
      END IF;
      C3443_12_dfmergedata_sg3_lpi_dfm := NOT(land_sva_1 AND land_1_lpi_dfm AND (NOT(land_3_sva_1
          AND land_4_lpi_dfm)));
      v_out_rsc_mgc_out_stdreg_d <= STD_LOGIC_VECTOR'("11") & TO_STDLOGICVECTOR(C3443_12_dfmergedata_sg3_lpi_dfm)
          & TO_STDLOGICVECTOR('1') & TO_STDLOGICVECTOR(C3443_12_dfmergedata_sg3_lpi_dfm)
          & STD_LOGIC_VECTOR'("111") & STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(C3443_12_dfmergedata_sg3_lpi_dfm,
          1),2)) & STD_LOGIC_VECTOR'("11");
      WAIT UNTIL clk'EVENT AND ( clk = '1' );
      EXIT main WHEN ( rst = '1' );
      -- C-Step 2 of Loop 'main'
    END LOOP main;

    C3443_12_dfmergedata_sg3_lpi_dfm := '0';
    land_3_sva_1 := '0';
    land_4_lpi_dfm := '0';
    land_4_sva_1 := '0';
    land_5_lpi_dfm := '0';
    land_5_sva_1 := '0';
    slc_1_svs := '0';
    land_sva_1 := '0';
    land_1_lpi_dfm := '0';
    land_1_sva_1 := '0';
    land_2_lpi_dfm := '0';
    land_2_sva_1 := '0';
    slc_svs := '0';
    Y_pix_1_sva := STD_LOGIC_VECTOR'("00000000000");
    X_pix_1_sva := STD_LOGIC_VECTOR'("00000000000");
    v_out_rsc_mgc_out_stdreg_d <= STD_LOGIC_VECTOR'("000000000000");
  END PROCESS core;

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


