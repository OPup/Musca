// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2011a.126 Production Release
//  HLS Date:       Wed Aug  8 00:52:07 PDT 2012
// 
//  Generated by:   kjr115@EEWS104A-022
//  Generated date: Mon May 09 17:47:24 2016
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    MazeArrayTester_core_fsm
//  FSM Module
// ------------------------------------------------------------------


module MazeArrayTester_core_fsm (
  clk, rst, fsm_output, st_main_tr0, st_if_for_for_1_tr0, st_if_for_tr0
);
  input clk;
  input rst;
  output [4:0] fsm_output;
  reg [4:0] fsm_output;
  input st_main_tr0;
  input st_if_for_for_1_tr0;
  input st_if_for_tr0;


  // FSM State Type Declaration for MazeArrayTester_core_fsm_1
  parameter
    st_core_rlp = 3'd0,
    st_main = 3'd1,
    st_if_for_for = 3'd2,
    st_if_for_for_1 = 3'd3,
    st_if_for = 3'd4,
    state_x = 3'b000;

  reg [2:0] state_var;
  reg [2:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : MazeArrayTester_core_fsm_1
    case (state_var)
      st_core_rlp : begin
        fsm_output = 5'b1;
        state_var_NS = st_main;
      end
      st_main : begin
        fsm_output = 5'b10;
        if ( st_main_tr0 ) begin
          state_var_NS = st_main;
        end
        else begin
          state_var_NS = st_if_for_for;
        end
      end
      st_if_for_for : begin
        fsm_output = 5'b100;
        state_var_NS = st_if_for_for_1;
      end
      st_if_for_for_1 : begin
        fsm_output = 5'b1000;
        if ( st_if_for_for_1_tr0 ) begin
          state_var_NS = st_if_for;
        end
        else begin
          state_var_NS = st_if_for_for;
        end
      end
      st_if_for : begin
        fsm_output = 5'b10000;
        if ( st_if_for_tr0 ) begin
          state_var_NS = st_main;
        end
        else begin
          state_var_NS = st_if_for_for;
        end
      end
      default : begin
        fsm_output = 5'b00000;
        state_var_NS = st_core_rlp;
      end
    endcase
  end

  always @(posedge clk) begin
    if ( rst ) begin
      state_var <= st_core_rlp;
    end
    else begin
      state_var <= state_var_NS;
    end
  end

endmodule

// ------------------------------------------------------------------
//  Design Unit:    MazeArrayTester_core
// ------------------------------------------------------------------


module MazeArrayTester_core (
  clk, rst, row_rsc_mgc_out_stdreg_d, col_rsc_mgc_out_stdreg_d, out_rsc_mgc_out_stdreg_d,
      write_rsc_mgc_out_stdreg_d
);
  input clk;
  input rst;
  output [5:0] row_rsc_mgc_out_stdreg_d;
  reg [5:0] row_rsc_mgc_out_stdreg_d;
  output [5:0] col_rsc_mgc_out_stdreg_d;
  reg [5:0] col_rsc_mgc_out_stdreg_d;
  output [3:0] out_rsc_mgc_out_stdreg_d;
  reg [3:0] out_rsc_mgc_out_stdreg_d;
  output write_rsc_mgc_out_stdreg_d;
  reg write_rsc_mgc_out_stdreg_d;


  // Interconnect Declarations
  wire [4:0] fsm_output;
  reg written_sva;
  reg [4:0] if_for_i_1_sva;
  reg [4:0] if_for_for_j_1_sva;
  reg [4:0] if_for_for_j_1_sva_1;
  reg if_for_for_slc_itm;
  wire and_5_cse;
  wire [5:0] z_out;
  wire [6:0] nl_z_out;
  wire [4:0] z_out_1;
  wire [5:0] nl_z_out_1;
  wire [4:0] and_14_cse;
  wire [4:0] and_13_cse;

  wire[4:0] mux_6_nl;
  wire[4:0] mux_7_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [0:0] nl_MazeArrayTester_core_fsm_inst_st_if_for_for_1_tr0;
  assign nl_MazeArrayTester_core_fsm_inst_st_if_for_for_1_tr0 = ~ if_for_for_slc_itm;
  wire [0:0] nl_MazeArrayTester_core_fsm_inst_st_if_for_tr0;
  assign nl_MazeArrayTester_core_fsm_inst_st_if_for_tr0 = ~ (z_out[5]);
  MazeArrayTester_core_fsm MazeArrayTester_core_fsm_inst (
      .clk(clk),
      .rst(rst),
      .fsm_output(fsm_output),
      .st_main_tr0(written_sva),
      .st_if_for_for_1_tr0(nl_MazeArrayTester_core_fsm_inst_st_if_for_for_1_tr0),
      .st_if_for_tr0(nl_MazeArrayTester_core_fsm_inst_st_if_for_tr0)
    );
  assign and_5_cse = (written_sva | (~ (fsm_output[1]))) & (~((fsm_output[4]) & (z_out[5])))
      & (~((fsm_output[3]) & if_for_for_slc_itm));
  assign and_13_cse = if_for_for_j_1_sva_1 & (signext_5_1(fsm_output[3]));
  assign mux_6_nl = MUX_v_5_2_2({z_out_1 , if_for_i_1_sva}, ~((fsm_output[1]) | (fsm_output[4])));
  assign and_14_cse = (mux_6_nl) & (signext_5_1(~ (fsm_output[1])));
  always @(posedge clk) begin
    if ( rst ) begin
      write_rsc_mgc_out_stdreg_d <= 1'b0;
      out_rsc_mgc_out_stdreg_d <= 4'b0;
      col_rsc_mgc_out_stdreg_d <= 6'b0;
      row_rsc_mgc_out_stdreg_d <= 6'b0;
      written_sva <= 1'b0;
      if_for_i_1_sva <= 5'b0;
      if_for_for_j_1_sva <= 5'b0;
      if_for_for_slc_itm <= 1'b0;
      if_for_for_j_1_sva_1 <= 5'b0;
    end
    else begin
      write_rsc_mgc_out_stdreg_d <= (write_rsc_mgc_out_stdreg_d & (~((written_sva
          & (fsm_output[1])) | ((fsm_output[4]) & (~ (z_out[5])))))) | (fsm_output[0]);
      out_rsc_mgc_out_stdreg_d <= MUX_v_4_2_2({out_rsc_mgc_out_stdreg_d , ({3'b0
          , ((~((~((if_for_i_1_sva[4]) & (if_for_i_1_sva[3]) & (if_for_i_1_sva[1])
          & (~((if_for_i_1_sva[2]) | (if_for_i_1_sva[0]))))) & ((if_for_i_1_sva[4])
          | (if_for_i_1_sva[3]) | (if_for_i_1_sva[2]) | (if_for_i_1_sva[1]) | (if_for_i_1_sva[0]))))
          | (~((~((if_for_for_j_1_sva[4]) & (if_for_for_j_1_sva[3]) & (if_for_for_j_1_sva[1])
          & (~((if_for_for_j_1_sva[2]) | (if_for_for_j_1_sva[0]))))) & ((if_for_for_j_1_sva[4])
          | (if_for_for_j_1_sva[3]) | (if_for_for_j_1_sva[2]) | (if_for_for_j_1_sva[1])
          | (if_for_for_j_1_sva[0])))))})}, fsm_output[2]);
      col_rsc_mgc_out_stdreg_d <= MUX_v_6_2_2({({1'b0 , and_13_cse}) , col_rsc_mgc_out_stdreg_d},
          and_5_cse);
      row_rsc_mgc_out_stdreg_d <= MUX_v_6_2_2({({1'b0 , and_14_cse}) , row_rsc_mgc_out_stdreg_d},
          and_5_cse);
      written_sva <= (fsm_output[1]) | (fsm_output[4]);
      if_for_i_1_sva <= and_14_cse;
      if_for_for_j_1_sva <= and_13_cse;
      if_for_for_slc_itm <= z_out[5];
      if_for_for_j_1_sva_1 <= z_out_1;
    end
  end
  assign nl_z_out = conv_u2u_5_6(z_out_1) + 6'b100101;
  assign z_out = nl_z_out[5:0];
  assign mux_7_nl = MUX_v_5_2_2({if_for_for_j_1_sva , if_for_i_1_sva}, fsm_output[4]);
  assign nl_z_out_1 = (mux_7_nl) + 5'b1;
  assign z_out_1 = nl_z_out_1[4:0];

  function [4:0] signext_5_1;
    input [0:0] vector;
  begin
    signext_5_1= {{4{vector[0]}}, vector};
  end
  endfunction


  function [4:0] MUX_v_5_2_2;
    input [9:0] inputs;
    input [0:0] sel;
    reg [4:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[9:5];
      end
      1'b1 : begin
        result = inputs[4:0];
      end
      default : begin
        result = inputs[9:5];
      end
    endcase
    MUX_v_5_2_2 = result;
  end
  endfunction


  function [3:0] MUX_v_4_2_2;
    input [7:0] inputs;
    input [0:0] sel;
    reg [3:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[7:4];
      end
      1'b1 : begin
        result = inputs[3:0];
      end
      default : begin
        result = inputs[7:4];
      end
    endcase
    MUX_v_4_2_2 = result;
  end
  endfunction


  function [5:0] MUX_v_6_2_2;
    input [11:0] inputs;
    input [0:0] sel;
    reg [5:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[11:6];
      end
      1'b1 : begin
        result = inputs[5:0];
      end
      default : begin
        result = inputs[11:6];
      end
    endcase
    MUX_v_6_2_2 = result;
  end
  endfunction


  function  [5:0] conv_u2u_5_6 ;
    input [4:0]  vector ;
  begin
    conv_u2u_5_6 = {1'b0, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    MazeArrayTester
//  Generated from file(s):
//    2) $PROJECT_HOME/../../src/MazeArrayTester.cpp
// ------------------------------------------------------------------


module MazeArrayTester (
  row_rsc_z, col_rsc_z, out_rsc_z, write_rsc_z, clk, rst
);
  output [5:0] row_rsc_z;
  output [5:0] col_rsc_z;
  output [3:0] out_rsc_z;
  output write_rsc_z;
  input clk;
  input rst;


  // Interconnect Declarations
  wire [5:0] row_rsc_mgc_out_stdreg_d;
  wire [5:0] col_rsc_mgc_out_stdreg_d;
  wire [3:0] out_rsc_mgc_out_stdreg_d;
  wire write_rsc_mgc_out_stdreg_d;


  // Interconnect Declarations for Component Instantiations 
  mgc_out_stdreg #(.rscid(1),
  .width(6)) row_rsc_mgc_out_stdreg (
      .d(row_rsc_mgc_out_stdreg_d),
      .z(row_rsc_z)
    );
  mgc_out_stdreg #(.rscid(2),
  .width(6)) col_rsc_mgc_out_stdreg (
      .d(col_rsc_mgc_out_stdreg_d),
      .z(col_rsc_z)
    );
  mgc_out_stdreg #(.rscid(3),
  .width(4)) out_rsc_mgc_out_stdreg (
      .d(out_rsc_mgc_out_stdreg_d),
      .z(out_rsc_z)
    );
  mgc_out_stdreg #(.rscid(4),
  .width(1)) write_rsc_mgc_out_stdreg (
      .d(write_rsc_mgc_out_stdreg_d),
      .z(write_rsc_z)
    );
  MazeArrayTester_core MazeArrayTester_core_inst (
      .clk(clk),
      .rst(rst),
      .row_rsc_mgc_out_stdreg_d(row_rsc_mgc_out_stdreg_d),
      .col_rsc_mgc_out_stdreg_d(col_rsc_mgc_out_stdreg_d),
      .out_rsc_mgc_out_stdreg_d(out_rsc_mgc_out_stdreg_d),
      .write_rsc_mgc_out_stdreg_d(write_rsc_mgc_out_stdreg_d)
    );
endmodule



