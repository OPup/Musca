// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2011a.126 Production Release
//  HLS Date:       Wed Aug  8 00:52:07 PDT 2012
// 
//  Generated by:   oh1015@EEWS104A-005
//  Generated date: Thu Apr 28 18:10:49 2016
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    cdt_core
// ------------------------------------------------------------------


module cdt_core (
  clk, arst_n, H_IN_rsc_mgc_in_wire_d, S_IN_rsc_mgc_in_wire_d, V_IN_rsc_mgc_in_wire_d,
      R_OUT_rsc_mgc_out_stdreg_d, B_OUT_rsc_mgc_out_stdreg_d
);
  input clk;
  input arst_n;
  input [9:0] H_IN_rsc_mgc_in_wire_d;
  input [9:0] S_IN_rsc_mgc_in_wire_d;
  input [9:0] V_IN_rsc_mgc_in_wire_d;
  output [9:0] R_OUT_rsc_mgc_out_stdreg_d;
  reg [9:0] R_OUT_rsc_mgc_out_stdreg_d;
  output [9:0] B_OUT_rsc_mgc_out_stdreg_d;
  reg [9:0] B_OUT_rsc_mgc_out_stdreg_d;



  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : core
    // Interconnect Declarations
    reg [9:0] H_IN_1_sva;
    reg [9:0] S_IN_1_sva;
    reg [9:0] V_IN_1_sva;
    reg slc_svs;
    reg land_sva_1;
    reg land_lpi_dfm;
    reg if_slc_svs;
    reg if_lor_sva_1;
    reg slc_1_svs;
    reg land_1_sva_1;
    reg land_1_lpi_dfm;
    reg if_1_slc_svs;
    reg if_1_land_sva_1;

    begin : mainExit
      forever begin : main
        // C-Step 0 of Loop 'main'
        begin : waitLoop0Exit
          forever begin : waitLoop0
            @(posedge clk or negedge ( arst_n ));
            if ( ~ arst_n )
              disable mainExit;
            if ( clk )
              disable waitLoop0Exit;
          end
        end
        // C-Step 1 of Loop 'main'
        if_1_land_sva_1 = 1'b0;
        land_1_sva_1 = 1'b0;
        if_lor_sva_1 = 1'b0;
        land_sva_1 = 1'b0;
        H_IN_1_sva = H_IN_rsc_mgc_in_wire_d;
        S_IN_1_sva = S_IN_rsc_mgc_in_wire_d;
        V_IN_1_sva = V_IN_rsc_mgc_in_wire_d;
        slc_svs = readslicef_11_1_10((conv_u2s_10_11(S_IN_1_sva) + 11'b11110111111));
        if ( slc_svs ) begin
        end
        else begin
          land_sva_1 = ~ (readslicef_10_1_9((conv_u2u_9_10(V_IN_1_sva[9:1]) + 10'b1111110001)));
        end
        land_lpi_dfm = land_sva_1 & (~ slc_svs);
        if ( land_lpi_dfm ) begin
          if_slc_svs = readslicef_10_1_9((conv_u2u_9_10(H_IN_1_sva[9:1]) + 10'b1101010001));
          if ( if_slc_svs ) begin
            if_lor_sva_1 = ~ (readslicef_9_1_8((({1'b1 , (~ (H_IN_1_sva[8:1]))})
                + 9'b111)));
          end
        end
        slc_1_svs = readslicef_10_1_9((conv_u2u_9_10(S_IN_1_sva[9:1]) + 10'b1111110001));
        if ( slc_1_svs ) begin
        end
        else begin
          land_1_sva_1 = readslicef_11_1_10((({1'b1 , (~ V_IN_1_sva)}) + 11'b11111));
        end
        land_1_lpi_dfm = land_1_sva_1 & (~ slc_1_svs);
        if ( land_1_lpi_dfm ) begin
          if_1_slc_svs = readslicef_10_1_9((conv_u2u_9_10(H_IN_1_sva[9:1]) + 10'b1110100001));
          if ( if_1_slc_svs ) begin
          end
          else begin
            if_1_land_sva_1 = ~ (readslicef_11_1_10((({1'b1 , (~ H_IN_1_sva)}) +
                11'b100000101)));
          end
        end
        R_OUT_rsc_mgc_out_stdreg_d <= signext_10_1((if_lor_sva_1 | (~ if_slc_svs))
            & land_lpi_dfm);
        B_OUT_rsc_mgc_out_stdreg_d <= signext_10_1(if_1_land_sva_1 & (~ if_1_slc_svs)
            & land_1_lpi_dfm);
      end
    end
    if_1_land_sva_1 = 1'b0;
    if_1_slc_svs = 1'b0;
    land_1_lpi_dfm = 1'b0;
    land_1_sva_1 = 1'b0;
    slc_1_svs = 1'b0;
    if_lor_sva_1 = 1'b0;
    if_slc_svs = 1'b0;
    land_lpi_dfm = 1'b0;
    land_sva_1 = 1'b0;
    slc_svs = 1'b0;
    V_IN_1_sva = 10'b0;
    S_IN_1_sva = 10'b0;
    H_IN_1_sva = 10'b0;
    B_OUT_rsc_mgc_out_stdreg_d <= 10'b0;
    R_OUT_rsc_mgc_out_stdreg_d <= 10'b0;
  end


  function [0:0] readslicef_11_1_10;
    input [10:0] vector;
    reg [10:0] tmp;
  begin
    tmp = vector >> 10;
    readslicef_11_1_10 = tmp[0:0];
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


  function [9:0] signext_10_1;
    input [0:0] vector;
  begin
    signext_10_1= {{9{vector[0]}}, vector};
  end
  endfunction


  function signed [10:0] conv_u2s_10_11 ;
    input [9:0]  vector ;
  begin
    conv_u2s_10_11 = {1'b0, vector};
  end
  endfunction


  function  [9:0] conv_u2u_9_10 ;
    input [8:0]  vector ;
  begin
    conv_u2u_9_10 = {1'b0, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    cdt
//  Generated from file(s):
//    2) $PROJECT_HOME/cdt.cpp
// ------------------------------------------------------------------


module cdt (
  H_IN_rsc_z, S_IN_rsc_z, V_IN_rsc_z, R_OUT_rsc_z, G_OUT_rsc_z, B_OUT_rsc_z, clk,
      arst_n
);
  input [9:0] H_IN_rsc_z;
  input [9:0] S_IN_rsc_z;
  input [9:0] V_IN_rsc_z;
  output [9:0] R_OUT_rsc_z;
  output [9:0] G_OUT_rsc_z;
  output [9:0] B_OUT_rsc_z;
  input clk;
  input arst_n;


  // Interconnect Declarations
  wire [9:0] H_IN_rsc_mgc_in_wire_d;
  wire [9:0] S_IN_rsc_mgc_in_wire_d;
  wire [9:0] V_IN_rsc_mgc_in_wire_d;
  wire [9:0] R_OUT_rsc_mgc_out_stdreg_d;
  wire [9:0] B_OUT_rsc_mgc_out_stdreg_d;


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
  mgc_in_wire #(.rscid(3),
  .width(10)) V_IN_rsc_mgc_in_wire (
      .d(V_IN_rsc_mgc_in_wire_d),
      .z(V_IN_rsc_z)
    );
  mgc_out_stdreg #(.rscid(4),
  .width(10)) R_OUT_rsc_mgc_out_stdreg (
      .d(R_OUT_rsc_mgc_out_stdreg_d),
      .z(R_OUT_rsc_z)
    );
  mgc_out_stdreg #(.rscid(5),
  .width(10)) G_OUT_rsc_mgc_out_stdreg (
      .d(10'b0),
      .z(G_OUT_rsc_z)
    );
  mgc_out_stdreg #(.rscid(6),
  .width(10)) B_OUT_rsc_mgc_out_stdreg (
      .d(B_OUT_rsc_mgc_out_stdreg_d),
      .z(B_OUT_rsc_z)
    );
  cdt_core cdt_core_inst (
      .clk(clk),
      .arst_n(arst_n),
      .H_IN_rsc_mgc_in_wire_d(H_IN_rsc_mgc_in_wire_d),
      .S_IN_rsc_mgc_in_wire_d(S_IN_rsc_mgc_in_wire_d),
      .V_IN_rsc_mgc_in_wire_d(V_IN_rsc_mgc_in_wire_d),
      .R_OUT_rsc_mgc_out_stdreg_d(R_OUT_rsc_mgc_out_stdreg_d),
      .B_OUT_rsc_mgc_out_stdreg_d(B_OUT_rsc_mgc_out_stdreg_d)
    );
endmodule


