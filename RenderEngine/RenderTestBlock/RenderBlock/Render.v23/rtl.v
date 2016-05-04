// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2011a.126 Production Release
//  HLS Date:       Wed Aug  8 00:52:07 PDT 2012
// 
//  Generated by:   kjr115@EEWS104A-009
//  Generated date: Tue May 03 16:21:25 2016
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    Render_core_fsm
//  FSM Module
// ------------------------------------------------------------------


module Render_core_fsm (
  clk, rst, fsm_output
);
  input clk;
  input rst;
  output [1:0] fsm_output;
  reg [1:0] fsm_output;


  // FSM State Type Declaration for Render_core_fsm_1
  parameter
    st_main = 1'd0,
    st_main_1 = 1'd1,
    state_x = 1'b0;

  reg [0:0] state_var;
  reg [0:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : Render_core_fsm_1
    case (state_var)
      st_main : begin
        fsm_output = 2'b1;
        state_var_NS = st_main_1;
      end
      st_main_1 : begin
        fsm_output = 2'b10;
        state_var_NS = st_main;
      end
      default : begin
        fsm_output = 2'b00;
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
  clk, rst, X_pix_rsc_mgc_in_wire_d, v_out_rsc_mgc_out_stdreg_d
);
  input clk;
  input rst;
  input [10:0] X_pix_rsc_mgc_in_wire_d;
  output [11:0] v_out_rsc_mgc_out_stdreg_d;
  reg [11:0] v_out_rsc_mgc_out_stdreg_d;


  // Interconnect Declarations
  wire [1:0] fsm_output;


  // Interconnect Declarations for Component Instantiations 
  Render_core_fsm Render_core_fsm_inst (
      .clk(clk),
      .rst(rst),
      .fsm_output(fsm_output)
    );
  always @(posedge clk) begin
    if ( rst ) begin
      v_out_rsc_mgc_out_stdreg_d <= 12'b0;
    end
    else begin
      v_out_rsc_mgc_out_stdreg_d <= MUX_v_12_2_2({v_out_rsc_mgc_out_stdreg_d , (signext_12_1(~
          (readslicef_6_1_5((conv_u2u_5_6(X_pix_rsc_mgc_in_wire_d[10:6]) + 6'b111011)))))},
          fsm_output[0]);
    end
  end

  function [11:0] MUX_v_12_2_2;
    input [23:0] inputs;
    input [0:0] sel;
    reg [11:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[23:12];
      end
      1'b1 : begin
        result = inputs[11:0];
      end
      default : begin
        result = inputs[23:12];
      end
    endcase
    MUX_v_12_2_2 = result;
  end
  endfunction


  function [0:0] readslicef_6_1_5;
    input [5:0] vector;
    reg [5:0] tmp;
  begin
    tmp = vector >> 5;
    readslicef_6_1_5 = tmp[0:0];
  end
  endfunction


  function [11:0] signext_12_1;
    input [0:0] vector;
  begin
    signext_12_1= {{11{vector[0]}}, vector};
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
//  Design Unit:    Render
//  Generated from file(s):
//    2) $PROJECT_HOME/src/Render.cpp
// ------------------------------------------------------------------


module Render (
  X_pix_rsc_z, v_out_rsc_z, clk, rst
);
  input [10:0] X_pix_rsc_z;
  output [11:0] v_out_rsc_z;
  input clk;
  input rst;


  // Interconnect Declarations
  wire [10:0] X_pix_rsc_mgc_in_wire_d;
  wire [11:0] v_out_rsc_mgc_out_stdreg_d;


  // Interconnect Declarations for Component Instantiations 
  mgc_in_wire #(.rscid(1),
  .width(11)) X_pix_rsc_mgc_in_wire (
      .d(X_pix_rsc_mgc_in_wire_d),
      .z(X_pix_rsc_z)
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
      .v_out_rsc_mgc_out_stdreg_d(v_out_rsc_mgc_out_stdreg_d)
    );
endmodule



