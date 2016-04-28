// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2011a.126 Production Release
//  HLS Date:       Wed Aug  8 00:52:07 PDT 2012
// 
//  Generated by:   oh1015@EEWS104A-005
//  Generated date: Tue Apr 26 15:37:29 2016
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    RGB_HSV_core
// ------------------------------------------------------------------


module RGB_HSV_core (
  clk, rst, R_IN_rsc_mgc_in_wire_d, G_IN_rsc_mgc_in_wire_d, B_IN_rsc_mgc_in_wire_d,
      H_OUT_rsc_mgc_out_stdreg_d, S_OUT_rsc_mgc_out_stdreg_d, V_OUT_rsc_mgc_out_stdreg_d,
      div_mgc_div_a, div_mgc_div_b, div_mgc_div_z, div_mgc_div_1_a, div_mgc_div_1_b,
      div_mgc_div_1_z
);
  input clk;
  input rst;
  input [9:0] R_IN_rsc_mgc_in_wire_d;
  input [9:0] G_IN_rsc_mgc_in_wire_d;
  input [9:0] B_IN_rsc_mgc_in_wire_d;
  output [9:0] H_OUT_rsc_mgc_out_stdreg_d;
  reg [9:0] H_OUT_rsc_mgc_out_stdreg_d;
  output [9:0] S_OUT_rsc_mgc_out_stdreg_d;
  reg [9:0] S_OUT_rsc_mgc_out_stdreg_d;
  output [9:0] V_OUT_rsc_mgc_out_stdreg_d;
  reg [9:0] V_OUT_rsc_mgc_out_stdreg_d;
  output [9:0] div_mgc_div_a;
  reg [9:0] div_mgc_div_a;
  output [9:0] div_mgc_div_b;
  reg [9:0] div_mgc_div_b;
  input [9:0] div_mgc_div_z;
  output [9:0] div_mgc_div_1_a;
  reg [9:0] div_mgc_div_1_a;
  output [9:0] div_mgc_div_1_b;
  reg [9:0] div_mgc_div_1_b;
  input [9:0] div_mgc_div_1_z;


  // Interconnect Declarations
  wire [9:0] if_if_1_mux1h_tmp;
  wire or_dcpl_18;
  wire or_dcpl_20;
  wire or_dcpl_22;
  wire or_dcpl_24;
  wire and_dcpl_34;
  wire or_dcpl_57;
  reg if_else_slc_svs;
  reg if_if_1_if_1_div_2cyc;
  reg [9:0] s_sva_1_duc;
  reg [9:0] if_if_1_slc_1_tmp_mut;
  reg [9:0] max_lpi_dfm_5_mut;
  reg [9:0] if_if_1_slc_1_tmp_mut_1;
  reg [9:0] max_lpi_dfm_5_mut_1;
  reg [9:0] max_lpi_dfm_9;
  reg if_if_1_or_1_itm_1;
  reg if_if_1_or_1_itm_2;
  reg slc_itm_1;
  reg if_slc_1_itm_1;
  reg [9:0] max_lpi_dfm_5_st_1;
  reg if_if_1_if_1_div_2cyc_st_1;
  reg slc_itm_2;
  reg if_slc_1_itm_2;
  reg if_if_1_if_1_div_2cyc_st_2;
  reg main_stage_0_2;
  reg main_stage_0_3;
  wire or_15_cse;
  wire or_37_cse;
  wire and_33_cse;
  wire or_61_cse;
  wire and_59_cse;
  wire or_67_cse;
  wire or_72_cse;
  wire [11:0] if_if_1_acc_2_itm;
  wire [12:0] nl_if_if_1_acc_2_itm;
  wire [11:0] if_acc_itm;
  wire [12:0] nl_if_acc_itm;
  wire [11:0] if_if_acc_itm;
  wire [12:0] nl_if_if_acc_itm;
  wire if_else_and_tmp;
  wire if_if_1_nor_1_m1c;
  wire if_if_1_nor_tmp;
  wire [11:0] if_else_if_acc_1_itm;
  wire [12:0] nl_if_else_if_acc_1_itm;
  wire [10:0] if_if_1_acc_itm;
  wire [11:0] nl_if_if_1_acc_itm;

  wire[9:0] if_if_1_mux1h_1_nl;
  wire[0:0] mux_8_nl;

  // Interconnect Declarations for Component Instantiations 
  assign or_37_cse = or_dcpl_24 | or_dcpl_22 | or_dcpl_20 | or_dcpl_18;
  assign and_33_cse = (~((max_lpi_dfm_9[9]) | (max_lpi_dfm_9[8]) | (max_lpi_dfm_9[7])))
      & (~((max_lpi_dfm_9[6]) | (max_lpi_dfm_9[5]))) & (~((max_lpi_dfm_9[4]) | (max_lpi_dfm_9[3])
      | (max_lpi_dfm_9[2]))) & (~((max_lpi_dfm_9[1]) | (max_lpi_dfm_9[0])));
  assign and_59_cse = (~((if_if_1_mux1h_tmp[0]) | (if_if_1_mux1h_tmp[1]) | (if_if_1_mux1h_tmp[2])))
      & (~((if_if_1_mux1h_tmp[3]) | (if_if_1_mux1h_tmp[4]))) & (~((if_if_1_mux1h_tmp[5])
      | (if_if_1_mux1h_tmp[6]) | (if_if_1_mux1h_tmp[7]))) & (~((if_if_1_mux1h_tmp[8])
      | (if_if_1_mux1h_tmp[9])));
  assign or_61_cse = and_59_cse | or_dcpl_57 | (~ if_if_1_if_1_div_2cyc);
  assign or_67_cse = and_59_cse | or_dcpl_57 | if_if_1_if_1_div_2cyc;
  assign or_72_cse = and_59_cse | or_dcpl_57;
  assign nl_if_if_1_acc_2_itm = ({1'b1 , R_IN_rsc_mgc_in_wire_d , 1'b1}) + conv_u2u_11_12({(~
      G_IN_rsc_mgc_in_wire_d) , 1'b1});
  assign if_if_1_acc_2_itm = nl_if_if_1_acc_2_itm[11:0];
  assign nl_if_acc_itm = ({1'b1 , G_IN_rsc_mgc_in_wire_d , 1'b1}) + conv_u2u_11_12({(~
      R_IN_rsc_mgc_in_wire_d) , 1'b1});
  assign if_acc_itm = nl_if_acc_itm[11:0];
  assign nl_if_else_if_acc_1_itm = ({1'b1 , R_IN_rsc_mgc_in_wire_d , 1'b1}) + conv_u2u_11_12({(~
      B_IN_rsc_mgc_in_wire_d) , 1'b1});
  assign if_else_if_acc_1_itm = nl_if_else_if_acc_1_itm[11:0];
  assign nl_if_if_acc_itm = ({1'b1 , B_IN_rsc_mgc_in_wire_d , 1'b1}) + conv_u2u_11_12({(~
      R_IN_rsc_mgc_in_wire_d) , 1'b1});
  assign if_if_acc_itm = nl_if_if_acc_itm[11:0];
  assign if_if_1_mux1h_tmp = MUX1HOT_v_10_3_2({B_IN_rsc_mgc_in_wire_d , G_IN_rsc_mgc_in_wire_d
      , R_IN_rsc_mgc_in_wire_d}, {(((~ if_else_and_tmp) & if_if_1_nor_1_m1c) | if_if_1_nor_tmp)
      , (if_else_and_tmp & if_if_1_nor_1_m1c) , ((if_if_acc_itm[11]) & (~ if_if_1_nor_tmp))});
  assign if_if_1_mux1h_1_nl = MUX1HOT_v_10_3_2({G_IN_rsc_mgc_in_wire_d , B_IN_rsc_mgc_in_wire_d
      , R_IN_rsc_mgc_in_wire_d}, {(~((if_if_acc_itm[11]) | (if_else_if_acc_1_itm[11])))
      , ((if_if_acc_itm[11]) & (~ (if_else_if_acc_1_itm[11]))) , (if_else_if_acc_1_itm[11])});
  assign nl_if_if_1_acc_itm = ({if_if_1_mux1h_tmp , 1'b1}) + ({(~ (if_if_1_mux1h_1_nl))
      , 1'b1});
  assign if_if_1_acc_itm = nl_if_if_1_acc_itm[10:0];
  assign mux_8_nl = MUX_s_1_2_2({(if_else_if_acc_1_itm[11]) , if_else_slc_svs}, if_if_acc_itm[11]);
  assign if_else_and_tmp = (readslicef_12_1_11((({1'b1 , B_IN_rsc_mgc_in_wire_d ,
      1'b1}) + conv_u2u_11_12({(~ G_IN_rsc_mgc_in_wire_d) , 1'b1})))) & (~ (mux_8_nl));
  assign if_if_1_nor_1_m1c = ~((if_if_acc_itm[11]) | if_if_1_nor_tmp);
  assign if_if_1_nor_tmp = ~((readslicef_12_1_11((({1'b1 , G_IN_rsc_mgc_in_wire_d
      , 1'b1}) + conv_u2u_11_12({(~ B_IN_rsc_mgc_in_wire_d) , 1'b1})))) | (if_if_acc_itm[11])
      | (if_else_if_acc_1_itm[11]));
  assign or_15_cse = ~(if_slc_1_itm_2 & slc_itm_2 & main_stage_0_3);
  assign or_dcpl_18 = (max_lpi_dfm_9[1]) | (max_lpi_dfm_9[0]);
  assign or_dcpl_20 = (max_lpi_dfm_9[4]) | (max_lpi_dfm_9[3]) | (max_lpi_dfm_9[2]);
  assign or_dcpl_22 = (max_lpi_dfm_9[6]) | (max_lpi_dfm_9[5]);
  assign or_dcpl_24 = (max_lpi_dfm_9[9]) | (max_lpi_dfm_9[8]) | (max_lpi_dfm_9[7]);
  assign and_dcpl_34 = if_slc_1_itm_2 & slc_itm_2;
  assign or_dcpl_57 = ~((if_acc_itm[11]) & (if_if_1_acc_2_itm[11]));
  always @(posedge clk) begin
    if ( rst ) begin
      V_OUT_rsc_mgc_out_stdreg_d <= 10'b0;
      S_OUT_rsc_mgc_out_stdreg_d <= 10'b0;
      H_OUT_rsc_mgc_out_stdreg_d <= 10'b0;
      s_sva_1_duc <= 10'b0;
      if_if_1_if_1_div_2cyc_st_2 <= 1'b0;
      max_lpi_dfm_9 <= 10'b0;
      if_if_1_or_1_itm_2 <= 1'b0;
      if_slc_1_itm_2 <= 1'b0;
      slc_itm_2 <= 1'b0;
      div_mgc_div_1_b <= 10'b0;
      div_mgc_div_1_a <= 10'b0;
      div_mgc_div_b <= 10'b0;
      div_mgc_div_a <= 10'b0;
      if_if_1_if_1_div_2cyc_st_1 <= 1'b0;
      max_lpi_dfm_5_st_1 <= 10'b0;
      if_slc_1_itm_1 <= 1'b0;
      slc_itm_1 <= 1'b0;
      if_else_slc_svs <= 1'b0;
      if_if_1_if_1_div_2cyc <= 1'b0;
      main_stage_0_2 <= 1'b0;
      main_stage_0_3 <= 1'b0;
      max_lpi_dfm_5_mut_1 <= 10'b0;
      if_if_1_slc_1_tmp_mut_1 <= 10'b0;
      max_lpi_dfm_5_mut <= 10'b0;
      if_if_1_slc_1_tmp_mut <= 10'b0;
      if_if_1_or_1_itm_1 <= 1'b0;
    end
    else begin
      V_OUT_rsc_mgc_out_stdreg_d <= MUX_v_10_2_2({max_lpi_dfm_9 , V_OUT_rsc_mgc_out_stdreg_d},
          or_15_cse);
      S_OUT_rsc_mgc_out_stdreg_d <= MUX_v_10_2_2({((MUX1HOT_v_10_3_2({div_mgc_div_1_z
          , div_mgc_div_z , s_sva_1_duc}, {(~((~(or_dcpl_24 | or_dcpl_22 | or_dcpl_20
          | or_dcpl_18)) | if_if_1_if_1_div_2cyc_st_2)) , (or_37_cse & if_if_1_if_1_div_2cyc_st_2)
          , and_33_cse})) & ({{9{if_if_1_or_1_itm_2}}, if_if_1_or_1_itm_2})) , S_OUT_rsc_mgc_out_stdreg_d},
          or_15_cse);
      H_OUT_rsc_mgc_out_stdreg_d <= MUX_v_10_2_2({({2'b0 , ({{3{if_if_1_or_1_itm_2}},
          if_if_1_or_1_itm_2}) , 4'b0}) , H_OUT_rsc_mgc_out_stdreg_d}, or_15_cse);
      s_sva_1_duc <= MUX1HOT_v_10_3_2({div_mgc_div_1_z , div_mgc_div_z , s_sva_1_duc},
          {(or_37_cse & and_dcpl_34 & main_stage_0_3 & (~ if_if_1_if_1_div_2cyc_st_2))
          , (or_37_cse & and_dcpl_34 & main_stage_0_3 & if_if_1_if_1_div_2cyc_st_2)
          , (and_33_cse | or_15_cse)});
      if_if_1_if_1_div_2cyc_st_2 <= if_if_1_if_1_div_2cyc_st_1;
      max_lpi_dfm_9 <= max_lpi_dfm_5_st_1;
      if_if_1_or_1_itm_2 <= if_if_1_or_1_itm_1;
      if_slc_1_itm_2 <= if_slc_1_itm_1;
      slc_itm_2 <= slc_itm_1;
      div_mgc_div_1_b <= MUX_v_10_2_2({if_if_1_mux1h_tmp , max_lpi_dfm_5_mut_1},
          or_61_cse);
      div_mgc_div_1_a <= MUX_v_10_2_2({(if_if_1_acc_itm[10:1]) , if_if_1_slc_1_tmp_mut_1},
          or_61_cse);
      div_mgc_div_b <= MUX_v_10_2_2({if_if_1_mux1h_tmp , max_lpi_dfm_5_mut}, or_67_cse);
      div_mgc_div_a <= MUX_v_10_2_2({(if_if_1_acc_itm[10:1]) , if_if_1_slc_1_tmp_mut},
          or_67_cse);
      if_if_1_if_1_div_2cyc_st_1 <= MUX_s_1_2_2({(~ if_if_1_if_1_div_2cyc) , if_if_1_if_1_div_2cyc_st_1},
          or_72_cse);
      max_lpi_dfm_5_st_1 <= if_if_1_mux1h_tmp;
      if_slc_1_itm_1 <= if_if_1_acc_2_itm[11];
      slc_itm_1 <= if_acc_itm[11];
      if_else_slc_svs <= MUX_s_1_2_2({(if_else_if_acc_1_itm[11]) , if_else_slc_svs},
          (~ (if_acc_itm[11])) | (if_if_acc_itm[11]));
      if_if_1_if_1_div_2cyc <= MUX_s_1_2_2({(~ if_if_1_if_1_div_2cyc) , if_if_1_if_1_div_2cyc},
          or_72_cse);
      main_stage_0_2 <= 1'b1;
      main_stage_0_3 <= main_stage_0_2;
      max_lpi_dfm_5_mut_1 <= MUX_v_10_2_2({if_if_1_mux1h_tmp , max_lpi_dfm_5_mut_1},
          or_72_cse);
      if_if_1_slc_1_tmp_mut_1 <= MUX_v_10_2_2({(if_if_1_acc_itm[10:1]) , if_if_1_slc_1_tmp_mut_1},
          or_72_cse);
      max_lpi_dfm_5_mut <= MUX_v_10_2_2({if_if_1_mux1h_tmp , max_lpi_dfm_5_mut},
          or_72_cse);
      if_if_1_slc_1_tmp_mut <= MUX_v_10_2_2({(if_if_1_acc_itm[10:1]) , if_if_1_slc_1_tmp_mut},
          or_72_cse);
      if_if_1_or_1_itm_1 <= (if_if_1_mux1h_tmp[9]) | (if_if_1_mux1h_tmp[8]) | (if_if_1_mux1h_tmp[7])
          | (if_if_1_mux1h_tmp[6]) | (if_if_1_mux1h_tmp[5]) | (if_if_1_mux1h_tmp[4])
          | (if_if_1_mux1h_tmp[3]) | (if_if_1_mux1h_tmp[2]) | (if_if_1_mux1h_tmp[1])
          | (if_if_1_mux1h_tmp[0]);
    end
  end

  function [9:0] MUX1HOT_v_10_3_2;
    input [29:0] inputs;
    input [2:0] sel;
    reg [9:0] result;
    integer i;
  begin
    result = inputs[0+:10] & {10{sel[0]}};
    for( i = 1; i < 3; i = i + 1 )
      result = result | (inputs[i*10+:10] & {10{sel[i]}});
    MUX1HOT_v_10_3_2 = result;
  end
  endfunction


  function [0:0] MUX_s_1_2_2;
    input [1:0] inputs;
    input [0:0] sel;
    reg [0:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[1:1];
      end
      1'b1 : begin
        result = inputs[0:0];
      end
      default : begin
        result = inputs[1:1];
      end
    endcase
    MUX_s_1_2_2 = result;
  end
  endfunction


  function [0:0] readslicef_12_1_11;
    input [11:0] vector;
    reg [11:0] tmp;
  begin
    tmp = vector >> 11;
    readslicef_12_1_11 = tmp[0:0];
  end
  endfunction


  function [9:0] MUX_v_10_2_2;
    input [19:0] inputs;
    input [0:0] sel;
    reg [9:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[19:10];
      end
      1'b1 : begin
        result = inputs[9:0];
      end
      default : begin
        result = inputs[19:10];
      end
    endcase
    MUX_v_10_2_2 = result;
  end
  endfunction


  function  [11:0] conv_u2u_11_12 ;
    input [10:0]  vector ;
  begin
    conv_u2u_11_12 = {1'b0, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    RGB_HSV
//  Generated from file(s):
//    9) $PROJECT_HOME/RGBHSV.cpp
// ------------------------------------------------------------------


module RGB_HSV (
  R_IN_rsc_z, G_IN_rsc_z, B_IN_rsc_z, H_OUT_rsc_z, S_OUT_rsc_z, V_OUT_rsc_z, clk,
      rst
);
  input [9:0] R_IN_rsc_z;
  input [9:0] G_IN_rsc_z;
  input [9:0] B_IN_rsc_z;
  output [9:0] H_OUT_rsc_z;
  output [9:0] S_OUT_rsc_z;
  output [9:0] V_OUT_rsc_z;
  input clk;
  input rst;


  // Interconnect Declarations
  wire [9:0] R_IN_rsc_mgc_in_wire_d;
  wire [9:0] G_IN_rsc_mgc_in_wire_d;
  wire [9:0] B_IN_rsc_mgc_in_wire_d;
  wire [9:0] H_OUT_rsc_mgc_out_stdreg_d;
  wire [9:0] S_OUT_rsc_mgc_out_stdreg_d;
  wire [9:0] V_OUT_rsc_mgc_out_stdreg_d;
  wire [9:0] div_mgc_div_a;
  wire [9:0] div_mgc_div_b;
  wire [9:0] div_mgc_div_z;
  wire [9:0] div_mgc_div_1_a;
  wire [9:0] div_mgc_div_1_b;
  wire [9:0] div_mgc_div_1_z;


  // Interconnect Declarations for Component Instantiations 
  mgc_in_wire #(.rscid(1),
  .width(10)) R_IN_rsc_mgc_in_wire (
      .d(R_IN_rsc_mgc_in_wire_d),
      .z(R_IN_rsc_z)
    );
  mgc_in_wire #(.rscid(2),
  .width(10)) G_IN_rsc_mgc_in_wire (
      .d(G_IN_rsc_mgc_in_wire_d),
      .z(G_IN_rsc_z)
    );
  mgc_in_wire #(.rscid(3),
  .width(10)) B_IN_rsc_mgc_in_wire (
      .d(B_IN_rsc_mgc_in_wire_d),
      .z(B_IN_rsc_z)
    );
  mgc_out_stdreg #(.rscid(4),
  .width(10)) H_OUT_rsc_mgc_out_stdreg (
      .d(H_OUT_rsc_mgc_out_stdreg_d),
      .z(H_OUT_rsc_z)
    );
  mgc_out_stdreg #(.rscid(5),
  .width(10)) S_OUT_rsc_mgc_out_stdreg (
      .d(S_OUT_rsc_mgc_out_stdreg_d),
      .z(S_OUT_rsc_z)
    );
  mgc_out_stdreg #(.rscid(6),
  .width(10)) V_OUT_rsc_mgc_out_stdreg (
      .d(V_OUT_rsc_mgc_out_stdreg_d),
      .z(V_OUT_rsc_z)
    );
  mgc_div #(.width_a(10),
  .width_b(10),
  .signd(1)) div_mgc_div (
      .a(div_mgc_div_a),
      .b(div_mgc_div_b),
      .z(div_mgc_div_z)
    );
  mgc_div #(.width_a(10),
  .width_b(10),
  .signd(1)) div_mgc_div_1 (
      .a(div_mgc_div_1_a),
      .b(div_mgc_div_1_b),
      .z(div_mgc_div_1_z)
    );
  RGB_HSV_core RGB_HSV_core_inst (
      .clk(clk),
      .rst(rst),
      .R_IN_rsc_mgc_in_wire_d(R_IN_rsc_mgc_in_wire_d),
      .G_IN_rsc_mgc_in_wire_d(G_IN_rsc_mgc_in_wire_d),
      .B_IN_rsc_mgc_in_wire_d(B_IN_rsc_mgc_in_wire_d),
      .H_OUT_rsc_mgc_out_stdreg_d(H_OUT_rsc_mgc_out_stdreg_d),
      .S_OUT_rsc_mgc_out_stdreg_d(S_OUT_rsc_mgc_out_stdreg_d),
      .V_OUT_rsc_mgc_out_stdreg_d(V_OUT_rsc_mgc_out_stdreg_d),
      .div_mgc_div_a(div_mgc_div_a),
      .div_mgc_div_b(div_mgc_div_b),
      .div_mgc_div_z(div_mgc_div_z),
      .div_mgc_div_1_a(div_mgc_div_1_a),
      .div_mgc_div_1_b(div_mgc_div_1_b),
      .div_mgc_div_1_z(div_mgc_div_1_z)
    );
endmodule



