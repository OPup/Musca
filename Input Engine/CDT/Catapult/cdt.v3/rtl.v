// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2011a.126 Production Release
//  HLS Date:       Wed Aug  8 00:52:07 PDT 2012
// 
//  Generated by:   oh1015@EEWS104A-005
//  Generated date: Wed Apr 27 17:59:28 2016
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    cdt_core
// ------------------------------------------------------------------


module cdt_core (
  clk, arst_n, H_IN_rsc_mgc_in_wire_d, S_IN_rsc_mgc_in_wire_d, G_OUT_rsc_mgc_out_stdreg_d
);
  input clk;
  input arst_n;
  input [9:0] H_IN_rsc_mgc_in_wire_d;
  input [9:0] S_IN_rsc_mgc_in_wire_d;
  output [9:0] G_OUT_rsc_mgc_out_stdreg_d;


  // Interconnect Declarations
  reg reg_G_OUT_rsc_mgc_out_stdreg_d_reg;


  // Interconnect Declarations for Component Instantiations 
  assign G_OUT_rsc_mgc_out_stdreg_d = {{9{reg_G_OUT_rsc_mgc_out_stdreg_d_reg}}, reg_G_OUT_rsc_mgc_out_stdreg_d_reg};
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      reg_G_OUT_rsc_mgc_out_stdreg_d_reg <= 1'b0;
    end
    else begin
      reg_G_OUT_rsc_mgc_out_stdreg_d_reg <= ~((readslicef_7_1_6((conv_u2u_6_7(S_IN_rsc_mgc_in_wire_d[9:4])
          + 7'b1111011))) | ((readslicef_10_1_9((({1'b1 , (~ (H_IN_rsc_mgc_in_wire_d[8:0]))})
          + 10'b110011))) & (readslicef_9_1_8((conv_u2u_8_9(H_IN_rsc_mgc_in_wire_d[9:2])
          + 9'b110101011)))));
    end
  end

  function [0:0] readslicef_7_1_6;
    input [6:0] vector;
    reg [6:0] tmp;
  begin
    tmp = vector >> 6;
    readslicef_7_1_6 = tmp[0:0];
  end
  endfunction


  function [0:0] readslicef_10_1_9;
    input [9:0] vector;
    reg [9:0] tmp;
  begin
    tmp = vector >> 9;
    readslicef_10_1_9 = tmp[0:0];
  end
  endfunction


  function [0:0] readslicef_9_1_8;
    input [8:0] vector;
    reg [8:0] tmp;
  begin
    tmp = vector >> 8;
    readslicef_9_1_8 = tmp[0:0];
  end
  endfunction


  function  [6:0] conv_u2u_6_7 ;
    input [5:0]  vector ;
  begin
    conv_u2u_6_7 = {1'b0, vector};
  end
  endfunction


  function  [8:0] conv_u2u_8_9 ;
    input [7:0]  vector ;
  begin
    conv_u2u_8_9 = {1'b0, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    cdt
//  Generated from file(s):
//    2) $PROJECT_HOME/cdt.cpp
// ------------------------------------------------------------------


module cdt (
  H_IN_rsc_z, S_IN_rsc_z, R_OUT_rsc_z, G_OUT_rsc_z, B_OUT_rsc_z, clk, arst_n
);
  input [9:0] H_IN_rsc_z;
  input [9:0] S_IN_rsc_z;
  output [9:0] R_OUT_rsc_z;
  output [9:0] G_OUT_rsc_z;
  output [9:0] B_OUT_rsc_z;
  input clk;
  input arst_n;


  // Interconnect Declarations
  wire [9:0] H_IN_rsc_mgc_in_wire_d;
  wire [9:0] S_IN_rsc_mgc_in_wire_d;
  wire [9:0] G_OUT_rsc_mgc_out_stdreg_d;


  // Interconnect Declarations for Component Instantiations 
  mgc_in_wire #(.rscid(1),
  .width(10)) H_IN_rsc_mgc_in_wire (
      .d(H_IN_rsc_mgc_in_wire_d),
      .z(H_IN_rsc_z)
    );
  mgc_in_wire #(.rscid(2),
  .width(10)) S_IN_rsc_mgc_in_wire (
      .d(S_IN_rsc_mgc_in_wire_d),
      .z(S_IN_rsc_z)
    );
  mgc_out_stdreg #(.rscid(4),
  .width(10)) R_OUT_rsc_mgc_out_stdreg (
      .d(10'b0),
      .z(R_OUT_rsc_z)
    );
  mgc_out_stdreg #(.rscid(5),
  .width(10)) G_OUT_rsc_mgc_out_stdreg (
      .d(G_OUT_rsc_mgc_out_stdreg_d),
      .z(G_OUT_rsc_z)
    );
  mgc_out_stdreg #(.rscid(6),
  .width(10)) B_OUT_rsc_mgc_out_stdreg (
      .d(10'b0),
      .z(B_OUT_rsc_z)
    );
  cdt_core cdt_core_inst (
      .clk(clk),
      .arst_n(arst_n),
      .H_IN_rsc_mgc_in_wire_d(H_IN_rsc_mgc_in_wire_d),
      .S_IN_rsc_mgc_in_wire_d(S_IN_rsc_mgc_in_wire_d),
      .G_OUT_rsc_mgc_out_stdreg_d(G_OUT_rsc_mgc_out_stdreg_d)
    );
endmodule



