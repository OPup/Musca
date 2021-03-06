// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2011a.126 Production Release
//  HLS Date:       Wed Aug  8 00:52:07 PDT 2012
// 
//  Generated by:   cm2715@EEWS104A-016
//  Generated date: Wed May 04 15:16:36 2016
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    Render_core
// ------------------------------------------------------------------


module Render_core (
  clk, rst, X_pix_rsc_mgc_in_wire_d, Y_pix_rsc_mgc_in_wire_d, v_out_rsc_mgc_out_stdreg_d
);
  input clk;
  input rst;
  input [10:0] X_pix_rsc_mgc_in_wire_d;
  input [10:0] Y_pix_rsc_mgc_in_wire_d;
  output [11:0] v_out_rsc_mgc_out_stdreg_d;
  reg [11:0] v_out_rsc_mgc_out_stdreg_d;



  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : core
    // Interconnect Declarations
    reg [10:0] X_pix_1_sva;
    reg [10:0] Y_pix_1_sva;
    reg if_slc_svs;
    reg land_2_sva_1;
    reg land_2_lpi_dfm;
    reg land_1_sva_1;
    reg land_1_lpi_dfm;
    reg land_sva_1;
    reg slc_1_svs;
    reg land_5_sva_1;
    reg land_5_lpi_dfm;
    reg land_4_sva_1;
    reg land_4_lpi_dfm;
    reg land_3_sva_1;
    reg C3443_12_dfmergedata_sg3_lpi_dfm;

    begin : mainExit
      forever begin : main
        // C-Step 0 of Loop 'main'
        begin : waitLoop0Exit
          forever begin : waitLoop0
            @(posedge clk);
            if ( rst )
              disable mainExit;
            if ( clk )
              disable waitLoop0Exit;
          end
        end
        // C-Step 1 of Loop 'main'
        land_3_sva_1 = 1'b0;
        land_4_sva_1 = 1'b0;
        land_5_sva_1 = 1'b0;
        land_sva_1 = 1'b0;
        land_1_sva_1 = 1'b0;
        land_2_sva_1 = 1'b0;
        X_pix_1_sva = X_pix_rsc_mgc_in_wire_d;
        Y_pix_1_sva = Y_pix_rsc_mgc_in_wire_d;
        if_slc_svs = readslicef_11_1_10((conv_u2u_10_11(X_pix_1_sva[10:1]) + 11'b11111110001));
        if ( if_slc_svs ) begin
        end
        else begin
          land_2_sva_1 = ~ (readslicef_11_1_10((({1'b1 , (~ (X_pix_1_sva[10:1]))})
              + 11'b100111001)));
        end
        land_2_lpi_dfm = land_2_sva_1 & (~ if_slc_svs);
        if ( land_2_lpi_dfm ) begin
          land_1_sva_1 = ~ (readslicef_11_1_10((conv_u2u_10_11(Y_pix_1_sva[10:1])
              + 11'b11111110001)));
        end
        land_1_lpi_dfm = land_1_sva_1 & land_2_lpi_dfm;
        if ( land_1_lpi_dfm ) begin
          land_sva_1 = ~ (readslicef_12_1_11((({1'b1 , (~ Y_pix_1_sva)}) + 12'b101100011)));
        end
        slc_1_svs = readslicef_12_1_11((conv_u2s_11_12(X_pix_1_sva) + 12'b110101110001));
        if ( slc_1_svs ) begin
        end
        else begin
          land_5_sva_1 = ~ (readslicef_12_1_11((({1'b1 , (~ X_pix_1_sva)}) + 12'b10011100011)));
        end
        land_5_lpi_dfm = land_5_sva_1 & (~ slc_1_svs);
        if ( land_5_lpi_dfm ) begin
          land_4_sva_1 = ~ (readslicef_11_1_10((conv_u2u_10_11(Y_pix_1_sva[10:1])
              + 11'b11111110001)));
        end
        land_4_lpi_dfm = land_4_sva_1 & land_5_lpi_dfm;
        if ( land_4_lpi_dfm ) begin
          land_3_sva_1 = ~ (readslicef_12_1_11((({1'b1 , (~ Y_pix_1_sva)}) + 12'b101100011)));
        end
        C3443_12_dfmergedata_sg3_lpi_dfm = (land_sva_1 & land_1_lpi_dfm) | (land_3_sva_1
            & land_4_lpi_dfm);
        v_out_rsc_mgc_out_stdreg_d <= {2'b11 , C3443_12_dfmergedata_sg3_lpi_dfm ,
            1'b1 , C3443_12_dfmergedata_sg3_lpi_dfm , 3'b111 , ({{1{C3443_12_dfmergedata_sg3_lpi_dfm}},
            C3443_12_dfmergedata_sg3_lpi_dfm}) , 2'b11};
        begin : waitLoop1Exit
          forever begin : waitLoop1
            @(posedge clk);
            if ( rst )
              disable mainExit;
            if ( clk )
              disable waitLoop1Exit;
          end
        end
        // C-Step 2 of Loop 'main'
      end
    end
    C3443_12_dfmergedata_sg3_lpi_dfm = 1'b0;
    land_3_sva_1 = 1'b0;
    land_4_lpi_dfm = 1'b0;
    land_4_sva_1 = 1'b0;
    land_5_lpi_dfm = 1'b0;
    land_5_sva_1 = 1'b0;
    slc_1_svs = 1'b0;
    land_sva_1 = 1'b0;
    land_1_lpi_dfm = 1'b0;
    land_1_sva_1 = 1'b0;
    land_2_lpi_dfm = 1'b0;
    land_2_sva_1 = 1'b0;
    if_slc_svs = 1'b0;
    Y_pix_1_sva = 11'b0;
    X_pix_1_sva = 11'b0;
    v_out_rsc_mgc_out_stdreg_d <= 12'b0;
  end


  function [0:0] readslicef_11_1_10;
    input [10:0] vector;
    reg [10:0] tmp;
  begin
    tmp = vector >> 10;
    readslicef_11_1_10 = tmp[0:0];
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


  function  [10:0] conv_u2u_10_11 ;
    input [9:0]  vector ;
  begin
    conv_u2u_10_11 = {1'b0, vector};
  end
  endfunction


  function signed [11:0] conv_u2s_11_12 ;
    input [10:0]  vector ;
  begin
    conv_u2s_11_12 = {1'b0, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    Render
//  Generated from file(s):
//    2) $PROJECT_HOME/src/Render.cpp
// ------------------------------------------------------------------


module Render (
  X_pix_rsc_z, Y_pix_rsc_z, v_out_rsc_z, clk, rst
);
  input [10:0] X_pix_rsc_z;
  input [10:0] Y_pix_rsc_z;
  output [11:0] v_out_rsc_z;
  input clk;
  input rst;


  // Interconnect Declarations
  wire [10:0] X_pix_rsc_mgc_in_wire_d;
  wire [10:0] Y_pix_rsc_mgc_in_wire_d;
  wire [11:0] v_out_rsc_mgc_out_stdreg_d;


  // Interconnect Declarations for Component Instantiations 
  mgc_in_wire #(.rscid(1),
  .width(11)) X_pix_rsc_mgc_in_wire (
      .d(X_pix_rsc_mgc_in_wire_d),
      .z(X_pix_rsc_z)
    );
  mgc_in_wire #(.rscid(2),
  .width(11)) Y_pix_rsc_mgc_in_wire (
      .d(Y_pix_rsc_mgc_in_wire_d),
      .z(Y_pix_rsc_z)
    );
  mgc_out_stdreg #(.rscid(3),
  .width(12)) v_out_rsc_mgc_out_stdreg (
      .d(v_out_rsc_mgc_out_stdreg_d),
      .z(v_out_rsc_z)
    );
  Render_core Render_core_inst (
      .clk(clk),
      .rst(rst),
      .X_pix_rsc_mgc_in_wire_d(X_pix_rsc_mgc_in_wire_d),
      .Y_pix_rsc_mgc_in_wire_d(Y_pix_rsc_mgc_in_wire_d),
      .v_out_rsc_mgc_out_stdreg_d(v_out_rsc_mgc_out_stdreg_d)
    );
endmodule



