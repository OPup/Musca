// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2011a.126 Production Release
//  HLS Date:       Wed Aug  8 00:52:07 PDT 2012
// 
//  Generated by:   kjr115@EEWS104A-021
//  Generated date: Wed May 04 17:20:52 2016
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    RAM_BLOCK_core
// ------------------------------------------------------------------


module RAM_BLOCK_core (
  clk, rst, row_rsc_mgc_in_wire_d, col_rsc_mgc_in_wire_d, data_in_rsc_mgc_in_wire_d,
      write_rsc_mgc_in_wire_d, data_out_rsc_mgc_out_stdreg_d, data_rsc_singleport_data_in,
      data_rsc_singleport_addr, data_rsc_singleport_re, data_rsc_singleport_we, data_rsc_singleport_data_out
);
  input clk;
  input rst;
  input [4:0] row_rsc_mgc_in_wire_d;
  input [5:0] col_rsc_mgc_in_wire_d;
  input [1:0] data_in_rsc_mgc_in_wire_d;
  input write_rsc_mgc_in_wire_d;
  output [1:0] data_out_rsc_mgc_out_stdreg_d;
  reg [1:0] data_out_rsc_mgc_out_stdreg_d;
  output [1:0] data_rsc_singleport_data_in;
  output [12:0] data_rsc_singleport_addr;
  output data_rsc_singleport_re;
  output data_rsc_singleport_we;
  input [1:0] data_rsc_singleport_data_out;


  // Interconnect Declarations
  reg [1:0] data_rsc_singleport_data_in_reg;
  reg data_rsc_singleport_re_reg;
  reg data_rsc_singleport_we_reg;
  reg [10:0] data_rsc_singleport_addr_reg_sg1;
  reg [1:0] data_rsc_singleport_addr_reg_1;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : core
    // Interconnect Declarations
    reg [12:0] data_vinit_ndx_sva;
    reg [4:0] row_1_sva;
    reg [5:0] col_1_sva;
    reg [1:0] data_in_1_sva;
    reg if_nor_itm;
    reg [12:0] if_acc_1_itm;
    reg io_read_write_rsc_d_svs_st;
    reg [1:0] data_rsc_singleport_data_in_reg_var;
    reg data_rsc_singleport_re_reg_var;
    reg data_rsc_singleport_we_reg_var;
    reg last_clk;
    reg [10:0] data_rsc_singleport_addr_reg_var_sg1;
    reg [1:0] data_rsc_singleport_addr_reg_var_1;

    begin : core_rlpExit
      forever begin : core_rlp
        // C-Step 0 of Loop 'core_rlp'
        data_vinit_ndx_sva = 13'b1001010111111;
        data_rsc_singleport_data_in_reg <= 2'b0;
        data_rsc_singleport_addr_reg_1 <= 2'b0;
        data_rsc_singleport_addr_reg_sg1 <= 11'b0;
        data_rsc_singleport_re_reg <= 1'b1;
        data_rsc_singleport_we_reg <= 1'b1;
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
        begin : data_vinitExit
          forever begin : data_vinit
            // C-Step 0 of Loop 'data_vinit'
            data_rsc_singleport_data_in_reg <= 2'b0;
            data_rsc_singleport_addr_reg_1 <= 2'b0;
            data_rsc_singleport_addr_reg_sg1 <= 11'b0;
            data_rsc_singleport_re_reg <= 1'b1;
            data_rsc_singleport_we_reg <= 1'b1;
            data_rsc_singleport_we_reg <= 1'b0;
            data_rsc_singleport_addr_reg_1 <= data_vinit_ndx_sva[1:0];
            data_rsc_singleport_addr_reg_sg1 <= data_vinit_ndx_sva[12:2];
            data_rsc_singleport_data_in_reg <= 2'b0;
            begin : waitLoop1Exit
              forever begin : waitLoop1
                @(posedge clk);
                if ( rst )
                  disable core_rlpExit;
                if ( clk )
                  disable waitLoop1Exit;
              end
            end
            // C-Step 1 of Loop 'data_vinit'
            if_nor_itm = ~((data_vinit_ndx_sva[12]) | (data_vinit_ndx_sva[11]) |
                (data_vinit_ndx_sva[10]) | (data_vinit_ndx_sva[9]) | (data_vinit_ndx_sva[8])
                | (data_vinit_ndx_sva[7]) | (data_vinit_ndx_sva[6]) | (data_vinit_ndx_sva[5])
                | (data_vinit_ndx_sva[4]) | (data_vinit_ndx_sva[3]) | (data_vinit_ndx_sva[2])
                | (data_vinit_ndx_sva[1]) | (data_vinit_ndx_sva[0]));
            if_acc_1_itm = data_vinit_ndx_sva + 13'b1111111111111;
            data_rsc_singleport_data_in_reg <= 2'b0;
            data_rsc_singleport_addr_reg_1 <= 2'b0;
            data_rsc_singleport_addr_reg_sg1 <= 11'b0;
            data_rsc_singleport_re_reg <= 1'b1;
            data_rsc_singleport_we_reg <= 1'b1;
            begin : waitLoop2Exit
              forever begin : waitLoop2
                @(posedge clk);
                if ( rst )
                  disable core_rlpExit;
                if ( clk )
                  disable waitLoop2Exit;
              end
            end
            // C-Step 2 of Loop 'data_vinit'
            if ( if_nor_itm )
              disable data_vinitExit;
            data_vinit_ndx_sva = if_acc_1_itm;
          end
        end
        begin : mainExit
          forever begin : main
            // C-Step 0 of Loop 'main'
            data_rsc_singleport_data_in_reg_var = data_rsc_singleport_data_in_reg;
            data_rsc_singleport_addr_reg_var_1 = data_rsc_singleport_addr_reg_1;
            data_rsc_singleport_addr_reg_var_sg1 = data_rsc_singleport_addr_reg_sg1;
            data_rsc_singleport_re_reg_var = data_rsc_singleport_re_reg;
            data_rsc_singleport_we_reg_var = data_rsc_singleport_we_reg;
            begin : unreg_outs_lp_3Exit
              forever begin : unreg_outs_lp_3
                // C-Step 0 of Loop 'unreg_outs_lp_3'
                data_rsc_singleport_data_in_reg <= 2'b0;
                data_rsc_singleport_addr_reg_1 <= 2'b0;
                data_rsc_singleport_addr_reg_sg1 <= 11'b0;
                data_rsc_singleport_re_reg <= 1'b1;
                data_rsc_singleport_we_reg <= 1'b1;
                row_1_sva = row_rsc_mgc_in_wire_d;
                col_1_sva = col_rsc_mgc_in_wire_d;
                data_in_1_sva = data_in_rsc_mgc_in_wire_d;
                io_read_write_rsc_d_svs_st = write_rsc_mgc_in_wire_d;
                if ( io_read_write_rsc_d_svs_st ) begin
                  data_rsc_singleport_we_reg <= 1'b0;
                  data_rsc_singleport_addr_reg_1 <= col_1_sva[1:0];
                  data_rsc_singleport_addr_reg_sg1 <= {2'b0, readslicef_10_9_1((conv_s2u_7_10({1'b1
                      , (~ row_1_sva) , 1'b1}) + ({row_1_sva , (col_1_sva[5:2]) ,
                      1'b1})))};
                  data_rsc_singleport_data_in_reg <= data_in_1_sva;
                end
                else begin
                  data_rsc_singleport_re_reg <= 1'b0;
                  data_rsc_singleport_addr_reg_1 <= col_1_sva[1:0];
                  data_rsc_singleport_addr_reg_sg1 <= {2'b0, readslicef_10_9_1((conv_s2u_7_10({1'b1
                      , (~ row_1_sva) , 1'b1}) + ({row_1_sva , (col_1_sva[5:2]) ,
                      1'b1})))};
                end
                last_clk = clk;
                @((clk) or (row_rsc_mgc_in_wire_d) or (col_rsc_mgc_in_wire_d) or
                    (data_in_rsc_mgc_in_wire_d) or (write_rsc_mgc_in_wire_d));
                // C-Step 0 of Loop 'unreg_outs_lp_3'
                if ( (~ last_clk) & clk )
                  disable unreg_outs_lp_3Exit;
                data_rsc_singleport_data_in_reg <= data_rsc_singleport_data_in_reg_var;
                data_rsc_singleport_addr_reg_1 <= data_rsc_singleport_addr_reg_var_1;
                data_rsc_singleport_addr_reg_sg1 <= data_rsc_singleport_addr_reg_var_sg1;
                data_rsc_singleport_re_reg <= data_rsc_singleport_re_reg_var;
                data_rsc_singleport_we_reg <= data_rsc_singleport_we_reg_var;
              end
            end
            if ( rst )
              disable core_rlpExit;
            data_rsc_singleport_data_in_reg <= 2'b0;
            data_rsc_singleport_addr_reg_1 <= 2'b0;
            data_rsc_singleport_addr_reg_sg1 <= 11'b0;
            data_rsc_singleport_re_reg <= 1'b1;
            data_rsc_singleport_we_reg <= 1'b1;
            begin : waitLoop3Exit
              forever begin : waitLoop3
                @(posedge clk);
                if ( rst )
                  disable core_rlpExit;
                if ( clk )
                  disable waitLoop3Exit;
              end
            end
            // C-Step 1 of Loop 'main'
            if ( io_read_write_rsc_d_svs_st ) begin
              data_out_rsc_mgc_out_stdreg_d <= data_in_1_sva;
            end
            else begin
              data_out_rsc_mgc_out_stdreg_d <= data_rsc_singleport_data_out;
            end
            data_rsc_singleport_data_in_reg <= 2'b0;
            data_rsc_singleport_addr_reg_1 <= 2'b0;
            data_rsc_singleport_addr_reg_sg1 <= 11'b0;
            data_rsc_singleport_re_reg <= 1'b1;
            data_rsc_singleport_we_reg <= 1'b1;
            begin : waitLoop4Exit
              forever begin : waitLoop4
                @(posedge clk);
                if ( rst )
                  disable core_rlpExit;
                if ( clk )
                  disable waitLoop4Exit;
              end
            end
            // C-Step 2 of Loop 'main'
          end
        end
      end
    end
    data_rsc_singleport_we_reg <= 1'b0;
    data_rsc_singleport_re_reg <= 1'b0;
    data_rsc_singleport_addr_reg_1 <= 2'b0;
    data_rsc_singleport_addr_reg_sg1 <= 11'b0;
    data_rsc_singleport_data_in_reg <= 2'b0;
    data_out_rsc_mgc_out_stdreg_d <= 2'b0;
    data_rsc_singleport_data_in_reg <= 2'b0;
    data_rsc_singleport_addr_reg_1 <= 2'b0;
    data_rsc_singleport_addr_reg_sg1 <= 11'b0;
    data_rsc_singleport_re_reg <= 1'b1;
    data_rsc_singleport_we_reg <= 1'b1;
  end

  assign data_rsc_singleport_data_in = data_rsc_singleport_data_in_reg;
  assign data_rsc_singleport_addr = {data_rsc_singleport_addr_reg_sg1 , data_rsc_singleport_addr_reg_1};
  assign data_rsc_singleport_re = data_rsc_singleport_re_reg;
  assign data_rsc_singleport_we = data_rsc_singleport_we_reg;

  function [8:0] readslicef_10_9_1;
    input [9:0] vector;
    reg [9:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_10_9_1 = tmp[8:0];
  end
  endfunction


  function  [9:0] conv_s2u_7_10 ;
    input signed [6:0]  vector ;
  begin
    conv_s2u_7_10 = {{3{vector[6]}}, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    RAM_BLOCK
//  Generated from file(s):
//    2) $PROJECT_HOME/src/60x80RAM.cpp
// ------------------------------------------------------------------


module RAM_BLOCK (
  row_rsc_z, col_rsc_z, data_in_rsc_z, write_rsc_z, data_out_rsc_z, clk, rst
);
  input [4:0] row_rsc_z;
  input [5:0] col_rsc_z;
  input [1:0] data_in_rsc_z;
  input write_rsc_z;
  output [1:0] data_out_rsc_z;
  input clk;
  input rst;


  // Interconnect Declarations
  wire [4:0] row_rsc_mgc_in_wire_d;
  wire [5:0] col_rsc_mgc_in_wire_d;
  wire [1:0] data_in_rsc_mgc_in_wire_d;
  wire write_rsc_mgc_in_wire_d;
  wire [1:0] data_out_rsc_mgc_out_stdreg_d;
  wire [1:0] data_rsc_singleport_data_in;
  wire [12:0] data_rsc_singleport_addr;
  wire data_rsc_singleport_re;
  wire data_rsc_singleport_we;
  wire [1:0] data_rsc_singleport_data_out;


  // Interconnect Declarations for Component Instantiations 
  mgc_in_wire #(.rscid(1),
  .width(5)) row_rsc_mgc_in_wire (
      .d(row_rsc_mgc_in_wire_d),
      .z(row_rsc_z)
    );
  mgc_in_wire #(.rscid(2),
  .width(6)) col_rsc_mgc_in_wire (
      .d(col_rsc_mgc_in_wire_d),
      .z(col_rsc_z)
    );
  mgc_in_wire #(.rscid(3),
  .width(2)) data_in_rsc_mgc_in_wire (
      .d(data_in_rsc_mgc_in_wire_d),
      .z(data_in_rsc_z)
    );
  mgc_in_wire #(.rscid(4),
  .width(1)) write_rsc_mgc_in_wire (
      .d(write_rsc_mgc_in_wire_d),
      .z(write_rsc_z)
    );
  mgc_out_stdreg #(.rscid(5),
  .width(2)) data_out_rsc_mgc_out_stdreg (
      .d(data_out_rsc_mgc_out_stdreg_d),
      .z(data_out_rsc_z)
    );
  singleport_ram_be #(.ram_id(6),
  .words(4800),
  .width(2),
  .addr_width(13),
  .a_reset_active(0),
  .s_reset_active(1),
  .enable_active(0),
  .re_active(0),
  .we_active(0),
  .num_byte_enables(1),
  .clock_edge(1),
  .num_input_registers(1),
  .num_output_registers(0),
  .no_of_singleport_readwrite_port(1)) data_rsc_singleport (
      .data_in(data_rsc_singleport_data_in),
      .addr(data_rsc_singleport_addr),
      .re(data_rsc_singleport_re),
      .we(data_rsc_singleport_we),
      .data_out(data_rsc_singleport_data_out),
      .clk(clk),
      .a_rst(1'b1),
      .s_rst(rst),
      .en(1'b0)
    );
  RAM_BLOCK_core RAM_BLOCK_core_inst (
      .clk(clk),
      .rst(rst),
      .row_rsc_mgc_in_wire_d(row_rsc_mgc_in_wire_d),
      .col_rsc_mgc_in_wire_d(col_rsc_mgc_in_wire_d),
      .data_in_rsc_mgc_in_wire_d(data_in_rsc_mgc_in_wire_d),
      .write_rsc_mgc_in_wire_d(write_rsc_mgc_in_wire_d),
      .data_out_rsc_mgc_out_stdreg_d(data_out_rsc_mgc_out_stdreg_d),
      .data_rsc_singleport_data_in(data_rsc_singleport_data_in),
      .data_rsc_singleport_addr(data_rsc_singleport_addr),
      .data_rsc_singleport_re(data_rsc_singleport_re),
      .data_rsc_singleport_we(data_rsc_singleport_we),
      .data_rsc_singleport_data_out(data_rsc_singleport_data_out)
    );
endmodule


