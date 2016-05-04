// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2011a.126 Production Release
//  HLS Date:       Wed Aug  8 00:52:07 PDT 2012
// 
//  Generated by:   kjr115@EEWS104A-013
//  Generated date: Fri Apr 29 17:18:18 2016
// ----------------------------------------------------------------------

// 
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



  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : core
    // Interconnect Declarations
    reg [18:0] for_i_1_sva;
    reg [18:0] for_i_1_sva_1;
    reg for_slc_itm;

    begin : mainExit
      forever begin : main
        // C-Step 0 of Loop 'main'
        for_i_1_sva = 19'b0;
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
        begin : for_0Exit
          forever begin : for_0
            // C-Step 0 of Loop 'for_0'
            begin : waitLoop1Exit
              forever begin : waitLoop1
                @(posedge clk);
                if ( rst )
                  disable mainExit;
                if ( clk )
                  disable waitLoop1Exit;
              end
            end
            // C-Step 1 of Loop 'for_0'
            v_out_rsc_mgc_out_stdreg_d <= signext_12_1(readslicef_8_1_7(((for_i_1_sva[18:11])
                + 8'b10110101)));
            for_i_1_sva_1 = for_i_1_sva + 19'b1;
            for_slc_itm = readslicef_8_1_7((conv_u2s_7_8(for_i_1_sva_1[18:12]) +
                8'b10110101));
            begin : waitLoop2Exit
              forever begin : waitLoop2
                @(posedge clk);
                if ( rst )
                  disable mainExit;
                if ( clk )
                  disable waitLoop2Exit;
              end
            end
            // C-Step 2 of Loop 'for_0'
            if ( ~ for_slc_itm )
              disable for_0Exit;
            for_i_1_sva = for_i_1_sva_1;
          end
        end
      end
    end
    for_slc_itm = 1'b0;
    for_i_1_sva_1 = 19'b0;
    for_i_1_sva = 19'b0;
    v_out_rsc_mgc_out_stdreg_d <= 12'b0;
    // NOP
  end


  function [0:0] readslicef_8_1_7;
    input [7:0] vector;
    reg [7:0] tmp;
  begin
    tmp = vector >> 7;
    readslicef_8_1_7 = tmp[0:0];
  end
  endfunction


  function [11:0] signext_12_1;
    input [0:0] vector;
  begin
    signext_12_1= {{11{vector[0]}}, vector};
  end
  endfunction


  function signed [7:0] conv_u2s_7_8 ;
    input [6:0]  vector ;
  begin
    conv_u2s_7_8 = {1'b0, vector};
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


