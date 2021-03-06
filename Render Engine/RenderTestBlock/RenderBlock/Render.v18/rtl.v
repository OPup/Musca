// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2011a.126 Production Release
//  HLS Date:       Wed Aug  8 00:52:07 PDT 2012
// 
//  Generated by:   kjr115@EEWS104A-009
//  Generated date: Tue May 03 15:31:16 2016
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    Render_core_fsm
//  FSM Module
// ------------------------------------------------------------------


module Render_core_fsm (
  clk, rst, fsm_output, st_main_1_for_1_tr0
);
  input clk;
  input rst;
  output [5:0] fsm_output;
  reg [5:0] fsm_output;
  input st_main_1_for_1_tr0;


  // FSM State Type Declaration for Render_core_fsm_1
  parameter
    st_main = 3'd0,
    st_main_1_for = 3'd1,
    st_main_1_for_1 = 3'd2,
    st_main_1 = 3'd3,
    st_main_2_for = 3'd4,
    st_main_2_for_1 = 3'd5,
    state_x = 3'b000;

  reg [2:0] state_var;
  reg [2:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : Render_core_fsm_1
    case (state_var)
      st_main : begin
        fsm_output = 6'b1;
        state_var_NS = st_main_1_for;
      end
      st_main_1_for : begin
        fsm_output = 6'b10;
        state_var_NS = st_main_1_for_1;
      end
      st_main_1_for_1 : begin
        fsm_output = 6'b100;
        if ( st_main_1_for_1_tr0 ) begin
          state_var_NS = st_main_1;
        end
        else begin
          state_var_NS = st_main_1_for;
        end
      end
      st_main_1 : begin
        fsm_output = 6'b1000;
        state_var_NS = st_main_2_for;
      end
      st_main_2_for : begin
        fsm_output = 6'b10000;
        state_var_NS = st_main_2_for_1;
      end
      st_main_2_for_1 : begin
        fsm_output = 6'b100000;
        if ( st_main_1_for_1_tr0 ) begin
          state_var_NS = st_main;
        end
        else begin
          state_var_NS = st_main_2_for;
        end
      end
      default : begin
        fsm_output = 6'b000000;
        state_var_NS = st_main;
      end
    endcase
  end

  always @(posedge clk) begin
    if ( rst ) begin
      state_var <= st_main;
    end
    else begin
      state_var <= state_var_NS;
    end
  end

endmodule

// ------------------------------------------------------------------
//  Design Unit:    Render_core
// ------------------------------------------------------------------


module Render_core (
  clk, rst, v_out_rsc_mgc_out_stdreg_d
);
  input clk;
  input rst;
  output [11:0] v_out_rsc_mgc_out_stdreg_d;
  reg [11:0] v_out_rsc_mgc_out_stdreg_d;


  // Interconnect Declarations
  wire [5:0] fsm_output;
  reg [20:0] for_i_2_sva;
  reg [20:0] for_i_2_sva_1;
  reg [20:0] for_i_1_sva;
  wire [3:0] z_out;
  wire [4:0] nl_z_out;
  wire [20:0] z_out_2;
  wire [21:0] nl_z_out_2;
  reg reg_main_1_for_slc_itm_cse;

  wire[3:0] mux_nl;
  wire[20:0] mux_3_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [0:0] nl_Render_core_fsm_inst_st_main_1_for_1_tr0;
  assign nl_Render_core_fsm_inst_st_main_1_for_1_tr0 = ~ reg_main_1_for_slc_itm_cse;
  Render_core_fsm Render_core_fsm_inst (
      .clk(clk),
      .rst(rst),
      .fsm_output(fsm_output),
      .st_main_1_for_1_tr0(nl_Render_core_fsm_inst_st_main_1_for_1_tr0)
    );
  always @(posedge clk) begin
    if ( rst ) begin
      for_i_2_sva <= 21'b0;
      v_out_rsc_mgc_out_stdreg_d <= 12'b0;
      reg_main_1_for_slc_itm_cse <= 1'b0;
      for_i_2_sva_1 <= 21'b0;
      for_i_1_sva <= 21'b0;
    end
    else begin
      for_i_2_sva <= for_i_2_sva_1 & (signext_21_1(fsm_output[2]));
      v_out_rsc_mgc_out_stdreg_d <= MUX1HOT_v_12_3_2({(signext_12_1(z_out[3])) ,
          (signext_12_1(z_out[3])) , v_out_rsc_mgc_out_stdreg_d}, {(fsm_output[1])
          , (fsm_output[4]) , (~((fsm_output[4]) | (fsm_output[1])))});
      reg_main_1_for_slc_itm_cse <= readslicef_4_1_3((conv_u2s_3_4(z_out_2[20:18])
          + 4'b1011));
      for_i_2_sva_1 <= z_out_2;
      for_i_1_sva <= for_i_2_sva_1 & (signext_21_1(fsm_output[5]));
    end
  end
  assign mux_nl = MUX_v_4_2_2({(for_i_2_sva[20:17]) , (for_i_1_sva[20:17])}, fsm_output[4]);
  assign nl_z_out = (mux_nl) + 4'b1011;
  assign z_out = nl_z_out[3:0];
  assign mux_3_nl = MUX_v_21_2_2({for_i_2_sva , for_i_1_sva}, fsm_output[4]);
  assign nl_z_out_2 = (mux_3_nl) + 21'b1;
  assign z_out_2 = nl_z_out_2[20:0];

  function [20:0] signext_21_1;
    input [0:0] vector;
  begin
    signext_21_1= {{20{vector[0]}}, vector};
  end
  endfunction


  function [11:0] MUX1HOT_v_12_3_2;
    input [35:0] inputs;
    input [2:0] sel;
    reg [11:0] result;
    integer i;
  begin
    result = inputs[0+:12] & {12{sel[0]}};
    for( i = 1; i < 3; i = i + 1 )
      result = result | (inputs[i*12+:12] & {12{sel[i]}});
    MUX1HOT_v_12_3_2 = result;
  end
  endfunction


  function [11:0] signext_12_1;
    input [0:0] vector;
  begin
    signext_12_1= {{11{vector[0]}}, vector};
  end
  endfunction


  function [0:0] readslicef_4_1_3;
    input [3:0] vector;
    reg [3:0] tmp;
  begin
    tmp = vector >> 3;
    readslicef_4_1_3 = tmp[0:0];
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


  function [20:0] MUX_v_21_2_2;
    input [41:0] inputs;
    input [0:0] sel;
    reg [20:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[41:21];
      end
      1'b1 : begin
        result = inputs[20:0];
      end
      default : begin
        result = inputs[41:21];
      end
    endcase
    MUX_v_21_2_2 = result;
  end
  endfunction


  function signed [3:0] conv_u2s_3_4 ;
    input [2:0]  vector ;
  begin
    conv_u2s_3_4 = {1'b0, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    Render
//  Generated from file(s):
//    2) $PROJECT_HOME/src/Render.cpp
// ------------------------------------------------------------------


module Render (
  v_out_rsc_z, clk, rst
);
  output [11:0] v_out_rsc_z;
  input clk;
  input rst;


  // Interconnect Declarations
  wire [11:0] v_out_rsc_mgc_out_stdreg_d;


  // Interconnect Declarations for Component Instantiations 
  mgc_out_stdreg #(.rscid(1),
  .width(12)) v_out_rsc_mgc_out_stdreg (
      .d(v_out_rsc_mgc_out_stdreg_d),
      .z(v_out_rsc_z)
    );
  Render_core Render_core_inst (
      .clk(clk),
      .rst(rst),
      .v_out_rsc_mgc_out_stdreg_d(v_out_rsc_mgc_out_stdreg_d)
    );
endmodule



