// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2011a.126 Production Release
//  HLS Date:       Wed Aug  8 00:52:07 PDT 2012
// 
//  Generated by:   cm2715@EEWS104A-004
//  Generated date: Thu May 05 15:18:28 2016
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    Counter_core_fsm
//  FSM Module
// ------------------------------------------------------------------


module Counter_core_fsm (
  clk, rst, fsm_output, st_for_for_tr0, st_for_tr0
);
  input clk;
  input rst;
  output [2:0] fsm_output;
  reg [2:0] fsm_output;
  input st_for_for_tr0;
  input st_for_tr0;


  // FSM State Type Declaration for Counter_core_fsm_1
  parameter
    st_main = 2'd0,
    st_for_for = 2'd1,
    st_for = 2'd2,
    state_x = 2'b00;

  reg [1:0] state_var;
  reg [1:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : Counter_core_fsm_1
    case (state_var)
      st_main : begin
        fsm_output = 3'b1;
        state_var_NS = st_for_for;
      end
      st_for_for : begin
        fsm_output = 3'b10;
        if ( st_for_for_tr0 ) begin
          state_var_NS = st_for;
        end
        else begin
          state_var_NS = st_for_for;
        end
      end
      st_for : begin
        fsm_output = 3'b100;
        if ( st_for_tr0 ) begin
          state_var_NS = st_main;
        end
        else begin
          state_var_NS = st_for_for;
        end
      end
      default : begin
        fsm_output = 3'b000;
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
//  Design Unit:    Counter_core
// ------------------------------------------------------------------


module Counter_core (
  clk, rst, row_count_rsc_mgc_out_stdreg_d, col_count_rsc_mgc_out_stdreg_d
);
  input clk;
  input rst;
  output [4:0] row_count_rsc_mgc_out_stdreg_d;
  reg [4:0] row_count_rsc_mgc_out_stdreg_d;
  output [4:0] col_count_rsc_mgc_out_stdreg_d;
  reg [4:0] col_count_rsc_mgc_out_stdreg_d;


  // Interconnect Declarations
  wire [2:0] fsm_output;
  reg [5:0] for_i_1_sva_2;
  reg [5:0] for_for_j_1_sva_2;
  wire and_1_cse;
  wire [6:0] z_out;
  wire [7:0] nl_z_out;
  wire nor_3_cse;

  wire[5:0] mux_6_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [0:0] nl_Counter_core_fsm_inst_st_for_for_tr0;
  assign nl_Counter_core_fsm_inst_st_for_for_tr0 = z_out[6];
  wire [0:0] nl_Counter_core_fsm_inst_st_for_tr0;
  assign nl_Counter_core_fsm_inst_st_for_tr0 = z_out[6];
  Counter_core_fsm Counter_core_fsm_inst (
      .clk(clk),
      .rst(rst),
      .fsm_output(fsm_output),
      .st_for_for_tr0(nl_Counter_core_fsm_inst_st_for_for_tr0),
      .st_for_tr0(nl_Counter_core_fsm_inst_st_for_tr0)
    );
  assign and_1_cse = (~((~((~ (fsm_output[2])) | (z_out[6]))) | (fsm_output[0])))
      & ((~ (fsm_output[1])) | (z_out[6]));
  assign nor_3_cse = ~((fsm_output[0]) | (fsm_output[2]));
  always @(posedge clk) begin
    if ( rst ) begin
      col_count_rsc_mgc_out_stdreg_d <= 5'b0;
      row_count_rsc_mgc_out_stdreg_d <= 5'b0;
      for_i_1_sva_2 <= 6'b0;
      for_for_j_1_sva_2 <= 6'b0;
    end
    else begin
      col_count_rsc_mgc_out_stdreg_d <= MUX_v_5_2_2({((z_out[4:0]) & (signext_5_1(fsm_output[1])))
          , col_count_rsc_mgc_out_stdreg_d}, and_1_cse);
      row_count_rsc_mgc_out_stdreg_d <= MUX_v_5_2_2({((MUX_v_5_2_2({(z_out[4:0])
          , (for_i_1_sva_2[4:0])}, nor_3_cse)) & (signext_5_1(~ (fsm_output[0]))))
          , row_count_rsc_mgc_out_stdreg_d}, and_1_cse);
      for_i_1_sva_2 <= (MUX_v_6_2_2({(z_out[5:0]) , for_i_1_sva_2}, nor_3_cse)) &
          (signext_6_1(~ (fsm_output[0])));
      for_for_j_1_sva_2 <= (z_out[5:0]) & ({{5{nor_3_cse}}, nor_3_cse});
    end
  end
  assign mux_6_nl = MUX_v_6_2_2({for_for_j_1_sva_2 , for_i_1_sva_2}, fsm_output[2]);
  assign nl_z_out = conv_u2u_6_7(mux_6_nl) + 7'b1;
  assign z_out = nl_z_out[6:0];

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


  function [4:0] signext_5_1;
    input [0:0] vector;
  begin
    signext_5_1= {{4{vector[0]}}, vector};
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


  function [5:0] signext_6_1;
    input [0:0] vector;
  begin
    signext_6_1= {{5{vector[0]}}, vector};
  end
  endfunction


  function  [6:0] conv_u2u_6_7 ;
    input [5:0]  vector ;
  begin
    conv_u2u_6_7 = {1'b0, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    Counter
//  Generated from file(s):
//    5) $PROJECT_HOME/../../src/AccessCount.cpp
// ------------------------------------------------------------------


module Counter (
  row_count_rsc_z, col_count_rsc_z, clk, rst
);
  output [4:0] row_count_rsc_z;
  output [4:0] col_count_rsc_z;
  input clk;
  input rst;


  // Interconnect Declarations
  wire [4:0] row_count_rsc_mgc_out_stdreg_d;
  wire [4:0] col_count_rsc_mgc_out_stdreg_d;


  // Interconnect Declarations for Component Instantiations 
  mgc_out_stdreg #(.rscid(1),
  .width(5)) row_count_rsc_mgc_out_stdreg (
      .d(row_count_rsc_mgc_out_stdreg_d),
      .z(row_count_rsc_z)
    );
  mgc_out_stdreg #(.rscid(2),
  .width(5)) col_count_rsc_mgc_out_stdreg (
      .d(col_count_rsc_mgc_out_stdreg_d),
      .z(col_count_rsc_z)
    );
  Counter_core Counter_core_inst (
      .clk(clk),
      .rst(rst),
      .row_count_rsc_mgc_out_stdreg_d(row_count_rsc_mgc_out_stdreg_d),
      .col_count_rsc_mgc_out_stdreg_d(col_count_rsc_mgc_out_stdreg_d)
    );
endmodule



