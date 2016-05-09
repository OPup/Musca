// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2011a.126 Production Release
//  HLS Date:       Wed Aug  8 00:52:07 PDT 2012
// 
//  Generated by:   kjr115@EEWS104A-022
//  Generated date: Mon May 09 17:47:20 2016
// ----------------------------------------------------------------------

// 
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



  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : core
    // Interconnect Declarations
    reg written_sva;
    reg [4:0] if_for_i_1_sva;
    reg [4:0] if_for_for_j_1_sva;
    reg [4:0] if_for_for_j_1_sva_1;
    reg [4:0] if_for_i_1_sva_1;
    reg if_for_for_slc_itm;

    begin : core_rlpExit
      forever begin : core_rlp
        // C-Step 0 of Loop 'core_rlp'
        written_sva = 1'b0;
        begin : waitLoop0Exit
          forever begin : waitLoop0
            @(posedge clk);
            if ( rst )
              disable core_rlpExit;
            if ( clk )
              disable waitLoop0Exit;
          end
        end
        // C-Step 1 of Loop 'core_rlp'
        begin : mainExit
          forever begin : main
            // C-Step 0 of Loop 'main'
            if ( written_sva ) begin
              write_rsc_mgc_out_stdreg_d <= 1'b0;
            end
            else begin
              write_rsc_mgc_out_stdreg_d <= 1'b1;
              if_for_i_1_sva = 5'b0;
            end
            begin : waitLoop1Exit
              forever begin : waitLoop1
                @(posedge clk);
                if ( rst )
                  disable core_rlpExit;
                if ( clk )
                  disable waitLoop1Exit;
              end
            end
            // C-Step 1 of Loop 'main'
            if ( written_sva ) begin
            end
            else begin
              begin : if_forExit
                forever begin : if_for
                  // C-Step 0 of Loop 'if_for'
                  if_for_for_j_1_sva = 5'b0;
                  begin : if_for_forExit
                    forever begin : if_for_for
                      // C-Step 0 of Loop 'if_for_for'
                      row_rsc_mgc_out_stdreg_d <= {1'b0, if_for_i_1_sva};
                      col_rsc_mgc_out_stdreg_d <= {1'b0, if_for_for_j_1_sva};
                      begin : waitLoop2Exit
                        forever begin : waitLoop2
                          @(posedge clk);
                          if ( rst )
                            disable core_rlpExit;
                          if ( clk )
                            disable waitLoop2Exit;
                        end
                      end
                      // C-Step 1 of Loop 'if_for_for'
                      out_rsc_mgc_out_stdreg_d <= {3'b0, (~((~((if_for_i_1_sva[4])
                          & (if_for_i_1_sva[3]) & (if_for_i_1_sva[1]) & (~((if_for_i_1_sva[2])
                          | (if_for_i_1_sva[0]))))) & ((if_for_i_1_sva[4]) | (if_for_i_1_sva[3])
                          | (if_for_i_1_sva[2]) | (if_for_i_1_sva[1]) | (if_for_i_1_sva[0]))))
                          | (~((~((if_for_for_j_1_sva[4]) & (if_for_for_j_1_sva[3])
                          & (if_for_for_j_1_sva[1]) & (~((if_for_for_j_1_sva[2])
                          | (if_for_for_j_1_sva[0]))))) & ((if_for_for_j_1_sva[4])
                          | (if_for_for_j_1_sva[3]) | (if_for_for_j_1_sva[2]) | (if_for_for_j_1_sva[1])
                          | (if_for_for_j_1_sva[0]))))};
                      if_for_for_j_1_sva_1 = if_for_for_j_1_sva + 5'b1;
                      if_for_for_slc_itm = readslicef_6_1_5((conv_u2s_5_6(if_for_for_j_1_sva_1)
                          + 6'b100101));
                      begin : waitLoop3Exit
                        forever begin : waitLoop3
                          @(posedge clk);
                          if ( rst )
                            disable core_rlpExit;
                          if ( clk )
                            disable waitLoop3Exit;
                        end
                      end
                      // C-Step 2 of Loop 'if_for_for'
                      if ( ~ if_for_for_slc_itm )
                        disable if_for_forExit;
                      if_for_for_j_1_sva = if_for_for_j_1_sva_1;
                    end
                  end
                  begin : waitLoop4Exit
                    forever begin : waitLoop4
                      @(posedge clk);
                      if ( rst )
                        disable core_rlpExit;
                      if ( clk )
                        disable waitLoop4Exit;
                    end
                  end
                  // C-Step 1 of Loop 'if_for'
                  if_for_i_1_sva_1 = if_for_i_1_sva + 5'b1;
                  if ( ~ (readslicef_6_1_5((conv_u2s_5_6(if_for_i_1_sva_1) + 6'b100101)))
                      )
                    disable if_forExit;
                  if_for_i_1_sva = if_for_i_1_sva_1;
                end
              end
            end
            written_sva = 1'b1;
          end
        end
      end
    end
    if_for_for_slc_itm = 1'b0;
    if_for_i_1_sva_1 = 5'b0;
    if_for_for_j_1_sva_1 = 5'b0;
    if_for_for_j_1_sva = 5'b0;
    if_for_i_1_sva = 5'b0;
    written_sva = 1'b0;
    write_rsc_mgc_out_stdreg_d <= 1'b0;
    out_rsc_mgc_out_stdreg_d <= 4'b0;
    col_rsc_mgc_out_stdreg_d <= 6'b0;
    row_rsc_mgc_out_stdreg_d <= 6'b0;
  end


  function [0:0] readslicef_6_1_5;
    input [5:0] vector;
    reg [5:0] tmp;
  begin
    tmp = vector >> 5;
    readslicef_6_1_5 = tmp[0:0];
  end
  endfunction


  function signed [5:0] conv_u2s_5_6 ;
    input [4:0]  vector ;
  begin
    conv_u2s_5_6 = {1'b0, vector};
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



