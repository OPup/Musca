
//------> ./rtl_mgc_ioport.v 
//------------------------------------------------------------------
//                M G C _ I O P O R T _ C O M P S
//------------------------------------------------------------------

//------------------------------------------------------------------
//                       M O D U L E S
//------------------------------------------------------------------

//------------------------------------------------------------------
//-- INPUT ENTITIES
//------------------------------------------------------------------

module mgc_in_wire (d, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  output [width-1:0] d;
  input  [width-1:0] z;

  wire   [width-1:0] d;

  assign d = z;

endmodule

//------------------------------------------------------------------

module mgc_in_wire_en (ld, d, lz, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  input              ld;
  output [width-1:0] d;
  output             lz;
  input  [width-1:0] z;

  wire   [width-1:0] d;
  wire               lz;

  assign d = z;
  assign lz = ld;

endmodule

//------------------------------------------------------------------

module mgc_in_wire_wait (ld, vd, d, lz, vz, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  input              ld;
  output             vd;
  output [width-1:0] d;
  output             lz;
  input              vz;
  input  [width-1:0] z;

  wire               vd;
  wire   [width-1:0] d;
  wire               lz;

  assign d = z;
  assign lz = ld;
  assign vd = vz;

endmodule
//------------------------------------------------------------------

module mgc_chan_in (ld, vd, d, lz, vz, z, size, req_size, sizez, sizelz);

  parameter integer rscid = 1;
  parameter integer width = 8;
  parameter integer sz_width = 8;

  input              ld;
  output             vd;
  output [width-1:0] d;
  output             lz;
  input              vz;
  input  [width-1:0] z;
  output [sz_width-1:0] size;
  input              req_size;
  input  [sz_width-1:0] sizez;
  output             sizelz;


  wire               vd;
  wire   [width-1:0] d;
  wire               lz;
  wire   [sz_width-1:0] size;
  wire               sizelz;

  assign d = z;
  assign lz = ld;
  assign vd = vz;
  assign size = sizez;
  assign sizelz = req_size;

endmodule


//------------------------------------------------------------------
//-- OUTPUT ENTITIES
//------------------------------------------------------------------

module mgc_out_stdreg (d, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  input    [width-1:0] d;
  output   [width-1:0] z;

  wire     [width-1:0] z;

  assign z = d;

endmodule

//------------------------------------------------------------------

module mgc_out_stdreg_en (ld, d, lz, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  input              ld;
  input  [width-1:0] d;
  output             lz;
  output [width-1:0] z;

  wire               lz;
  wire   [width-1:0] z;

  assign z = d;
  assign lz = ld;

endmodule

//------------------------------------------------------------------

module mgc_out_stdreg_wait (ld, vd, d, lz, vz, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  input              ld;
  output             vd;
  input  [width-1:0] d;
  output             lz;
  input              vz;
  output [width-1:0] z;

  wire               vd;
  wire               lz;
  wire   [width-1:0] z;

  assign z = d;
  assign lz = ld;
  assign vd = vz;

endmodule

//------------------------------------------------------------------

module mgc_out_prereg_en (ld, d, lz, z);

    parameter integer rscid = 1;
    parameter integer width = 8;

    input              ld;
    input  [width-1:0] d;
    output             lz;
    output [width-1:0] z;

    wire               lz;
    wire   [width-1:0] z;

    assign z = d;
    assign lz = ld;

endmodule

//------------------------------------------------------------------
//-- INOUT ENTITIES
//------------------------------------------------------------------

module mgc_inout_stdreg_en (ldin, din, ldout, dout, lzin, lzout, z);

    parameter integer rscid = 1;
    parameter integer width = 8;

    input              ldin;
    output [width-1:0] din;
    input              ldout;
    input  [width-1:0] dout;
    output             lzin;
    output             lzout;
    inout  [width-1:0] z;

    wire   [width-1:0] din;
    wire               lzin;
    wire               lzout;
    wire   [width-1:0] z;

    assign lzin = ldin;
    assign din = ldin ? z : {width{1'bz}};
    assign lzout = ldout;
    assign z = ldout ? dout : {width{1'bz}};

endmodule

//------------------------------------------------------------------
module hid_tribuf( I_SIG, ENABLE, O_SIG);
  parameter integer width = 8;

  input [width-1:0] I_SIG;
  input ENABLE;
  inout [width-1:0] O_SIG;

  assign O_SIG = (ENABLE) ? I_SIG : { width{1'bz}};

endmodule
//------------------------------------------------------------------

module mgc_inout_stdreg_wait (ldin, vdin, din, ldout, vdout, dout, lzin, vzin, lzout, vzout, z);

    parameter integer rscid = 1;
    parameter integer width = 8;

    input              ldin;
    output             vdin;
    output [width-1:0] din;
    input              ldout;
    output             vdout;
    input  [width-1:0] dout;
    output             lzin;
    input              vzin;
    output             lzout;
    input              vzout;
    inout  [width-1:0] z;

    wire               vdin;
    wire   [width-1:0] din;
    wire               vdout;
    wire               lzin;
    wire               lzout;
    wire   [width-1:0] z;
    wire   ldout_and_vzout;

    assign lzin = ldin;
    assign vdin = vzin;
    assign din = ldin ? z : {width{1'bz}};
    assign lzout = ldout;
    assign vdout = vzout ;
    assign ldout_and_vzout = ldout && vzout ;

    hid_tribuf #(width) tb( .I_SIG(dout),
                            .ENABLE(ldout_and_vzout),
                            .O_SIG(z) );

endmodule

//------------------------------------------------------------------

module mgc_inout_buf_wait (clk, en, arst, srst, ldin, vdin, din, ldout, vdout, dout, lzin, vzin, lzout, vzout, z);

    parameter integer rscid   = 0; // resource ID
    parameter integer width   = 8; // fifo width
    parameter         ph_clk  =  1'b1; // clock polarity 1=rising edge, 0=falling edge
    parameter         ph_en   =  1'b1; // clock enable polarity
    parameter         ph_arst =  1'b1; // async reset polarity
    parameter         ph_srst =  1'b1; // sync reset polarity

    input              clk;
    input              en;
    input              arst;
    input              srst;
    input              ldin;
    output             vdin;
    output [width-1:0] din;
    input              ldout;
    output             vdout;
    input  [width-1:0] dout;
    output             lzin;
    input              vzin;
    output             lzout;
    input              vzout;
    inout  [width-1:0] z;

    wire               lzout_buf;
    wire               vzout_buf;
    wire   [width-1:0] z_buf;
    wire               vdin;
    wire   [width-1:0] din;
    wire               vdout;
    wire               lzin;
    wire               lzout;
    wire   [width-1:0] z;

    assign lzin = ldin;
    assign vdin = vzin;
    assign din = ldin ? z : {width{1'bz}};
    assign lzout = lzout_buf & ~ldin;
    assign vzout_buf = vzout & ~ldin;
    hid_tribuf #(width) tb( .I_SIG(z_buf),
                            .ENABLE((lzout_buf && (!ldin) && vzout) ),
                            .O_SIG(z)  );

    mgc_out_buf_wait
    #(
        .rscid   (rscid),
        .width   (width),
        .ph_clk  (ph_clk),
        .ph_en   (ph_en),
        .ph_arst (ph_arst),
        .ph_srst (ph_srst)
    )
    BUFF
    (
        .clk     (clk),
        .en      (en),
        .arst    (arst),
        .srst    (srst),
        .ld      (ldout),
        .vd      (vdout),
        .d       (dout),
        .lz      (lzout_buf),
        .vz      (vzout_buf),
        .z       (z_buf)
    );


endmodule

module mgc_inout_fifo_wait (clk, en, arst, srst, ldin, vdin, din, ldout, vdout, dout, lzin, vzin, lzout, vzout, z);

    parameter integer rscid   = 0; // resource ID
    parameter integer width   = 8; // fifo width
    parameter integer fifo_sz = 8; // fifo depth
    parameter         ph_clk  = 1'b1;  // clock polarity 1=rising edge, 0=falling edge
    parameter         ph_en   = 1'b1;  // clock enable polarity
    parameter         ph_arst = 1'b1;  // async reset polarity
    parameter         ph_srst = 1'b1;  // sync reset polarity
    parameter integer ph_log2 = 3;     // log2(fifo_sz)
    parameter integer pwropt  = 0;     // pwropt

    input              clk;
    input              en;
    input              arst;
    input              srst;
    input              ldin;
    output             vdin;
    output [width-1:0] din;
    input              ldout;
    output             vdout;
    input  [width-1:0] dout;
    output             lzin;
    input              vzin;
    output             lzout;
    input              vzout;
    inout  [width-1:0] z;

    wire               lzout_buf;
    wire               vzout_buf;
    wire   [width-1:0] z_buf;
    wire               comb;
    wire               vdin;
    wire   [width-1:0] din;
    wire               vdout;
    wire               lzin;
    wire               lzout;
    wire   [width-1:0] z;

    assign lzin = ldin;
    assign vdin = vzin;
    assign din = ldin ? z : {width{1'bz}};
    assign lzout = lzout_buf & ~ldin;
    assign vzout_buf = vzout & ~ldin;
    assign comb = (lzout_buf && (!ldin) && vzout);

    hid_tribuf #(width) tb2( .I_SIG(z_buf), .ENABLE(comb), .O_SIG(z)  );

    mgc_out_fifo_wait
    #(
        .rscid   (rscid),
        .width   (width),
        .fifo_sz (fifo_sz),
        .ph_clk  (ph_clk),
        .ph_en   (ph_en),
        .ph_arst (ph_arst),
        .ph_srst (ph_srst),
        .ph_log2 (ph_log2),
        .pwropt  (pwropt)
    )
    FIFO
    (
        .clk   (clk),
        .en      (en),
        .arst    (arst),
        .srst    (srst),
        .ld      (ldout),
        .vd      (vdout),
        .d       (dout),
        .lz      (lzout_buf),
        .vz      (vzout_buf),
        .z       (z_buf)
    );

endmodule

//------------------------------------------------------------------
//-- I/O SYNCHRONIZATION ENTITIES
//------------------------------------------------------------------

module mgc_io_sync (ld, lz);

    input  ld;
    output lz;

    assign lz = ld;

endmodule

module mgc_bsync_rdy (rd, rz);

    parameter integer rscid   = 0; // resource ID
    parameter ready = 1;
    parameter valid = 0;

    input  rd;
    output rz;

    wire   rz;

    assign rz = rd;

endmodule

module mgc_bsync_vld (vd, vz);

    parameter integer rscid   = 0; // resource ID
    parameter ready = 0;
    parameter valid = 1;

    output vd;
    input  vz;

    wire   vd;

    assign vd = vz;

endmodule

module mgc_bsync_rv (rd, vd, rz, vz);

    parameter integer rscid   = 0; // resource ID
    parameter ready = 1;
    parameter valid = 1;

    input  rd;
    output vd;
    output rz;
    input  vz;

    wire   vd;
    wire   rz;

    assign rz = rd;
    assign vd = vz;

endmodule

//------------------------------------------------------------------

module mgc_sync (ldin, vdin, ldout, vdout);

  input  ldin;
  output vdin;
  input  ldout;
  output vdout;

  wire   vdin;
  wire   vdout;

  assign vdin = ldout;
  assign vdout = ldin;

endmodule

///////////////////////////////////////////////////////////////////////////////
// dummy function used to preserve funccalls for modulario
// it looks like a memory read to the caller
///////////////////////////////////////////////////////////////////////////////
module funccall_inout (d, ad, bd, z, az, bz);

  parameter integer ram_id = 1;
  parameter integer width = 8;
  parameter integer addr_width = 8;

  output [width-1:0]       d;
  input  [addr_width-1:0]  ad;
  input                    bd;
  input  [width-1:0]       z;
  output [addr_width-1:0]  az;
  output                   bz;

  wire   [width-1:0]       d;
  wire   [addr_width-1:0]  az;
  wire                     bz;

  assign d  = z;
  assign az = ad;
  assign bz = bd;

endmodule


///////////////////////////////////////////////////////////////////////////////
// inlinable modular io not otherwise found in mgc_ioport
///////////////////////////////////////////////////////////////////////////////

module modulario_en_in (vd, d, vz, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  output             vd;
  output [width-1:0] d;
  input              vz;
  input  [width-1:0] z;

  wire   [width-1:0] d;
  wire               vd;

  assign d = z;
  assign vd = vz;

endmodule

//------> ./rtl_mgc_ioport_v2001.v 
//------------------------------------------------------------------

module mgc_out_reg_pos (clk, en, arst, srst, ld, d, lz, z);

    parameter integer rscid   = 1;
    parameter integer width   = 8;
    parameter         ph_en   =  1'b1;
    parameter         ph_arst =  1'b1;
    parameter         ph_srst =  1'b1;

    input              clk;
    input              en;
    input              arst;
    input              srst;
    input              ld;
    input  [width-1:0] d;
    output             lz;
    output [width-1:0] z;

    reg                lz;
    reg    [width-1:0] z;

    generate
    if (ph_arst == 1'b0)
    begin: NEG_ARST
        always @(posedge clk or negedge arst)
        if (arst == 1'b0)
        begin: B1
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (srst == ph_srst)
        begin: B2
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (en == ph_en)
        begin: B3
            lz <= ld;
            z  <= (ld) ? d : z;
        end
    end
    else
    begin: POS_ARST
        always @(posedge clk or posedge arst)
        if (arst == 1'b1)
        begin: B1
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (srst == ph_srst)
        begin: B2
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (en == ph_en)
        begin: B3
            lz <= ld;
            z  <= (ld) ? d : z;
        end
    end
    endgenerate

endmodule

//------------------------------------------------------------------

module mgc_out_reg_neg (clk, en, arst, srst, ld, d, lz, z);

    parameter integer rscid   = 1;
    parameter integer width   = 8;
    parameter         ph_en   =  1'b1;
    parameter         ph_arst =  1'b1;
    parameter         ph_srst =  1'b1;

    input              clk;
    input              en;
    input              arst;
    input              srst;
    input              ld;
    input  [width-1:0] d;
    output             lz;
    output [width-1:0] z;

    reg                lz;
    reg    [width-1:0] z;

    generate
    if (ph_arst == 1'b0)
    begin: NEG_ARST
        always @(negedge clk or negedge arst)
        if (arst == 1'b0)
        begin: B1
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (srst == ph_srst)
        begin: B2
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (en == ph_en)
        begin: B3
            lz <= ld;
            z  <= (ld) ? d : z;
        end
    end
    else
    begin: POS_ARST
        always @(negedge clk or posedge arst)
        if (arst == 1'b1)
        begin: B1
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (srst == ph_srst)
        begin: B2
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (en == ph_en)
        begin: B3
            lz <= ld;
            z  <= (ld) ? d : z;
        end
    end
    endgenerate

endmodule

//------------------------------------------------------------------

module mgc_out_reg (clk, en, arst, srst, ld, d, lz, z); // Not Supported

    parameter integer rscid   = 1;
    parameter integer width   = 8;
    parameter         ph_clk  =  1'b1;
    parameter         ph_en   =  1'b1;
    parameter         ph_arst =  1'b1;
    parameter         ph_srst =  1'b1;

    input              clk;
    input              en;
    input              arst;
    input              srst;
    input              ld;
    input  [width-1:0] d;
    output             lz;
    output [width-1:0] z;


    generate
    if (ph_clk == 1'b0)
    begin: NEG_EDGE

        mgc_out_reg_neg
        #(
            .rscid   (rscid),
            .width   (width),
            .ph_en   (ph_en),
            .ph_arst (ph_arst),
            .ph_srst (ph_srst)
        )
        mgc_out_reg_neg_inst
        (
            .clk     (clk),
            .en      (en),
            .arst    (arst),
            .srst    (srst),
            .ld      (ld),
            .d       (d),
            .lz      (lz),
            .z       (z)
        );

    end
    else
    begin: POS_EDGE

        mgc_out_reg_pos
        #(
            .rscid   (rscid),
            .width   (width),
            .ph_en   (ph_en),
            .ph_arst (ph_arst),
            .ph_srst (ph_srst)
        )
        mgc_out_reg_pos_inst
        (
            .clk     (clk),
            .en      (en),
            .arst    (arst),
            .srst    (srst),
            .ld      (ld),
            .d       (d),
            .lz      (lz),
            .z       (z)
        );

    end
    endgenerate

endmodule




//------------------------------------------------------------------

module mgc_out_buf_wait (clk, en, arst, srst, ld, vd, d, vz, lz, z); // Not supported

    parameter integer rscid   = 1;
    parameter integer width   = 8;
    parameter         ph_clk  =  1'b1;
    parameter         ph_en   =  1'b1;
    parameter         ph_arst =  1'b1;
    parameter         ph_srst =  1'b1;

    input              clk;
    input              en;
    input              arst;
    input              srst;
    input              ld;
    output             vd;
    input  [width-1:0] d;
    output             lz;
    input              vz;
    output [width-1:0] z;

    wire               filled;
    wire               filled_next;
    wire   [width-1:0] abuf;
    wire               lbuf;


    assign filled_next = (filled & (~vz)) | (filled & ld) | (ld & (~vz));

    assign lbuf = ld & ~(filled ^ vz);

    assign vd = vz | ~filled;

    assign lz = ld | filled;

    assign z = (filled) ? abuf : d;

    wire dummy;
    wire dummy_bufreg_lz;

    // Output registers:
    mgc_out_reg
    #(
        .rscid   (rscid),
        .width   (1'b1),
        .ph_clk  (ph_clk),
        .ph_en   (ph_en),
        .ph_arst (ph_arst),
        .ph_srst (ph_srst)
    )
    STATREG
    (
        .clk     (clk),
        .en      (en),
        .arst    (arst),
        .srst    (srst),
        .ld      (filled_next),
        .d       (1'b0),       // input d is unused
        .lz      (filled),
        .z       (dummy)            // output z is unused
    );

    mgc_out_reg
    #(
        .rscid   (rscid),
        .width   (width),
        .ph_clk  (ph_clk),
        .ph_en   (ph_en),
        .ph_arst (ph_arst),
        .ph_srst (ph_srst)
    )
    BUFREG
    (
        .clk     (clk),
        .en      (en),
        .arst    (arst),
        .srst    (srst),
        .ld      (lbuf),
        .d       (d),
        .lz      (dummy_bufreg_lz),
        .z       (abuf)
    );

endmodule

//------------------------------------------------------------------

module mgc_out_fifo_wait (clk, en, arst, srst, ld, vd, d, lz, vz,  z);

    parameter integer rscid   = 0; // resource ID
    parameter integer width   = 8; // fifo width
    parameter integer fifo_sz = 8; // fifo depth
    parameter         ph_clk  = 1'b1; // clock polarity 1=rising edge, 0=falling edge
    parameter         ph_en   = 1'b1; // clock enable polarity
    parameter         ph_arst = 1'b1; // async reset polarity
    parameter         ph_srst = 1'b1; // sync reset polarity
    parameter integer ph_log2 = 3; // log2(fifo_sz)
    parameter integer pwropt  = 0; // pwropt


    input                 clk;
    input                 en;
    input                 arst;
    input                 srst;
    input                 ld;    // load data
    output                vd;    // fifo full active low
    input     [width-1:0] d;
    output                lz;    // fifo ready to send
    input                 vz;    // dest ready for data
    output    [width-1:0] z;

    wire    [31:0]      size;


      // Output registers:
 mgc_out_fifo_wait_core#(
        .rscid   (rscid),
        .width   (width),
        .sz_width (32),
        .fifo_sz (fifo_sz),
        .ph_clk  (ph_clk),
        .ph_en   (ph_en),
        .ph_arst (ph_arst),
        .ph_srst (ph_srst),
        .ph_log2 (ph_log2),
        .pwropt  (pwropt)
        ) CORE (
        .clk (clk),
        .en (en),
        .arst (arst),
        .srst (srst),
        .ld (ld),
        .vd (vd),
        .d (d),
        .lz (lz),
        .vz (vz),
        .z (z),
        .size (size)
        );

endmodule



module mgc_out_fifo_wait_core (clk, en, arst, srst, ld, vd, d, lz, vz,  z, size);

    parameter integer rscid   = 0; // resource ID
    parameter integer width   = 8; // fifo width
    parameter integer sz_width = 8; // size of port for elements in fifo
    parameter integer fifo_sz = 8; // fifo depth
    parameter         ph_clk  =  1'b1; // clock polarity 1=rising edge, 0=falling edge
    parameter         ph_en   =  1'b1; // clock enable polarity
    parameter         ph_arst =  1'b1; // async reset polarity
    parameter         ph_srst =  1'b1; // sync reset polarity
    parameter integer ph_log2 = 3; // log2(fifo_sz)
    parameter integer pwropt  = 0; // pwropt

   localparam integer  fifo_b = width * fifo_sz;

    input                 clk;
    input                 en;
    input                 arst;
    input                 srst;
    input                 ld;    // load data
    output                vd;    // fifo full active low
    input     [width-1:0] d;
    output                lz;    // fifo ready to send
    input                 vz;    // dest ready for data
    output    [width-1:0] z;
    output    [sz_width-1:0]      size;

    reg      [( (fifo_sz > 0) ? fifo_sz : 1)-1:0] stat_pre;
    wire     [( (fifo_sz > 0) ? fifo_sz : 1)-1:0] stat;
    reg      [( (fifo_b > 0) ? fifo_b : 1)-1:0] buff_pre;
    wire     [( (fifo_b > 0) ? fifo_b : 1)-1:0] buff;
    reg      [( (fifo_sz > 0) ? fifo_sz : 1)-1:0] en_l;
    reg      [(((fifo_sz > 0) ? fifo_sz : 1)-1)/8:0] en_l_s;

    reg       [width-1:0] buff_nxt;

    reg                   stat_nxt;
    reg                   stat_before;
    reg                   stat_after;
    reg                   en_l_var;

    integer               i;
    genvar                eni;

    wire [32:0]           size_t;
    reg [31:0]            count;
    reg [31:0]            count_t;
    reg [32:0]            n_elem;
// pragma translate_off
    reg [31:0]            peak;
// pragma translate_on

    wire [( (fifo_sz > 0) ? fifo_sz : 1)-1:0] dummy_statreg_lz;
    wire [( (fifo_b > 0) ? fifo_b : 1)-1:0] dummy_bufreg_lz;

    generate
    if ( fifo_sz > 0 )
    begin: FIFO_REG
      assign vd = vz | ~stat[0];
      assign lz = ld | stat[fifo_sz-1];
      assign size_t = (count - (vz && stat[fifo_sz-1])) + ld;
      assign size = size_t[sz_width-1:0];
      assign z = (stat[fifo_sz-1]) ? buff[fifo_b-1:width*(fifo_sz-1)] : d;

      always @(*)
      begin: FIFOPROC
        n_elem = 33'b0;
        for (i = fifo_sz-1; i >= 0; i = i - 1)
        begin
          if (i != 0)
            stat_before = stat[i-1];
          else
            stat_before = 1'b0;

          if (i != (fifo_sz-1))
            stat_after = stat[i+1];
          else
            stat_after = 1'b1;

          stat_nxt = stat_after &
                    (stat_before | (stat[i] & (~vz)) | (stat[i] & ld) | (ld & (~vz)));

          stat_pre[i] = stat_nxt;
          en_l_var = 1'b1;
          if (!stat_nxt)
            begin
              buff_nxt = {width{1'b0}};
              en_l_var = 1'b0;
            end
          else if (vz && stat_before)
            buff_nxt[0+:width] = buff[width*(i-1)+:width];
          else if (ld && !((vz && stat_before) || ((!vz) && stat[i])))
            buff_nxt = d;
          else
            begin
              if (pwropt == 0)
                buff_nxt[0+:width] = buff[width*i+:width];
              else
                buff_nxt = {width{1'b0}};
              en_l_var = 1'b0;
            end

          if (ph_en != 0)
            en_l[i] = en & en_l_var;
          else
            en_l[i] = en | ~en_l_var;

          buff_pre[width*i+:width] = buff_nxt[0+:width];

          if ((stat_after == 1'b1) && (stat[i] == 1'b0))
            n_elem = ($unsigned(fifo_sz) - 1) - i;
        end

        if (ph_en != 0)
          en_l_s[(((fifo_sz > 0) ? fifo_sz : 1)-1)/8] = 1'b1;
        else
          en_l_s[(((fifo_sz > 0) ? fifo_sz : 1)-1)/8] = 1'b0;

        for (i = fifo_sz-1; i >= 7; i = i - 1)
        begin
          if ((i%'d2) == 0)
          begin
            if (ph_en != 0)
              en_l_s[(i/8)-1] = en & (stat[i]|stat_pre[i-1]);
            else
              en_l_s[(i/8)-1] = en | ~(stat[i]|stat_pre[i-1]);
          end
        end

        if ( stat[fifo_sz-1] == 1'b0 )
          count_t = 32'b0;
        else if ( stat[0] == 1'b1 )
          count_t = { {(32-ph_log2){1'b0}}, fifo_sz};
        else
          count_t = n_elem[31:0];
        count = count_t;
// pragma translate_off
        if ( peak < count )
          peak = count;
// pragma translate_on
      end

      if (pwropt == 0)
      begin: NOCGFIFO
        // Output registers:
        mgc_out_reg
        #(
            .rscid   (rscid),
            .width   (fifo_sz),
            .ph_clk  (ph_clk),
            .ph_en   (ph_en),
            .ph_arst (ph_arst),
            .ph_srst (ph_srst)
        )
        STATREG
        (
            .clk     (clk),
            .en      (en),
            .arst    (arst),
            .srst    (srst),
            .ld      (1'b1),
            .d       (stat_pre),
            .lz      (dummy_statreg_lz[0]),
            .z       (stat)
        );
        mgc_out_reg
        #(
            .rscid   (rscid),
            .width   (fifo_b),
            .ph_clk  (ph_clk),
            .ph_en   (ph_en),
            .ph_arst (ph_arst),
            .ph_srst (ph_srst)
        )
        BUFREG
        (
            .clk     (clk),
            .en      (en),
            .arst    (arst),
            .srst    (srst),
            .ld      (1'b1),
            .d       (buff_pre),
            .lz      (dummy_bufreg_lz[0]),
            .z       (buff)
        );
      end
      else
      begin: CGFIFO
        // Output registers:
        if ( pwropt > 1)
        begin: CGSTATFIFO2
          for (eni = fifo_sz-1; eni >= 0; eni = eni - 1)
          begin: pwroptGEN1
            mgc_out_reg
            #(
              .rscid   (rscid),
              .width   (1),
              .ph_clk  (ph_clk),
              .ph_en   (ph_en),
              .ph_arst (ph_arst),
              .ph_srst (ph_srst)
            )
            STATREG
            (
              .clk     (clk),
              .en      (en_l_s[eni/8]),
              .arst    (arst),
              .srst    (srst),
              .ld      (1'b1),
              .d       (stat_pre[eni]),
              .lz      (dummy_statreg_lz[eni]),
              .z       (stat[eni])
            );
          end
        end
        else
        begin: CGSTATFIFO
          mgc_out_reg
          #(
            .rscid   (rscid),
            .width   (fifo_sz),
            .ph_clk  (ph_clk),
            .ph_en   (ph_en),
            .ph_arst (ph_arst),
            .ph_srst (ph_srst)
          )
          STATREG
          (
            .clk     (clk),
            .en      (en),
            .arst    (arst),
            .srst    (srst),
            .ld      (1'b1),
            .d       (stat_pre),
            .lz      (dummy_statreg_lz[0]),
            .z       (stat)
          );
        end
        for (eni = fifo_sz-1; eni >= 0; eni = eni - 1)
        begin: pwroptGEN2
          mgc_out_reg
          #(
            .rscid   (rscid),
            .width   (width),
            .ph_clk  (ph_clk),
            .ph_en   (ph_en),
            .ph_arst (ph_arst),
            .ph_srst (ph_srst)
          )
          BUFREG
          (
            .clk     (clk),
            .en      (en_l[eni]),
            .arst    (arst),
            .srst    (srst),
            .ld      (1'b1),
            .d       (buff_pre[width*eni+:width]),
            .lz      (dummy_bufreg_lz[eni]),
            .z       (buff[width*eni+:width])
          );
        end
      end
    end
    else
    begin: FEED_THRU
      assign vd = vz;
      assign lz = ld;
      assign z = d;
      assign size = ld && !vz;
    end
    endgenerate

endmodule

//------------------------------------------------------------------
//-- PIPE ENTITIES
//------------------------------------------------------------------
/*
 *
 *             _______________________________________________
 * WRITER    |                                               |          READER
 *           |           MGC_PIPE                            |
 *           |           __________________________          |
 *        --<| vdout  --<| vd ---------------  vz<|-----ldin<|---
 *           |           |      FIFO              |          |
 *        ---|>ldout  ---|>ld ---------------- lz |> ---vdin |>--
 *        ---|>dout -----|>d  ---------------- dz |> ----din |>--
 *           |           |________________________|          |
 *           |_______________________________________________|
 */
// two clock pipe
module mgc_pipe (clk, en, arst, srst, ldin, vdin, din, ldout, vdout, dout, size, req_size);

    parameter integer rscid   = 0; // resource ID
    parameter integer width   = 8; // fifo width
    parameter integer sz_width = 8; // width of size of elements in fifo
    parameter integer fifo_sz = 8; // fifo depth
    parameter integer log2_sz = 3; // log2(fifo_sz)
    parameter         ph_clk  = 1'b1;  // clock polarity 1=rising edge, 0=falling edge
    parameter         ph_en   = 1'b1;  // clock enable polarity
    parameter         ph_arst = 1'b1;  // async reset polarity
    parameter         ph_srst = 1'b1;  // sync reset polarity
    parameter integer pwropt  = 0; // pwropt

    input              clk;
    input              en;
    input              arst;
    input              srst;
    input              ldin;
    output             vdin;
    output [width-1:0] din;
    input              ldout;
    output             vdout;
    input  [width-1:0] dout;
    output [sz_width-1:0]      size;
    input              req_size;


    mgc_out_fifo_wait_core
    #(
        .rscid    (rscid),
        .width    (width),
        .sz_width (sz_width),
        .fifo_sz  (fifo_sz),
        .ph_clk   (ph_clk),
        .ph_en    (ph_en),
        .ph_arst  (ph_arst),
        .ph_srst  (ph_srst),
        .ph_log2  (log2_sz),
        .pwropt   (pwropt)
    )
    FIFO
    (
        .clk     (clk),
        .en      (en),
        .arst    (arst),
        .srst    (srst),
        .ld      (ldout),
        .vd      (vdout),
        .d       (dout),
        .lz      (vdin),
        .vz      (ldin),
        .z       (din),
        .size    (size)
    );

endmodule


//------> C:/PROGRA~1/CALYPT~1/CATAPU~1.126/Mgc_home/pkgs/hls_pkgs/mgc_comps_src/mgc_div_beh.v 
module mgc_div(a,b,z);
   parameter width_a = 8;
   parameter width_b = 8;
   parameter signd = 1;
   input [width_a-1:0] a;
   input [width_b-1:0] b; 
   output [width_a-1:0] z;  
   reg  [width_a-1:0] z;

   always@(a or b)
     begin
	if(signd)
	  div_s(a,b,z);
	else
          div_u(a,b,z);
     end


//-----------------------------------------------------------------
//     -- Vectorized Overloaded Arithmetic Operators
//-----------------------------------------------------------------
   
   function [width_a-1:0] fabs_l; 
      input [width_a-1:0] arg1;
      begin
         case(arg1[width_a-1])
            1'b1:
               fabs_l = {(width_a){1'b0}} - arg1;
            default: // was: 1'b0:
               fabs_l = arg1;
         endcase
      end
   endfunction
   
   function [width_b-1:0] fabs_r; 
      input [width_b-1:0] arg1;
      begin
         case (arg1[width_b-1])
            1'b1:
               fabs_r =  {(width_b){1'b0}} - arg1;
            default: // was: 1'b0:
               fabs_r = arg1;
         endcase
      end
   endfunction

   function [width_b:0] minus;
     input [width_b:0] in1;
     input [width_b:0] in2;
     reg [width_b+1:0] tmp;
     begin
       tmp = in1 - in2;
       minus = tmp[width_b:0];
     end
   endfunction

   
   task divmod;
      input [width_a-1:0] l;
      input [width_b-1:0] r;
      output [width_a-1:0] rdiv;
      output [width_b-1:0] rmod;
      
      parameter llen = width_a;
      parameter rlen = width_b;
      reg [(llen+rlen)-1:0] lbuf;
      reg [rlen:0] diff;
	  integer i;
      begin
	 lbuf = {(llen+rlen){1'b0}};
	 lbuf[llen-1:0] = l;
	 for(i=width_a-1;i>=0;i=i-1)
	   begin
              diff = minus(lbuf[(llen+rlen)-1:llen-1], {1'b0,r});
	      rdiv[i] = ~diff[rlen];
	      if(diff[rlen] == 0)
		lbuf[(llen+rlen)-1:llen-1] = diff;
	      lbuf[(llen+rlen)-1:1] = lbuf[(llen+rlen)-2:0];
	   end
	 rmod = lbuf[(llen+rlen)-1:llen];
      end
   endtask
      

   task div_u;
      input [width_a-1:0] l;
      input [width_b-1:0] r;
      output [width_a-1:0] rdiv;
      
      reg [width_a-01:0] rdiv;
      reg [width_b-1:0] rmod;
      begin
	 divmod(l, r, rdiv, rmod);
      end
   endtask
   
   task mod_u;
      input [width_a-1:0] l;
      input [width_b-1:0] r;
      output [width_b-1:0] rmod;
      
      reg [width_a-01:0] rdiv;
      reg [width_b-1:0] rmod;
      begin
	 divmod(l, r, rdiv, rmod);
      end
   endtask

   task rem_u; 
      input [width_a-1:0] l;
      input [width_b-1:0] r;    
      output [width_b-1:0] rmod;
      begin
	 mod_u(l,r,rmod);
      end
   endtask // rem_u

   task div_s;
      input [width_a-1:0] l;
      input [width_b-1:0] r;
      output [width_a-1:0] rdiv;
      
      reg [width_a-01:0] rdiv;
      reg [width_b-1:0] rmod;
      begin
	 divmod(fabs_l(l), fabs_r(r),rdiv,rmod);
	 if(l[width_a-1] != r[width_b-1])
	   rdiv = {(width_a){1'b0}} - rdiv;
      end
   endtask

   task mod_s;
      input [width_a-1:0] l;
      input [width_b-1:0] r;
      output [width_b-1:0] rmod;
      
      reg [width_a-01:0] rdiv;
      reg [width_b-1:0] rmod;
      reg [width_b-1:0] rnul;
      reg [width_b:0] rmod_t;
      begin
         rnul = {width_b{1'b0}};
         divmod(fabs_l(l), fabs_r(r), rdiv, rmod);
         if (l[width_a-1])
            rmod = {(width_b){1'b0}} - rmod;
         if((rmod != rnul) && (l[width_a-1] != r[width_b-1]))
            begin
               rmod_t = r + rmod;
               rmod = rmod_t[width_b-1:0];
            end
      end
   endtask // mod_s
   
   task rem_s; 
      input [width_a-1:0] l;
      input [width_b-1:0] r;    
      output [width_b-1:0] rmod;   
      reg [width_a-01:0] rdiv;
      reg [width_b-1:0] rmod;
      begin
	 divmod(fabs_l(l),fabs_r(r),rdiv,rmod);
	 if(l[width_a-1])
	   rmod = {(width_b){1'b0}} - rmod;
      end
   endtask

  endmodule

//------> ./rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2011a.126 Production Release
//  HLS Date:       Wed Aug  8 00:52:07 PDT 2012
// 
//  Generated by:   oh1015@EEWS104A-005
//  Generated date: Wed Apr 27 15:15:12 2016
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    HSVRGB_core
// ------------------------------------------------------------------


module HSVRGB_core (
  clk, arst_n, R_IN_rsc_mgc_in_wire_d, G_IN_rsc_mgc_in_wire_d, B_IN_rsc_mgc_in_wire_d,
      H_OUT_rsc_mgc_out_stdreg_d, S_OUT_rsc_mgc_out_stdreg_d, div_mgc_div_a, div_mgc_div_b,
      div_mgc_div_z, div_mgc_div_1_a, div_mgc_div_1_b, div_mgc_div_1_z, div_mgc_div_2_a,
      div_mgc_div_2_b, div_mgc_div_2_z, div_mgc_div_3_a, div_mgc_div_3_b, div_mgc_div_3_z,
      div_mgc_div_4_a, div_mgc_div_4_b, div_mgc_div_4_z, div_mgc_div_5_a, div_mgc_div_5_b,
      div_mgc_div_5_z, div_mgc_div_6_a, div_mgc_div_6_b, div_mgc_div_6_z, div_mgc_div_7_a,
      div_mgc_div_7_b, div_mgc_div_7_z, div_mgc_div_8_a, div_mgc_div_8_b, div_mgc_div_8_z,
      div_mgc_div_9_a, div_mgc_div_9_b, div_mgc_div_9_z, div_mgc_div_10_a, div_mgc_div_10_b,
      div_mgc_div_10_z
);
  input clk;
  input arst_n;
  input [9:0] R_IN_rsc_mgc_in_wire_d;
  input [9:0] G_IN_rsc_mgc_in_wire_d;
  input [9:0] B_IN_rsc_mgc_in_wire_d;
  output [9:0] H_OUT_rsc_mgc_out_stdreg_d;
  reg [9:0] H_OUT_rsc_mgc_out_stdreg_d;
  output [9:0] S_OUT_rsc_mgc_out_stdreg_d;
  reg [9:0] S_OUT_rsc_mgc_out_stdreg_d;
  output [21:0] div_mgc_div_a;
  output [14:0] div_mgc_div_b;
  input [21:0] div_mgc_div_z;
  output [21:0] div_mgc_div_1_a;
  output [14:0] div_mgc_div_1_b;
  input [21:0] div_mgc_div_1_z;
  output [21:0] div_mgc_div_2_a;
  output [14:0] div_mgc_div_2_b;
  input [21:0] div_mgc_div_2_z;
  output [21:0] div_mgc_div_3_a;
  output [14:0] div_mgc_div_3_b;
  input [21:0] div_mgc_div_3_z;
  output [21:0] div_mgc_div_4_a;
  output [14:0] div_mgc_div_4_b;
  input [21:0] div_mgc_div_4_z;
  output [21:0] div_mgc_div_5_a;
  output [14:0] div_mgc_div_5_b;
  input [21:0] div_mgc_div_5_z;
  output [21:0] div_mgc_div_6_a;
  output [14:0] div_mgc_div_6_b;
  input [21:0] div_mgc_div_6_z;
  output [21:0] div_mgc_div_7_a;
  output [14:0] div_mgc_div_7_b;
  input [21:0] div_mgc_div_7_z;
  output [21:0] div_mgc_div_8_a;
  output [14:0] div_mgc_div_8_b;
  input [21:0] div_mgc_div_8_z;
  output [13:0] div_mgc_div_9_a;
  output [6:0] div_mgc_div_9_b;
  reg [6:0] div_mgc_div_9_b;
  input [13:0] div_mgc_div_9_z;
  output [13:0] div_mgc_div_10_a;
  output [6:0] div_mgc_div_10_b;
  reg [6:0] div_mgc_div_10_b;
  input [13:0] div_mgc_div_10_z;


  // Interconnect Declarations
  wire [1:0] else_7_if_1_acc_tmp;
  wire [2:0] nl_else_7_if_1_acc_tmp;
  wire [1:0] else_7_else_1_if_acc_tmp;
  wire [2:0] nl_else_7_else_1_if_acc_tmp;
  wire [1:0] else_7_else_1_else_acc_tmp;
  wire [2:0] nl_else_7_else_1_else_acc_tmp;
  wire else_7_else_1_equal_tmp;
  wire else_7_equal_tmp;
  wire if_7_equal_tmp;
  wire [6:0] mux1h_18_tmp;
  wire and_dcpl_28;
  wire and_dcpl_73;
  wire and_dcpl_76;
  wire or_dcpl_17;
  wire or_tmp_22;
  wire or_tmp_26;
  wire not_tmp_41;
  wire mux_tmp_12;
  wire or_tmp_29;
  wire mux_tmp_14;
  wire or_tmp_32;
  wire mux_tmp_16;
  wire and_dcpl_121;
  wire and_dcpl_122;
  wire and_dcpl_125;
  wire and_dcpl_126;
  wire or_dcpl_35;
  wire or_dcpl_36;
  wire or_tmp_37;
  wire and_tmp_1;
  wire mux_tmp_17;
  wire or_tmp_42;
  wire mux_tmp_19;
  wire mux_tmp_21;
  wire mux_tmp_23;
  wire and_dcpl_180;
  wire and_dcpl_182;
  wire and_dcpl_186;
  wire or_dcpl_58;
  wire or_dcpl_60;
  wire or_tmp_50;
  wire mux_tmp_24;
  wire mux_tmp_26;
  wire mux_tmp_28;
  wire mux_tmp_30;
  wire and_dcpl_246;
  wire and_dcpl_247;
  wire and_dcpl_248;
  wire and_dcpl_249;
  wire or_dcpl_88;
  wire and_dcpl_266;
  wire and_dcpl_267;
  wire and_dcpl_270;
  wire or_dcpl_93;
  wire and_dcpl_286;
  wire and_dcpl_287;
  wire or_dcpl_100;
  wire or_dcpl_103;
  reg else_7_if_div_2cyc;
  reg [13:0] s_sva_2_duc;
  reg [1:0] else_7_if_1_div_3cyc;
  reg [11:0] else_7_if_1_ac_fixed_cctor_1_sva_duc;
  reg [1:0] else_7_else_1_if_div_3cyc;
  reg [11:0] div_sdt_2_sva_duc;
  reg [1:0] else_7_else_1_else_div_3cyc;
  reg [11:0] div_sdt_3_sva_duc;
  reg else_7_else_1_equal_svs_1;
  reg else_7_else_1_equal_svs_4;
  reg if_7_equal_svs_4;
  reg unequal_tmp_1;
  reg unequal_tmp_2;
  reg else_7_equal_svs_4;
  reg [5:0] h_sg1_lpi_dfm_3;
  reg [1:0] h_1_lpi_dfm_3;
  reg [6:0] max_sg1_lpi_dfm_3_mut_3;
  reg [1:0] else_7_else_1_else_slc_else_7_else_1_else_ac_fixed_cctor_sg1_itm_1;
  reg [1:0] else_7_else_1_if_slc_else_7_else_1_if_ac_fixed_cctor_sg1_itm_1;
  reg [1:0] else_7_if_1_slc_else_7_if_1_ac_fixed_cctor_5_itm_1;
  reg else_7_if_1_slc_else_7_if_1_ac_fixed_cctor_6_itm_1;
  reg else_7_else_1_if_slc_else_7_else_1_if_ac_fixed_cctor_sg1_3_itm_1;
  reg else_7_else_1_else_slc_else_7_else_1_else_ac_fixed_cctor_sg1_2_itm_1;
  reg else_7_if_1_slc_else_7_if_1_ac_fixed_cctor_itm_1;
  reg else_7_else_1_if_slc_else_7_else_1_if_ac_fixed_cctor_sg1_4_itm_1;
  reg else_7_else_1_else_slc_div_sdt_1_5_itm_1;
  reg [9:0] acc_3_itm_1;
  wire [10:0] nl_acc_3_itm_1;
  reg [9:0] acc_3_itm_2;
  reg if_7_equal_svs_st_1;
  reg if_7_equal_svs_st_2;
  reg [6:0] max_sg1_lpi_dfm_3_st_2;
  reg else_7_if_div_2cyc_st_2;
  reg else_7_equal_svs_st_1;
  reg else_7_equal_svs_st_2;
  reg [1:0] else_7_if_1_div_3cyc_st_2;
  reg if_7_equal_svs_st_3;
  reg else_7_equal_svs_st_3;
  reg [1:0] else_7_if_1_div_3cyc_st_3;
  reg else_7_else_1_equal_svs_st_2;
  reg [1:0] else_7_else_1_if_div_3cyc_st_2;
  reg else_7_else_1_equal_svs_st_3;
  reg [1:0] else_7_else_1_if_div_3cyc_st_3;
  reg [1:0] else_7_else_1_else_div_3cyc_st_2;
  reg [1:0] else_7_else_1_else_div_3cyc_st_3;
  reg main_stage_0_2;
  reg main_stage_0_3;
  reg main_stage_0_4;
  reg main_stage_0_5;
  reg [7:0] else_7_else_1_else_conc_tmp_mut_3_sg1;
  reg [7:0] else_7_else_1_else_conc_tmp_mut_4_sg1;
  reg [7:0] else_7_else_1_if_conc_tmp_mut_3_sg1;
  reg [7:0] else_7_else_1_if_conc_tmp_mut_4_sg1;
  reg [7:0] else_7_if_1_conc_tmp_mut_5_sg1;
  reg [7:0] else_7_if_1_conc_tmp_mut_6_sg1;
  reg [6:0] else_7_if_conc_tmp_mut_3_sg1;
  reg [6:0] mut_24_sg1_1;
  wire and_13_cse;
  wire and_88_cse;
  wire and_104_cse;
  wire and_120_cse;
  wire and_24_cse;
  wire and_93_cse;
  wire and_109_cse;
  wire and_125_cse;
  wire and_137_cse;
  wire and_143_cse;
  wire and_158_cse;
  wire and_164_cse;
  wire and_178_cse;
  wire and_184_cse;
  wire and_198_cse;
  wire and_204_cse;
  wire and_218_cse;
  wire and_224_cse;
  wire and_238_cse;
  wire and_244_cse;
  wire or_173_cse;
  wire and_337_cse;
  reg [6:0] reg_div_mgc_div_7_b_tmp;
  reg [7:0] reg_div_mgc_div_7_a_tmp;
  reg [6:0] reg_div_mgc_div_8_b_tmp;
  reg [7:0] reg_div_mgc_div_8_a_tmp;
  reg [6:0] reg_div_mgc_div_b_tmp;
  reg [7:0] reg_div_mgc_div_a_tmp;
  reg [6:0] reg_div_mgc_div_4_b_tmp;
  reg [7:0] reg_div_mgc_div_4_a_tmp;
  reg [6:0] reg_div_mgc_div_5_b_tmp;
  reg [7:0] reg_div_mgc_div_5_a_tmp;
  reg [6:0] reg_div_mgc_div_6_b_tmp;
  reg [7:0] reg_div_mgc_div_6_a_tmp;
  reg [6:0] reg_div_mgc_div_1_b_tmp;
  reg [7:0] reg_div_mgc_div_1_a_tmp;
  reg [6:0] reg_div_mgc_div_2_b_tmp;
  reg [7:0] reg_div_mgc_div_2_a_tmp;
  reg [6:0] reg_div_mgc_div_3_b_tmp;
  reg [7:0] reg_div_mgc_div_3_a_tmp;
  reg [6:0] reg_div_mgc_div_10_a_tmp;
  reg [6:0] reg_div_mgc_div_9_a_tmp;
  wire [1:0] h_sg1_1_sg1_lpi_dfm;
  wire [1:0] acc_imod;
  wire [2:0] nl_acc_imod;
  wire [1:0] else_7_if_1_acc_idiv;
  wire [2:0] nl_else_7_if_1_acc_idiv;
  wire [6:0] g_sg1_lpi_dfm;
  wire [6:0] b_sg1_lpi_dfm;
  wire [1:0] acc_imod_1;
  wire [2:0] nl_acc_imod_1;
  wire [1:0] else_7_else_1_if_acc_idiv;
  wire [2:0] nl_else_7_else_1_if_acc_idiv;
  wire [6:0] r_sg1_lpi_dfm;
  wire [1:0] acc_imod_2;
  wire [2:0] nl_acc_imod_2;
  wire [1:0] else_7_else_1_else_acc_idiv;
  wire [2:0] nl_else_7_else_1_else_acc_idiv;
  wire unequal_tmp;
  wire [6:0] min_sg1_lpi_dfm_3;
  wire [11:0] else_7_if_1_ac_fixed_cctor_1_sva_duc_mx0;
  wire [11:0] div_sdt_2_sva_duc_mx0;
  wire [3:0] else_7_else_1_if_ac_fixed_cctor_sg1_1_sva;
  wire [4:0] nl_else_7_else_1_if_ac_fixed_cctor_sg1_1_sva;
  wire [11:0] div_sdt_3_sva_duc_mx0;
  wire [2:0] else_7_else_1_else_ac_fixed_cctor_sg1_1_sva;
  wire [3:0] nl_else_7_else_1_else_ac_fixed_cctor_sg1_1_sva;
  wire else_7_nor_cse;
  wire else_7_and_5_cse;
  wire [12:0] else_7_acc_itm;
  wire [13:0] nl_else_7_acc_itm;
  wire [7:0] else_7_acc_3_itm;
  wire [8:0] nl_else_7_acc_3_itm;
  wire [8:0] else_7_if_1_acc_1_itm;
  wire [9:0] nl_else_7_if_1_acc_1_itm;
  wire [8:0] else_7_else_1_if_acc_2_itm;
  wire [9:0] nl_else_7_else_1_if_acc_2_itm;
  wire [8:0] else_7_else_1_else_acc_2_itm;
  wire [9:0] nl_else_7_else_1_else_acc_2_itm;
  wire [8:0] if_if_acc_1_itm;
  wire [9:0] nl_if_if_acc_1_itm;
  wire [8:0] else_1_if_acc_1_itm;
  wire [9:0] nl_else_1_if_acc_1_itm;
  wire [8:0] if_3_if_acc_1_itm;
  wire [9:0] nl_if_3_if_acc_1_itm;
  wire [8:0] else_5_if_acc_1_itm;
  wire [9:0] nl_else_5_if_acc_1_itm;
  wire [8:0] if_3_acc_itm;
  wire [9:0] nl_if_3_acc_itm;
  wire [8:0] if_acc_itm;
  wire [9:0] nl_if_acc_itm;
  wire [14:0] mul_1_itm;
  wire [29:0] nl_mul_1_itm;

  wire[1:0] else_7_mux1h_2_nl;
  wire[0:0] else_7_mux_4_nl;
  wire[0:0] else_7_else_1_mux_nl;
  wire[0:0] else_7_mux_5_nl;
  wire[0:0] else_7_else_1_mux_1_nl;
  wire[13:0] mux1h_26_nl;
  wire[0:0] mux_21_nl;
  wire[0:0] mux_23_nl;
  wire[0:0] mux_25_nl;
  wire[0:0] mux_28_nl;
  wire[0:0] mux_30_nl;
  wire[0:0] mux_32_nl;
  wire[0:0] mux_35_nl;
  wire[0:0] mux_37_nl;
  wire[0:0] mux_39_nl;

  // Interconnect Declarations for Component Instantiations 
  assign and_24_cse = and_13_cse & else_7_equal_svs_st_3;
  assign and_93_cse = (or_dcpl_17 | (else_7_if_1_acc_tmp[0]) | (else_7_if_1_acc_tmp[1]))
      & main_stage_0_2 & and_dcpl_76 & (~((else_7_if_1_div_3cyc[1]) | (else_7_if_1_div_3cyc[0])));
  assign div_mgc_div_7_b = {1'b0, {reg_div_mgc_div_7_b_tmp , 7'b0}};
  assign div_mgc_div_7_a = {reg_div_mgc_div_7_a_tmp , 14'b0};
  assign and_109_cse = (or_dcpl_17 | (~ (else_7_if_1_acc_tmp[0])) | (else_7_if_1_acc_tmp[1]))
      & main_stage_0_2 & and_dcpl_76 & (~ (else_7_if_1_div_3cyc[1])) & (else_7_if_1_div_3cyc[0]);
  assign div_mgc_div_8_b = {1'b0, {reg_div_mgc_div_8_b_tmp , 7'b0}};
  assign div_mgc_div_8_a = {reg_div_mgc_div_8_a_tmp , 14'b0};
  assign and_125_cse = (or_dcpl_17 | (else_7_if_1_acc_tmp[0]) | (~ (else_7_if_1_acc_tmp[1])))
      & main_stage_0_2 & and_dcpl_76 & (else_7_if_1_div_3cyc[1]) & (~ (else_7_if_1_div_3cyc[0]));
  assign div_mgc_div_b = {1'b0, {reg_div_mgc_div_b_tmp , 7'b0}};
  assign div_mgc_div_a = {reg_div_mgc_div_a_tmp , 14'b0};
  assign and_137_cse = and_dcpl_122 & (~((else_7_else_1_if_acc_tmp[0]) | (else_7_else_1_if_acc_tmp[1])));
  assign and_143_cse = (or_dcpl_36 | (else_7_else_1_if_acc_tmp[0]) | (else_7_else_1_if_acc_tmp[1]))
      & main_stage_0_2 & and_dcpl_126 & (~((else_7_else_1_if_div_3cyc[1]) | (else_7_else_1_if_div_3cyc[0])));
  assign div_mgc_div_4_b = {1'b0, {reg_div_mgc_div_4_b_tmp , 7'b0}};
  assign div_mgc_div_4_a = {reg_div_mgc_div_4_a_tmp , 14'b0};
  assign and_158_cse = and_dcpl_122 & (else_7_else_1_if_acc_tmp[0]) & (~ (else_7_else_1_if_acc_tmp[1]));
  assign and_164_cse = (or_dcpl_36 | (~ (else_7_else_1_if_acc_tmp[0])) | (else_7_else_1_if_acc_tmp[1]))
      & main_stage_0_2 & and_dcpl_126 & (~ (else_7_else_1_if_div_3cyc[1])) & (else_7_else_1_if_div_3cyc[0]);
  assign div_mgc_div_5_b = {1'b0, {reg_div_mgc_div_5_b_tmp , 7'b0}};
  assign div_mgc_div_5_a = {reg_div_mgc_div_5_a_tmp , 14'b0};
  assign and_178_cse = and_dcpl_122 & (~ (else_7_else_1_if_acc_tmp[0])) & (else_7_else_1_if_acc_tmp[1]);
  assign and_184_cse = (or_dcpl_36 | (else_7_else_1_if_acc_tmp[0]) | (~ (else_7_else_1_if_acc_tmp[1])))
      & main_stage_0_2 & and_dcpl_126 & (else_7_else_1_if_div_3cyc[1]) & (~ (else_7_else_1_if_div_3cyc[0]));
  assign div_mgc_div_6_b = {1'b0, {reg_div_mgc_div_6_b_tmp , 7'b0}};
  assign div_mgc_div_6_a = {reg_div_mgc_div_6_a_tmp , 14'b0};
  assign and_198_cse = and_dcpl_182 & and_dcpl_180;
  assign and_204_cse = (or_dcpl_60 | or_dcpl_58) & main_stage_0_2 & and_dcpl_186
      & (~((else_7_else_1_else_div_3cyc[1]) | (else_7_else_1_else_div_3cyc[0])));
  assign div_mgc_div_1_b = {1'b0, {reg_div_mgc_div_1_b_tmp , 7'b0}};
  assign div_mgc_div_1_a = {reg_div_mgc_div_1_a_tmp , 14'b0};
  assign and_218_cse = and_dcpl_121 & (else_7_else_1_else_acc_tmp[0]) & and_dcpl_180;
  assign and_224_cse = (or_dcpl_35 | (~ (else_7_else_1_else_acc_tmp[0])) | or_dcpl_58)
      & main_stage_0_2 & and_dcpl_186 & (~ (else_7_else_1_else_div_3cyc[1])) & (else_7_else_1_else_div_3cyc[0]);
  assign div_mgc_div_2_b = {1'b0, {reg_div_mgc_div_2_b_tmp , 7'b0}};
  assign div_mgc_div_2_a = {reg_div_mgc_div_2_a_tmp , 14'b0};
  assign and_238_cse = and_dcpl_182 & (else_7_else_1_else_acc_tmp[1]) & (~ else_7_else_1_equal_tmp);
  assign and_244_cse = (or_dcpl_60 | (~ (else_7_else_1_else_acc_tmp[1])) | else_7_else_1_equal_tmp)
      & main_stage_0_2 & and_dcpl_186 & (else_7_else_1_else_div_3cyc[1]) & (~ (else_7_else_1_else_div_3cyc[0]));
  assign div_mgc_div_3_b = {1'b0, {reg_div_mgc_div_3_b_tmp , 7'b0}};
  assign div_mgc_div_3_a = {reg_div_mgc_div_3_a_tmp , 14'b0};
  assign div_mgc_div_10_a = {reg_div_mgc_div_10_a_tmp , 7'b0};
  assign div_mgc_div_9_a = {reg_div_mgc_div_9_a_tmp , 7'b0};
  assign or_173_cse = or_dcpl_103 | or_dcpl_100;
  assign and_337_cse = (~((max_sg1_lpi_dfm_3_st_2[6]) | (max_sg1_lpi_dfm_3_st_2[5])))
      & (~((max_sg1_lpi_dfm_3_st_2[4]) | (max_sg1_lpi_dfm_3_st_2[3]))) & (~((max_sg1_lpi_dfm_3_st_2[2])
      | (max_sg1_lpi_dfm_3_st_2[1]) | (max_sg1_lpi_dfm_3_st_2[0])));
  assign else_7_mux1h_2_nl = MUX1HOT_v_2_3_2({else_7_else_1_else_slc_else_7_else_1_else_ac_fixed_cctor_sg1_itm_1
      , else_7_else_1_if_slc_else_7_else_1_if_ac_fixed_cctor_sg1_itm_1 , else_7_if_1_slc_else_7_if_1_ac_fixed_cctor_5_itm_1},
      {(~(else_7_else_1_equal_svs_4 | else_7_equal_svs_4)) , (else_7_else_1_equal_svs_4
      & (~ else_7_equal_svs_4)) , else_7_equal_svs_4});
  assign else_7_else_1_mux_nl = MUX_s_1_2_2({else_7_else_1_else_slc_else_7_else_1_else_ac_fixed_cctor_sg1_2_itm_1
      , else_7_else_1_if_slc_else_7_else_1_if_ac_fixed_cctor_sg1_3_itm_1}, else_7_else_1_equal_svs_4);
  assign else_7_mux_4_nl = MUX_s_1_2_2({(else_7_else_1_mux_nl) , else_7_if_1_slc_else_7_if_1_ac_fixed_cctor_6_itm_1},
      else_7_equal_svs_4);
  assign else_7_else_1_mux_1_nl = MUX_s_1_2_2({else_7_else_1_else_slc_div_sdt_1_5_itm_1
      , else_7_else_1_if_slc_else_7_else_1_if_ac_fixed_cctor_sg1_4_itm_1}, else_7_else_1_equal_svs_4);
  assign else_7_mux_5_nl = MUX_s_1_2_2({(else_7_else_1_mux_1_nl) , else_7_if_1_slc_else_7_if_1_ac_fixed_cctor_itm_1},
      else_7_equal_svs_4);
  assign nl_else_7_acc_itm = ({h_sg1_lpi_dfm_3 , h_1_lpi_dfm_3 , 5'b1}) + ({(~ (else_7_mux1h_2_nl))
      , (~ (else_7_mux_4_nl)) , (~ (else_7_mux_5_nl)) , (~ h_sg1_lpi_dfm_3) , (~
      h_1_lpi_dfm_3) , 1'b1});
  assign else_7_acc_itm = nl_else_7_acc_itm[12:0];
  assign h_sg1_1_sg1_lpi_dfm = (else_7_acc_itm[6:5]) & (signext_2_1(~ if_7_equal_svs_4));
  assign mux1h_18_tmp = MUX1HOT_v_7_3_2({(R_IN_rsc_mgc_in_wire_d[6:0]) , (B_IN_rsc_mgc_in_wire_d[6:0])
      , (G_IN_rsc_mgc_in_wire_d[6:0])}, {(~((if_if_acc_1_itm[8]) | (if_acc_itm[8])))
      , (((if_if_acc_1_itm[8]) & (~ (if_acc_itm[8]))) | ((else_1_if_acc_1_itm[8])
      & (if_acc_itm[8]))) , ((~ (else_1_if_acc_1_itm[8])) & (if_acc_itm[8]))});
  assign nl_else_7_acc_3_itm = ({mux1h_18_tmp , 1'b1}) + ({(~ min_sg1_lpi_dfm_3)
      , 1'b1});
  assign else_7_acc_3_itm = nl_else_7_acc_3_itm[7:0];
  assign nl_else_7_if_1_acc_1_itm = ({1'b1 , g_sg1_lpi_dfm , 1'b1}) + conv_u2u_8_9({(~
      b_sg1_lpi_dfm) , 1'b1});
  assign else_7_if_1_acc_1_itm = nl_else_7_if_1_acc_1_itm[8:0];
  assign nl_else_7_else_1_if_acc_2_itm = ({1'b1 , b_sg1_lpi_dfm , 1'b1}) + conv_u2u_8_9({(~
      r_sg1_lpi_dfm) , 1'b1});
  assign else_7_else_1_if_acc_2_itm = nl_else_7_else_1_if_acc_2_itm[8:0];
  assign nl_else_7_else_1_else_acc_2_itm = ({1'b1 , r_sg1_lpi_dfm , 1'b1}) + conv_u2u_8_9({(~
      g_sg1_lpi_dfm) , 1'b1});
  assign else_7_else_1_else_acc_2_itm = nl_else_7_else_1_else_acc_2_itm[8:0];
  assign else_7_equal_tmp = r_sg1_lpi_dfm == mux1h_18_tmp;
  assign if_7_equal_tmp = mux1h_18_tmp == min_sg1_lpi_dfm_3;
  assign nl_if_if_acc_1_itm = ({1'b1 , (R_IN_rsc_mgc_in_wire_d[6:0]) , 1'b1}) + conv_u2u_8_9({(~
      (B_IN_rsc_mgc_in_wire_d[6:0])) , 1'b1});
  assign if_if_acc_1_itm = nl_if_if_acc_1_itm[8:0];
  assign nl_else_1_if_acc_1_itm = ({1'b1 , (G_IN_rsc_mgc_in_wire_d[6:0]) , 1'b1})
      + conv_u2u_8_9({(~ (B_IN_rsc_mgc_in_wire_d[6:0])) , 1'b1});
  assign else_1_if_acc_1_itm = nl_else_1_if_acc_1_itm[8:0];
  assign nl_if_3_if_acc_1_itm = ({1'b1 , (B_IN_rsc_mgc_in_wire_d[6:0]) , 1'b1}) +
      conv_u2u_8_9({(~ (R_IN_rsc_mgc_in_wire_d[6:0])) , 1'b1});
  assign if_3_if_acc_1_itm = nl_if_3_if_acc_1_itm[8:0];
  assign nl_else_5_if_acc_1_itm = ({1'b1 , (B_IN_rsc_mgc_in_wire_d[6:0]) , 1'b1})
      + conv_u2u_8_9({(~ (G_IN_rsc_mgc_in_wire_d[6:0])) , 1'b1});
  assign else_5_if_acc_1_itm = nl_else_5_if_acc_1_itm[8:0];
  assign nl_else_7_if_1_acc_tmp = conv_u2u_1_2(acc_imod[0]) + conv_u2u_1_2(acc_imod[1]);
  assign else_7_if_1_acc_tmp = nl_else_7_if_1_acc_tmp[1:0];
  assign nl_acc_imod = conv_s2s_1_2(else_7_if_1_acc_idiv[1]) + conv_u2s_1_2(else_7_if_1_acc_idiv[0]);
  assign acc_imod = nl_acc_imod[1:0];
  assign nl_else_7_if_1_acc_idiv = else_7_if_1_div_3cyc + 2'b1;
  assign else_7_if_1_acc_idiv = nl_else_7_if_1_acc_idiv[1:0];
  assign g_sg1_lpi_dfm = (G_IN_rsc_mgc_in_wire_d[6:0]) & ({{6{unequal_tmp}}, unequal_tmp});
  assign b_sg1_lpi_dfm = (B_IN_rsc_mgc_in_wire_d[6:0]) & ({{6{unequal_tmp}}, unequal_tmp});
  assign nl_else_7_else_1_if_acc_tmp = conv_u2u_1_2(acc_imod_1[0]) + conv_u2u_1_2(acc_imod_1[1]);
  assign else_7_else_1_if_acc_tmp = nl_else_7_else_1_if_acc_tmp[1:0];
  assign nl_acc_imod_1 = conv_s2s_1_2(else_7_else_1_if_acc_idiv[1]) + conv_u2s_1_2(else_7_else_1_if_acc_idiv[0]);
  assign acc_imod_1 = nl_acc_imod_1[1:0];
  assign nl_else_7_else_1_if_acc_idiv = else_7_else_1_if_div_3cyc + 2'b1;
  assign else_7_else_1_if_acc_idiv = nl_else_7_else_1_if_acc_idiv[1:0];
  assign r_sg1_lpi_dfm = (R_IN_rsc_mgc_in_wire_d[6:0]) & ({{6{unequal_tmp}}, unequal_tmp});
  assign nl_else_7_else_1_else_acc_tmp = conv_u2u_1_2(acc_imod_2[0]) + conv_u2u_1_2(acc_imod_2[1]);
  assign else_7_else_1_else_acc_tmp = nl_else_7_else_1_else_acc_tmp[1:0];
  assign nl_acc_imod_2 = conv_s2s_1_2(else_7_else_1_else_acc_idiv[1]) + conv_u2s_1_2(else_7_else_1_else_acc_idiv[0]);
  assign acc_imod_2 = nl_acc_imod_2[1:0];
  assign nl_else_7_else_1_else_acc_idiv = else_7_else_1_else_div_3cyc + 2'b1;
  assign else_7_else_1_else_acc_idiv = nl_else_7_else_1_else_acc_idiv[1:0];
  assign unequal_tmp = (mux1h_18_tmp[6]) | (mux1h_18_tmp[5]) | (mux1h_18_tmp[4])
      | (mux1h_18_tmp[3]) | (mux1h_18_tmp[2]) | (mux1h_18_tmp[1]) | (mux1h_18_tmp[0]);
  assign min_sg1_lpi_dfm_3 = MUX1HOT_v_7_3_2({(R_IN_rsc_mgc_in_wire_d[6:0]) , (B_IN_rsc_mgc_in_wire_d[6:0])
      , (G_IN_rsc_mgc_in_wire_d[6:0])}, {(~((if_3_if_acc_1_itm[8]) | (if_3_acc_itm[8])))
      , (((if_3_if_acc_1_itm[8]) & (~ (if_3_acc_itm[8]))) | ((else_5_if_acc_1_itm[8])
      & (if_3_acc_itm[8]))) , ((~ (else_5_if_acc_1_itm[8])) & (if_3_acc_itm[8]))});
  assign nl_if_3_acc_itm = ({1'b1 , (G_IN_rsc_mgc_in_wire_d[6:0]) , 1'b1}) + conv_u2u_8_9({(~
      (R_IN_rsc_mgc_in_wire_d[6:0])) , 1'b1});
  assign if_3_acc_itm = nl_if_3_acc_itm[8:0];
  assign nl_if_acc_itm = ({1'b1 , (R_IN_rsc_mgc_in_wire_d[6:0]) , 1'b1}) + conv_u2u_8_9({(~
      (G_IN_rsc_mgc_in_wire_d[6:0])) , 1'b1});
  assign if_acc_itm = nl_if_acc_itm[8:0];
  assign else_7_if_1_ac_fixed_cctor_1_sva_duc_mx0 = MUX1HOT_v_12_4_2({(div_mgc_div_7_z[11:0])
      , (div_mgc_div_8_z[11:0]) , (div_mgc_div_z[11:0]) , else_7_if_1_ac_fixed_cctor_1_sva_duc},
      {and_dcpl_246 , and_dcpl_247 , and_dcpl_248 , and_dcpl_249});
  assign div_sdt_2_sva_duc_mx0 = MUX1HOT_v_12_4_2({(div_mgc_div_4_z[11:0]) , (div_mgc_div_5_z[11:0])
      , (div_mgc_div_6_z[11:0]) , div_sdt_2_sva_duc}, {(~((else_7_else_1_if_div_3cyc_st_3[1])
      | (else_7_else_1_if_div_3cyc_st_3[0]))) , ((~ (else_7_else_1_if_div_3cyc_st_3[1]))
      & (else_7_else_1_if_div_3cyc_st_3[0])) , ((else_7_else_1_if_div_3cyc_st_3[1])
      & (~ (else_7_else_1_if_div_3cyc_st_3[0]))) , and_dcpl_266});
  assign nl_else_7_else_1_if_ac_fixed_cctor_sg1_1_sva = (div_sdt_2_sva_duc_mx0[11:8])
      + 4'b1;
  assign else_7_else_1_if_ac_fixed_cctor_sg1_1_sva = nl_else_7_else_1_if_ac_fixed_cctor_sg1_1_sva[3:0];
  assign div_sdt_3_sva_duc_mx0 = MUX1HOT_v_12_4_2({(div_mgc_div_1_z[11:0]) , (div_mgc_div_2_z[11:0])
      , (div_mgc_div_3_z[11:0]) , div_sdt_3_sva_duc}, {(~((else_7_else_1_else_div_3cyc_st_3[1])
      | (else_7_else_1_else_div_3cyc_st_3[0]))) , ((~ (else_7_else_1_else_div_3cyc_st_3[1]))
      & (else_7_else_1_else_div_3cyc_st_3[0])) , ((else_7_else_1_else_div_3cyc_st_3[1])
      & (~ (else_7_else_1_else_div_3cyc_st_3[0]))) , and_dcpl_286});
  assign nl_else_7_else_1_else_ac_fixed_cctor_sg1_1_sva = (div_sdt_3_sva_duc_mx0[11:9])
      + 3'b1;
  assign else_7_else_1_else_ac_fixed_cctor_sg1_1_sva = nl_else_7_else_1_else_ac_fixed_cctor_sg1_1_sva[2:0];
  assign else_7_nor_cse = ~(else_7_else_1_equal_svs_st_3 | else_7_equal_svs_st_3);
  assign else_7_and_5_cse = else_7_else_1_equal_svs_st_3 & (~ else_7_equal_svs_st_3);
  assign mux1h_26_nl = MUX1HOT_v_14_3_2({div_mgc_div_10_z , div_mgc_div_9_z , s_sva_2_duc},
      {(~((~(or_dcpl_103 | or_dcpl_100)) | else_7_if_div_2cyc_st_2)) , (or_173_cse
      & else_7_if_div_2cyc_st_2) , and_337_cse});
  assign nl_mul_1_itm = conv_u2u_14_15((mux1h_26_nl) & ({{13{unequal_tmp_2}}, unequal_tmp_2})
      & (signext_14_1(~ if_7_equal_svs_st_2))) * 15'b11001;
  assign mul_1_itm = nl_mul_1_itm[14:0];
  assign else_7_else_1_equal_tmp = g_sg1_lpi_dfm == mux1h_18_tmp;
  assign and_13_cse = main_stage_0_4 & (~ if_7_equal_svs_st_3);
  assign and_dcpl_28 = main_stage_0_3 & (~ if_7_equal_svs_st_2);
  assign and_dcpl_73 = else_7_equal_tmp & (~ if_7_equal_tmp);
  assign and_88_cse = and_dcpl_73 & (~((else_7_if_1_acc_tmp[0]) | (else_7_if_1_acc_tmp[1])));
  assign and_dcpl_76 = (~ if_7_equal_svs_st_1) & else_7_equal_svs_st_1;
  assign or_dcpl_17 = (~ else_7_equal_tmp) | if_7_equal_tmp;
  assign or_tmp_22 = (else_7_if_1_acc_tmp[1]) | (else_7_if_1_acc_tmp[0]) | if_7_equal_tmp;
  assign or_tmp_26 = (~ else_7_equal_svs_st_1) | if_7_equal_svs_st_1 | (~ main_stage_0_2);
  assign not_tmp_41 = ~(else_7_equal_tmp | (~ or_tmp_26));
  assign mux_21_nl = MUX_s_1_2_2({not_tmp_41 , or_tmp_26}, or_tmp_22);
  assign mux_tmp_12 = MUX_s_1_2_2({(mux_21_nl) , (or_tmp_22 | (~ else_7_equal_tmp))},
      (else_7_if_1_div_3cyc[0]) | (else_7_if_1_div_3cyc[1]));
  assign and_104_cse = and_dcpl_73 & (else_7_if_1_acc_tmp[0]) & (~ (else_7_if_1_acc_tmp[1]));
  assign or_tmp_29 = (else_7_if_1_acc_tmp[1]) | (~ (else_7_if_1_acc_tmp[0])) | if_7_equal_tmp;
  assign mux_23_nl = MUX_s_1_2_2({not_tmp_41 , or_tmp_26}, or_tmp_29);
  assign mux_tmp_14 = MUX_s_1_2_2({(mux_23_nl) , (or_tmp_29 | (~ else_7_equal_tmp))},
      (~ (else_7_if_1_div_3cyc[0])) | (else_7_if_1_div_3cyc[1]));
  assign and_120_cse = and_dcpl_73 & (~ (else_7_if_1_acc_tmp[0])) & (else_7_if_1_acc_tmp[1]);
  assign or_tmp_32 = (~ (else_7_if_1_acc_tmp[1])) | (else_7_if_1_acc_tmp[0]) | if_7_equal_tmp;
  assign mux_25_nl = MUX_s_1_2_2({not_tmp_41 , or_tmp_26}, or_tmp_32);
  assign mux_tmp_16 = MUX_s_1_2_2({(or_tmp_32 | (~ else_7_equal_tmp)) , (mux_25_nl)},
      ~((else_7_if_1_div_3cyc[0]) | (~ (else_7_if_1_div_3cyc[1]))));
  assign and_dcpl_121 = ~(else_7_equal_tmp | if_7_equal_tmp);
  assign and_dcpl_122 = and_dcpl_121 & else_7_else_1_equal_tmp;
  assign and_dcpl_125 = ~(if_7_equal_svs_st_1 | else_7_equal_svs_st_1);
  assign and_dcpl_126 = and_dcpl_125 & else_7_else_1_equal_svs_1;
  assign or_dcpl_35 = else_7_equal_tmp | if_7_equal_tmp;
  assign or_dcpl_36 = or_dcpl_35 | (~ else_7_else_1_equal_tmp);
  assign or_tmp_37 = if_7_equal_tmp | else_7_equal_tmp;
  assign and_tmp_1 = or_tmp_37 & (else_7_equal_svs_st_1 | if_7_equal_svs_st_1 | (~
      main_stage_0_2));
  assign mux_tmp_17 = MUX_s_1_2_2({or_tmp_37 , and_tmp_1}, else_7_else_1_equal_svs_1);
  assign or_tmp_42 = (~ else_7_else_1_equal_svs_1) | else_7_equal_svs_st_1 | if_7_equal_svs_st_1
      | (~ main_stage_0_2);
  assign mux_28_nl = MUX_s_1_2_2({or_tmp_42 , mux_tmp_17}, ~((else_7_else_1_if_acc_tmp[1])
      | (else_7_else_1_if_acc_tmp[0]) | (~ else_7_else_1_equal_tmp)));
  assign mux_tmp_19 = MUX_s_1_2_2({(mux_28_nl) , ((else_7_else_1_if_acc_tmp[1]) |
      (else_7_else_1_if_acc_tmp[0]) | (~ else_7_else_1_equal_tmp) | if_7_equal_tmp
      | else_7_equal_tmp)}, (else_7_else_1_if_div_3cyc[0]) | (else_7_else_1_if_div_3cyc[1]));
  assign mux_30_nl = MUX_s_1_2_2({or_tmp_42 , mux_tmp_17}, ~((else_7_else_1_if_acc_tmp[1])
      | (~ (else_7_else_1_if_acc_tmp[0])) | (~ else_7_else_1_equal_tmp)));
  assign mux_tmp_21 = MUX_s_1_2_2({(mux_30_nl) , ((else_7_else_1_if_acc_tmp[1]) |
      (~ (else_7_else_1_if_acc_tmp[0])) | (~ else_7_else_1_equal_tmp) | if_7_equal_tmp
      | else_7_equal_tmp)}, (~ (else_7_else_1_if_div_3cyc[0])) | (else_7_else_1_if_div_3cyc[1]));
  assign mux_32_nl = MUX_s_1_2_2({or_tmp_42 , mux_tmp_17}, ~((~ (else_7_else_1_if_acc_tmp[1]))
      | (else_7_else_1_if_acc_tmp[0]) | (~ else_7_else_1_equal_tmp)));
  assign mux_tmp_23 = MUX_s_1_2_2({((~ (else_7_else_1_if_acc_tmp[1])) | (else_7_else_1_if_acc_tmp[0])
      | (~ else_7_else_1_equal_tmp) | if_7_equal_tmp | else_7_equal_tmp) , (mux_32_nl)},
      ~((else_7_else_1_if_div_3cyc[0]) | (~ (else_7_else_1_if_div_3cyc[1]))));
  assign and_dcpl_180 = ~((else_7_else_1_else_acc_tmp[1]) | else_7_else_1_equal_tmp);
  assign and_dcpl_182 = and_dcpl_121 & (~ (else_7_else_1_else_acc_tmp[0]));
  assign and_dcpl_186 = and_dcpl_125 & (~ else_7_else_1_equal_svs_1);
  assign or_dcpl_58 = (else_7_else_1_else_acc_tmp[1]) | else_7_else_1_equal_tmp;
  assign or_dcpl_60 = or_dcpl_35 | (else_7_else_1_else_acc_tmp[0]);
  assign or_tmp_50 = else_7_else_1_equal_svs_1 | else_7_equal_svs_st_1 | if_7_equal_svs_st_1
      | (~ main_stage_0_2);
  assign mux_tmp_24 = MUX_s_1_2_2({and_tmp_1 , or_tmp_37}, else_7_else_1_equal_svs_1);
  assign mux_35_nl = MUX_s_1_2_2({mux_tmp_24 , or_tmp_50}, else_7_else_1_equal_tmp
      | (else_7_else_1_else_acc_tmp[1]) | (else_7_else_1_else_acc_tmp[0]));
  assign mux_tmp_26 = MUX_s_1_2_2({(mux_35_nl) , (else_7_else_1_equal_tmp | (else_7_else_1_else_acc_tmp[1])
      | (else_7_else_1_else_acc_tmp[0]) | if_7_equal_tmp | else_7_equal_tmp)}, (else_7_else_1_else_div_3cyc[0])
      | (else_7_else_1_else_div_3cyc[1]));
  assign mux_37_nl = MUX_s_1_2_2({or_tmp_50 , mux_tmp_24}, ~(else_7_else_1_equal_tmp
      | (else_7_else_1_else_acc_tmp[1]) | (~ (else_7_else_1_else_acc_tmp[0]))));
  assign mux_tmp_28 = MUX_s_1_2_2({(mux_37_nl) , (else_7_else_1_equal_tmp | (else_7_else_1_else_acc_tmp[1])
      | (~ (else_7_else_1_else_acc_tmp[0])) | if_7_equal_tmp | else_7_equal_tmp)},
      (~ (else_7_else_1_else_div_3cyc[0])) | (else_7_else_1_else_div_3cyc[1]));
  assign mux_39_nl = MUX_s_1_2_2({mux_tmp_24 , or_tmp_50}, else_7_else_1_equal_tmp
      | (~ (else_7_else_1_else_acc_tmp[1])) | (else_7_else_1_else_acc_tmp[0]));
  assign mux_tmp_30 = MUX_s_1_2_2({(else_7_else_1_equal_tmp | (~ (else_7_else_1_else_acc_tmp[1]))
      | (else_7_else_1_else_acc_tmp[0]) | if_7_equal_tmp | else_7_equal_tmp) , (mux_39_nl)},
      ~((else_7_else_1_else_div_3cyc[0]) | (~ (else_7_else_1_else_div_3cyc[1]))));
  assign and_dcpl_246 = ~((else_7_if_1_div_3cyc_st_3[1]) | (else_7_if_1_div_3cyc_st_3[0]));
  assign and_dcpl_247 = (~ (else_7_if_1_div_3cyc_st_3[1])) & (else_7_if_1_div_3cyc_st_3[0]);
  assign and_dcpl_248 = (else_7_if_1_div_3cyc_st_3[1]) & (~ (else_7_if_1_div_3cyc_st_3[0]));
  assign and_dcpl_249 = (else_7_if_1_div_3cyc_st_3[1]) & (else_7_if_1_div_3cyc_st_3[0]);
  assign or_dcpl_88 = (~ main_stage_0_4) | if_7_equal_svs_st_3;
  assign and_dcpl_266 = (else_7_else_1_if_div_3cyc_st_3[1]) & (else_7_else_1_if_div_3cyc_st_3[0]);
  assign and_dcpl_267 = else_7_else_1_equal_svs_st_3 & (~ (else_7_else_1_if_div_3cyc_st_3[1]));
  assign and_dcpl_270 = and_13_cse & (~ else_7_equal_svs_st_3);
  assign or_dcpl_93 = or_dcpl_88 | else_7_equal_svs_st_3;
  assign and_dcpl_286 = (else_7_else_1_else_div_3cyc_st_3[1]) & (else_7_else_1_else_div_3cyc_st_3[0]);
  assign and_dcpl_287 = ~(else_7_else_1_equal_svs_st_3 | (else_7_else_1_else_div_3cyc_st_3[1]));
  assign or_dcpl_100 = (max_sg1_lpi_dfm_3_st_2[2]) | (max_sg1_lpi_dfm_3_st_2[1])
      | (max_sg1_lpi_dfm_3_st_2[0]);
  assign or_dcpl_103 = (max_sg1_lpi_dfm_3_st_2[6]) | (max_sg1_lpi_dfm_3_st_2[5])
      | (max_sg1_lpi_dfm_3_st_2[4]) | (max_sg1_lpi_dfm_3_st_2[3]);
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      S_OUT_rsc_mgc_out_stdreg_d <= 10'b0;
      H_OUT_rsc_mgc_out_stdreg_d <= 10'b0;
      h_sg1_lpi_dfm_3 <= 6'b0;
      h_1_lpi_dfm_3 <= 2'b0;
      else_7_else_1_else_slc_else_7_else_1_else_ac_fixed_cctor_sg1_itm_1 <= 2'b0;
      else_7_else_1_equal_svs_4 <= 1'b0;
      else_7_equal_svs_4 <= 1'b0;
      else_7_else_1_if_slc_else_7_else_1_if_ac_fixed_cctor_sg1_itm_1 <= 2'b0;
      else_7_if_1_slc_else_7_if_1_ac_fixed_cctor_5_itm_1 <= 2'b0;
      else_7_else_1_else_slc_else_7_else_1_else_ac_fixed_cctor_sg1_2_itm_1 <= 1'b0;
      else_7_else_1_if_slc_else_7_else_1_if_ac_fixed_cctor_sg1_3_itm_1 <= 1'b0;
      else_7_if_1_slc_else_7_if_1_ac_fixed_cctor_6_itm_1 <= 1'b0;
      else_7_else_1_else_slc_div_sdt_1_5_itm_1 <= 1'b0;
      else_7_else_1_if_slc_else_7_else_1_if_ac_fixed_cctor_sg1_4_itm_1 <= 1'b0;
      else_7_if_1_slc_else_7_if_1_ac_fixed_cctor_itm_1 <= 1'b0;
      acc_3_itm_2 <= 10'b0;
      if_7_equal_svs_4 <= 1'b0;
      else_7_if_1_div_3cyc_st_3 <= 2'b0;
      else_7_else_1_if_div_3cyc_st_3 <= 2'b0;
      else_7_else_1_else_div_3cyc_st_3 <= 2'b0;
      else_7_else_1_equal_svs_st_3 <= 1'b0;
      else_7_equal_svs_st_3 <= 1'b0;
      if_7_equal_svs_st_3 <= 1'b0;
      else_7_if_div_2cyc_st_2 <= 1'b0;
      mut_24_sg1_1 <= 7'b0;
      else_7_if_1_conc_tmp_mut_6_sg1 <= 8'b0;
      else_7_if_1_div_3cyc_st_2 <= 2'b0;
      else_7_else_1_if_conc_tmp_mut_4_sg1 <= 8'b0;
      else_7_else_1_if_div_3cyc_st_2 <= 2'b0;
      else_7_else_1_else_conc_tmp_mut_4_sg1 <= 8'b0;
      else_7_else_1_else_div_3cyc_st_2 <= 2'b0;
      else_7_else_1_equal_svs_st_2 <= 1'b0;
      else_7_equal_svs_st_2 <= 1'b0;
      max_sg1_lpi_dfm_3_st_2 <= 7'b0;
      if_7_equal_svs_st_2 <= 1'b0;
      div_mgc_div_10_b <= 7'b0;
      div_mgc_div_9_b <= 7'b0;
      max_sg1_lpi_dfm_3_mut_3 <= 7'b0;
      else_7_if_conc_tmp_mut_3_sg1 <= 7'b0;
      else_7_if_1_conc_tmp_mut_5_sg1 <= 8'b0;
      else_7_else_1_if_conc_tmp_mut_3_sg1 <= 8'b0;
      else_7_else_1_else_conc_tmp_mut_3_sg1 <= 8'b0;
      else_7_equal_svs_st_1 <= 1'b0;
      if_7_equal_svs_st_1 <= 1'b0;
      else_7_if_div_2cyc <= 1'b0;
      else_7_if_1_div_3cyc <= 2'b0;
      else_7_else_1_if_div_3cyc <= 2'b0;
      else_7_else_1_else_div_3cyc <= 2'b0;
      main_stage_0_2 <= 1'b0;
      main_stage_0_3 <= 1'b0;
      main_stage_0_4 <= 1'b0;
      main_stage_0_5 <= 1'b0;
      else_7_if_1_ac_fixed_cctor_1_sva_duc <= 12'b0;
      div_sdt_2_sva_duc <= 12'b0;
      div_sdt_3_sva_duc <= 12'b0;
      acc_3_itm_1 <= 10'b0;
      s_sva_2_duc <= 14'b0;
      unequal_tmp_2 <= 1'b0;
      unequal_tmp_1 <= 1'b0;
      else_7_else_1_equal_svs_1 <= 1'b0;
      reg_div_mgc_div_7_b_tmp <= 7'b0;
      reg_div_mgc_div_7_a_tmp <= 8'b0;
      reg_div_mgc_div_8_b_tmp <= 7'b0;
      reg_div_mgc_div_8_a_tmp <= 8'b0;
      reg_div_mgc_div_b_tmp <= 7'b0;
      reg_div_mgc_div_a_tmp <= 8'b0;
      reg_div_mgc_div_4_b_tmp <= 7'b0;
      reg_div_mgc_div_4_a_tmp <= 8'b0;
      reg_div_mgc_div_5_b_tmp <= 7'b0;
      reg_div_mgc_div_5_a_tmp <= 8'b0;
      reg_div_mgc_div_6_b_tmp <= 7'b0;
      reg_div_mgc_div_6_a_tmp <= 8'b0;
      reg_div_mgc_div_1_b_tmp <= 7'b0;
      reg_div_mgc_div_1_a_tmp <= 8'b0;
      reg_div_mgc_div_2_b_tmp <= 7'b0;
      reg_div_mgc_div_2_a_tmp <= 8'b0;
      reg_div_mgc_div_3_b_tmp <= 7'b0;
      reg_div_mgc_div_3_a_tmp <= 8'b0;
      reg_div_mgc_div_10_a_tmp <= 7'b0;
      reg_div_mgc_div_9_a_tmp <= 7'b0;
    end
    else begin
      S_OUT_rsc_mgc_out_stdreg_d <= MUX_v_10_2_2({S_OUT_rsc_mgc_out_stdreg_d , acc_3_itm_2},
          main_stage_0_5);
      H_OUT_rsc_mgc_out_stdreg_d <= MUX_v_10_2_2({H_OUT_rsc_mgc_out_stdreg_d , ({2'b0
          , (conv_u2u_7_8({((else_7_acc_itm[12:9]) & (signext_4_1(~ if_7_equal_svs_4)))
          , ((else_7_acc_itm[8]) & (~ if_7_equal_svs_4)) , ((else_7_acc_itm[7]) &
          (~ if_7_equal_svs_4)) , (h_sg1_1_sg1_lpi_dfm[1])}) + conv_u2u_1_8(h_sg1_1_sg1_lpi_dfm[0]))})},
          main_stage_0_5);
      h_sg1_lpi_dfm_3 <= MUX1HOT_v_6_3_2({(div_sdt_3_sva_duc_mx0[7:2]) , (div_sdt_2_sva_duc_mx0[7:2])
          , (else_7_if_1_ac_fixed_cctor_1_sva_duc_mx0[7:2])}, {else_7_nor_cse , else_7_and_5_cse
          , else_7_equal_svs_st_3});
      h_1_lpi_dfm_3 <= MUX1HOT_v_2_3_2({(div_sdt_3_sva_duc_mx0[1:0]) , (div_sdt_2_sva_duc_mx0[1:0])
          , (else_7_if_1_ac_fixed_cctor_1_sva_duc_mx0[1:0])}, {else_7_nor_cse , else_7_and_5_cse
          , else_7_equal_svs_st_3});
      else_7_else_1_else_slc_else_7_else_1_else_ac_fixed_cctor_sg1_itm_1 <= else_7_else_1_else_ac_fixed_cctor_sg1_1_sva[2:1];
      else_7_else_1_equal_svs_4 <= else_7_else_1_equal_svs_st_3;
      else_7_equal_svs_4 <= else_7_equal_svs_st_3;
      else_7_else_1_if_slc_else_7_else_1_if_ac_fixed_cctor_sg1_itm_1 <= else_7_else_1_if_ac_fixed_cctor_sg1_1_sva[3:2];
      else_7_if_1_slc_else_7_if_1_ac_fixed_cctor_5_itm_1 <= else_7_if_1_ac_fixed_cctor_1_sva_duc_mx0[11:10];
      else_7_else_1_else_slc_else_7_else_1_else_ac_fixed_cctor_sg1_2_itm_1 <= else_7_else_1_else_ac_fixed_cctor_sg1_1_sva[0];
      else_7_else_1_if_slc_else_7_else_1_if_ac_fixed_cctor_sg1_3_itm_1 <= else_7_else_1_if_ac_fixed_cctor_sg1_1_sva[1];
      else_7_if_1_slc_else_7_if_1_ac_fixed_cctor_6_itm_1 <= else_7_if_1_ac_fixed_cctor_1_sva_duc_mx0[9];
      else_7_else_1_else_slc_div_sdt_1_5_itm_1 <= div_sdt_3_sva_duc_mx0[8];
      else_7_else_1_if_slc_else_7_else_1_if_ac_fixed_cctor_sg1_4_itm_1 <= else_7_else_1_if_ac_fixed_cctor_sg1_1_sva[0];
      else_7_if_1_slc_else_7_if_1_ac_fixed_cctor_itm_1 <= else_7_if_1_ac_fixed_cctor_1_sva_duc_mx0[8];
      acc_3_itm_2 <= acc_3_itm_1;
      if_7_equal_svs_4 <= if_7_equal_svs_st_3;
      else_7_if_1_div_3cyc_st_3 <= else_7_if_1_div_3cyc_st_2;
      else_7_else_1_if_div_3cyc_st_3 <= else_7_else_1_if_div_3cyc_st_2;
      else_7_else_1_else_div_3cyc_st_3 <= else_7_else_1_else_div_3cyc_st_2;
      else_7_else_1_equal_svs_st_3 <= else_7_else_1_equal_svs_st_2;
      else_7_equal_svs_st_3 <= else_7_equal_svs_st_2;
      if_7_equal_svs_st_3 <= if_7_equal_svs_st_2;
      else_7_if_div_2cyc_st_2 <= else_7_if_div_2cyc;
      mut_24_sg1_1 <= else_7_if_conc_tmp_mut_3_sg1;
      else_7_if_1_conc_tmp_mut_6_sg1 <= else_7_if_1_conc_tmp_mut_5_sg1;
      else_7_if_1_div_3cyc_st_2 <= else_7_if_1_div_3cyc;
      else_7_else_1_if_conc_tmp_mut_4_sg1 <= else_7_else_1_if_conc_tmp_mut_3_sg1;
      else_7_else_1_if_div_3cyc_st_2 <= else_7_else_1_if_div_3cyc;
      else_7_else_1_else_conc_tmp_mut_4_sg1 <= else_7_else_1_else_conc_tmp_mut_3_sg1;
      else_7_else_1_else_div_3cyc_st_2 <= else_7_else_1_else_div_3cyc;
      else_7_else_1_equal_svs_st_2 <= else_7_else_1_equal_svs_1;
      else_7_equal_svs_st_2 <= else_7_equal_svs_st_1;
      max_sg1_lpi_dfm_3_st_2 <= max_sg1_lpi_dfm_3_mut_3;
      if_7_equal_svs_st_2 <= if_7_equal_svs_st_1;
      div_mgc_div_10_b <= MUX_v_7_2_2({max_sg1_lpi_dfm_3_mut_3 , mux1h_18_tmp}, else_7_if_div_2cyc);
      div_mgc_div_9_b <= MUX_v_7_2_2({mux1h_18_tmp , max_sg1_lpi_dfm_3_mut_3}, else_7_if_div_2cyc);
      max_sg1_lpi_dfm_3_mut_3 <= mux1h_18_tmp;
      else_7_if_conc_tmp_mut_3_sg1 <= else_7_acc_3_itm[7:1];
      else_7_if_1_conc_tmp_mut_5_sg1 <= else_7_if_1_acc_1_itm[8:1];
      else_7_else_1_if_conc_tmp_mut_3_sg1 <= else_7_else_1_if_acc_2_itm[8:1];
      else_7_else_1_else_conc_tmp_mut_3_sg1 <= else_7_else_1_else_acc_2_itm[8:1];
      else_7_equal_svs_st_1 <= else_7_equal_tmp;
      if_7_equal_svs_st_1 <= if_7_equal_tmp;
      else_7_if_div_2cyc <= MUX_s_1_2_2({(~ else_7_if_div_2cyc) , else_7_if_div_2cyc},
          ((~((mux1h_18_tmp[0]) | (mux1h_18_tmp[1]))) & (~((mux1h_18_tmp[2]) | (mux1h_18_tmp[3])))
          & (~((mux1h_18_tmp[4]) | (mux1h_18_tmp[5]) | (mux1h_18_tmp[6])))) | if_7_equal_tmp);
      else_7_if_1_div_3cyc <= MUX_v_2_2_2({else_7_if_1_acc_tmp , else_7_if_1_div_3cyc},
          or_dcpl_17);
      else_7_else_1_if_div_3cyc <= MUX_v_2_2_2({else_7_else_1_if_acc_tmp , else_7_else_1_if_div_3cyc},
          or_dcpl_36);
      else_7_else_1_else_div_3cyc <= MUX_v_2_2_2({else_7_else_1_else_acc_tmp , else_7_else_1_else_div_3cyc},
          or_dcpl_35 | else_7_else_1_equal_tmp);
      main_stage_0_2 <= 1'b1;
      main_stage_0_3 <= main_stage_0_2;
      main_stage_0_4 <= main_stage_0_3;
      main_stage_0_5 <= main_stage_0_4;
      else_7_if_1_ac_fixed_cctor_1_sva_duc <= MUX1HOT_v_12_4_2({(div_mgc_div_7_z[11:0])
          , (div_mgc_div_8_z[11:0]) , (div_mgc_div_z[11:0]) , else_7_if_1_ac_fixed_cctor_1_sva_duc},
          {(and_24_cse & and_dcpl_246) , (and_24_cse & and_dcpl_247) , (and_24_cse
          & and_dcpl_248) , (or_dcpl_88 | (~ else_7_equal_svs_st_3) | and_dcpl_249)});
      div_sdt_2_sva_duc <= MUX1HOT_v_12_4_2({(div_mgc_div_4_z[11:0]) , (div_mgc_div_5_z[11:0])
          , (div_mgc_div_6_z[11:0]) , div_sdt_2_sva_duc}, {(and_dcpl_270 & and_dcpl_267
          & (~ (else_7_else_1_if_div_3cyc_st_3[0]))) , (and_dcpl_270 & and_dcpl_267
          & (else_7_else_1_if_div_3cyc_st_3[0])) , (and_dcpl_270 & else_7_else_1_equal_svs_st_3
          & (else_7_else_1_if_div_3cyc_st_3[1]) & (~ (else_7_else_1_if_div_3cyc_st_3[0])))
          , (or_dcpl_93 | and_dcpl_266 | (~ else_7_else_1_equal_svs_st_3))});
      div_sdt_3_sva_duc <= MUX1HOT_v_12_4_2({(div_mgc_div_1_z[11:0]) , (div_mgc_div_2_z[11:0])
          , (div_mgc_div_3_z[11:0]) , div_sdt_3_sva_duc}, {(and_dcpl_270 & and_dcpl_287
          & (~ (else_7_else_1_else_div_3cyc_st_3[0]))) , (and_dcpl_270 & and_dcpl_287
          & (else_7_else_1_else_div_3cyc_st_3[0])) , (and_dcpl_270 & (~ else_7_else_1_equal_svs_st_3)
          & (else_7_else_1_else_div_3cyc_st_3[1]) & (~ (else_7_else_1_else_div_3cyc_st_3[0])))
          , (or_dcpl_93 | and_dcpl_286 | else_7_else_1_equal_svs_st_3)});
      acc_3_itm_1 <= nl_acc_3_itm_1[9:0];
      s_sva_2_duc <= MUX1HOT_v_14_3_2({div_mgc_div_10_z , div_mgc_div_9_z , s_sva_2_duc},
          {(or_173_cse & and_dcpl_28 & (~ else_7_if_div_2cyc_st_2)) , (or_173_cse
          & and_dcpl_28 & else_7_if_div_2cyc_st_2) , (and_337_cse | (~ main_stage_0_3)
          | if_7_equal_svs_st_2)});
      unequal_tmp_2 <= unequal_tmp_1;
      unequal_tmp_1 <= unequal_tmp;
      else_7_else_1_equal_svs_1 <= else_7_else_1_equal_tmp;
      reg_div_mgc_div_7_b_tmp <= MUX1HOT_v_7_3_2({(else_7_acc_3_itm[7:1]) , else_7_if_conc_tmp_mut_3_sg1
          , mut_24_sg1_1}, {and_88_cse , and_93_cse , mux_tmp_12});
      reg_div_mgc_div_7_a_tmp <= MUX1HOT_v_8_3_2({(else_7_if_1_acc_1_itm[8:1]) ,
          else_7_if_1_conc_tmp_mut_5_sg1 , else_7_if_1_conc_tmp_mut_6_sg1}, {and_88_cse
          , and_93_cse , mux_tmp_12});
      reg_div_mgc_div_8_b_tmp <= MUX1HOT_v_7_3_2({(else_7_acc_3_itm[7:1]) , else_7_if_conc_tmp_mut_3_sg1
          , mut_24_sg1_1}, {and_104_cse , and_109_cse , mux_tmp_14});
      reg_div_mgc_div_8_a_tmp <= MUX1HOT_v_8_3_2({(else_7_if_1_acc_1_itm[8:1]) ,
          else_7_if_1_conc_tmp_mut_5_sg1 , else_7_if_1_conc_tmp_mut_6_sg1}, {and_104_cse
          , and_109_cse , mux_tmp_14});
      reg_div_mgc_div_b_tmp <= MUX1HOT_v_7_3_2({(else_7_acc_3_itm[7:1]) , else_7_if_conc_tmp_mut_3_sg1
          , mut_24_sg1_1}, {and_120_cse , and_125_cse , mux_tmp_16});
      reg_div_mgc_div_a_tmp <= MUX1HOT_v_8_3_2({(else_7_if_1_acc_1_itm[8:1]) , else_7_if_1_conc_tmp_mut_5_sg1
          , else_7_if_1_conc_tmp_mut_6_sg1}, {and_120_cse , and_125_cse , mux_tmp_16});
      reg_div_mgc_div_4_b_tmp <= MUX1HOT_v_7_3_2({(else_7_acc_3_itm[7:1]) , else_7_if_conc_tmp_mut_3_sg1
          , mut_24_sg1_1}, {and_137_cse , and_143_cse , mux_tmp_19});
      reg_div_mgc_div_4_a_tmp <= MUX1HOT_v_8_3_2({(else_7_else_1_if_acc_2_itm[8:1])
          , else_7_else_1_if_conc_tmp_mut_3_sg1 , else_7_else_1_if_conc_tmp_mut_4_sg1},
          {and_137_cse , and_143_cse , mux_tmp_19});
      reg_div_mgc_div_5_b_tmp <= MUX1HOT_v_7_3_2({(else_7_acc_3_itm[7:1]) , else_7_if_conc_tmp_mut_3_sg1
          , mut_24_sg1_1}, {and_158_cse , and_164_cse , mux_tmp_21});
      reg_div_mgc_div_5_a_tmp <= MUX1HOT_v_8_3_2({(else_7_else_1_if_acc_2_itm[8:1])
          , else_7_else_1_if_conc_tmp_mut_3_sg1 , else_7_else_1_if_conc_tmp_mut_4_sg1},
          {and_158_cse , and_164_cse , mux_tmp_21});
      reg_div_mgc_div_6_b_tmp <= MUX1HOT_v_7_3_2({(else_7_acc_3_itm[7:1]) , else_7_if_conc_tmp_mut_3_sg1
          , mut_24_sg1_1}, {and_178_cse , and_184_cse , mux_tmp_23});
      reg_div_mgc_div_6_a_tmp <= MUX1HOT_v_8_3_2({(else_7_else_1_if_acc_2_itm[8:1])
          , else_7_else_1_if_conc_tmp_mut_3_sg1 , else_7_else_1_if_conc_tmp_mut_4_sg1},
          {and_178_cse , and_184_cse , mux_tmp_23});
      reg_div_mgc_div_1_b_tmp <= MUX1HOT_v_7_3_2({(else_7_acc_3_itm[7:1]) , else_7_if_conc_tmp_mut_3_sg1
          , mut_24_sg1_1}, {and_198_cse , and_204_cse , mux_tmp_26});
      reg_div_mgc_div_1_a_tmp <= MUX1HOT_v_8_3_2({(else_7_else_1_else_acc_2_itm[8:1])
          , else_7_else_1_else_conc_tmp_mut_3_sg1 , else_7_else_1_else_conc_tmp_mut_4_sg1},
          {and_198_cse , and_204_cse , mux_tmp_26});
      reg_div_mgc_div_2_b_tmp <= MUX1HOT_v_7_3_2({(else_7_acc_3_itm[7:1]) , else_7_if_conc_tmp_mut_3_sg1
          , mut_24_sg1_1}, {and_218_cse , and_224_cse , mux_tmp_28});
      reg_div_mgc_div_2_a_tmp <= MUX1HOT_v_8_3_2({(else_7_else_1_else_acc_2_itm[8:1])
          , else_7_else_1_else_conc_tmp_mut_3_sg1 , else_7_else_1_else_conc_tmp_mut_4_sg1},
          {and_218_cse , and_224_cse , mux_tmp_28});
      reg_div_mgc_div_3_b_tmp <= MUX1HOT_v_7_3_2({(else_7_acc_3_itm[7:1]) , else_7_if_conc_tmp_mut_3_sg1
          , mut_24_sg1_1}, {and_238_cse , and_244_cse , mux_tmp_30});
      reg_div_mgc_div_3_a_tmp <= MUX1HOT_v_8_3_2({(else_7_else_1_else_acc_2_itm[8:1])
          , else_7_else_1_else_conc_tmp_mut_3_sg1 , else_7_else_1_else_conc_tmp_mut_4_sg1},
          {and_238_cse , and_244_cse , mux_tmp_30});
      reg_div_mgc_div_10_a_tmp <= MUX_v_7_2_2({else_7_if_conc_tmp_mut_3_sg1 , (else_7_acc_3_itm[7:1])},
          else_7_if_div_2cyc);
      reg_div_mgc_div_9_a_tmp <= MUX_v_7_2_2({(else_7_acc_3_itm[7:1]) , else_7_if_conc_tmp_mut_3_sg1},
          else_7_if_div_2cyc);
    end
  end
  assign nl_acc_3_itm_1  = (mul_1_itm[14:5]) + conv_u2u_1_10(mul_1_itm[4]);

  function [1:0] MUX1HOT_v_2_3_2;
    input [5:0] inputs;
    input [2:0] sel;
    reg [1:0] result;
    integer i;
  begin
    result = inputs[0+:2] & {2{sel[0]}};
    for( i = 1; i < 3; i = i + 1 )
      result = result | (inputs[i*2+:2] & {2{sel[i]}});
    MUX1HOT_v_2_3_2 = result;
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


  function [1:0] signext_2_1;
    input [0:0] vector;
  begin
    signext_2_1= {{1{vector[0]}}, vector};
  end
  endfunction


  function [6:0] MUX1HOT_v_7_3_2;
    input [20:0] inputs;
    input [2:0] sel;
    reg [6:0] result;
    integer i;
  begin
    result = inputs[0+:7] & {7{sel[0]}};
    for( i = 1; i < 3; i = i + 1 )
      result = result | (inputs[i*7+:7] & {7{sel[i]}});
    MUX1HOT_v_7_3_2 = result;
  end
  endfunction


  function [11:0] MUX1HOT_v_12_4_2;
    input [47:0] inputs;
    input [3:0] sel;
    reg [11:0] result;
    integer i;
  begin
    result = inputs[0+:12] & {12{sel[0]}};
    for( i = 1; i < 4; i = i + 1 )
      result = result | (inputs[i*12+:12] & {12{sel[i]}});
    MUX1HOT_v_12_4_2 = result;
  end
  endfunction


  function [13:0] MUX1HOT_v_14_3_2;
    input [41:0] inputs;
    input [2:0] sel;
    reg [13:0] result;
    integer i;
  begin
    result = inputs[0+:14] & {14{sel[0]}};
    for( i = 1; i < 3; i = i + 1 )
      result = result | (inputs[i*14+:14] & {14{sel[i]}});
    MUX1HOT_v_14_3_2 = result;
  end
  endfunction


  function [13:0] signext_14_1;
    input [0:0] vector;
  begin
    signext_14_1= {{13{vector[0]}}, vector};
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


  function [3:0] signext_4_1;
    input [0:0] vector;
  begin
    signext_4_1= {{3{vector[0]}}, vector};
  end
  endfunction


  function [5:0] MUX1HOT_v_6_3_2;
    input [17:0] inputs;
    input [2:0] sel;
    reg [5:0] result;
    integer i;
  begin
    result = inputs[0+:6] & {6{sel[0]}};
    for( i = 1; i < 3; i = i + 1 )
      result = result | (inputs[i*6+:6] & {6{sel[i]}});
    MUX1HOT_v_6_3_2 = result;
  end
  endfunction


  function [6:0] MUX_v_7_2_2;
    input [13:0] inputs;
    input [0:0] sel;
    reg [6:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[13:7];
      end
      1'b1 : begin
        result = inputs[6:0];
      end
      default : begin
        result = inputs[13:7];
      end
    endcase
    MUX_v_7_2_2 = result;
  end
  endfunction


  function [1:0] MUX_v_2_2_2;
    input [3:0] inputs;
    input [0:0] sel;
    reg [1:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[3:2];
      end
      1'b1 : begin
        result = inputs[1:0];
      end
      default : begin
        result = inputs[3:2];
      end
    endcase
    MUX_v_2_2_2 = result;
  end
  endfunction


  function [7:0] MUX1HOT_v_8_3_2;
    input [23:0] inputs;
    input [2:0] sel;
    reg [7:0] result;
    integer i;
  begin
    result = inputs[0+:8] & {8{sel[0]}};
    for( i = 1; i < 3; i = i + 1 )
      result = result | (inputs[i*8+:8] & {8{sel[i]}});
    MUX1HOT_v_8_3_2 = result;
  end
  endfunction


  function  [8:0] conv_u2u_8_9 ;
    input [7:0]  vector ;
  begin
    conv_u2u_8_9 = {1'b0, vector};
  end
  endfunction


  function  [1:0] conv_u2u_1_2 ;
    input [0:0]  vector ;
  begin
    conv_u2u_1_2 = {1'b0, vector};
  end
  endfunction


  function signed [1:0] conv_s2s_1_2 ;
    input signed [0:0]  vector ;
  begin
    conv_s2s_1_2 = {vector[0], vector};
  end
  endfunction


  function signed [1:0] conv_u2s_1_2 ;
    input [0:0]  vector ;
  begin
    conv_u2s_1_2 = {1'b0, vector};
  end
  endfunction


  function  [14:0] conv_u2u_14_15 ;
    input [13:0]  vector ;
  begin
    conv_u2u_14_15 = {1'b0, vector};
  end
  endfunction


  function  [7:0] conv_u2u_7_8 ;
    input [6:0]  vector ;
  begin
    conv_u2u_7_8 = {1'b0, vector};
  end
  endfunction


  function  [7:0] conv_u2u_1_8 ;
    input [0:0]  vector ;
  begin
    conv_u2u_1_8 = {{7{1'b0}}, vector};
  end
  endfunction


  function  [9:0] conv_u2u_1_10 ;
    input [0:0]  vector ;
  begin
    conv_u2u_1_10 = {{9{1'b0}}, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    HSVRGB
//  Generated from file(s):
//    2) $PROJECT_HOME/../RGBHSV/RGBHSV.cpp
// ------------------------------------------------------------------


module HSVRGB (
  R_IN_rsc_z, G_IN_rsc_z, B_IN_rsc_z, H_OUT_rsc_z, S_OUT_rsc_z, V_OUT_rsc_z, clk,
      arst_n
);
  input [9:0] R_IN_rsc_z;
  input [9:0] G_IN_rsc_z;
  input [9:0] B_IN_rsc_z;
  output [9:0] H_OUT_rsc_z;
  output [9:0] S_OUT_rsc_z;
  output [9:0] V_OUT_rsc_z;
  input clk;
  input arst_n;


  // Interconnect Declarations
  wire [9:0] R_IN_rsc_mgc_in_wire_d;
  wire [9:0] G_IN_rsc_mgc_in_wire_d;
  wire [9:0] B_IN_rsc_mgc_in_wire_d;
  wire [9:0] H_OUT_rsc_mgc_out_stdreg_d;
  wire [9:0] S_OUT_rsc_mgc_out_stdreg_d;
  wire [21:0] div_mgc_div_a;
  wire [14:0] div_mgc_div_b;
  wire [21:0] div_mgc_div_z;
  wire [21:0] div_mgc_div_1_a;
  wire [14:0] div_mgc_div_1_b;
  wire [21:0] div_mgc_div_1_z;
  wire [21:0] div_mgc_div_2_a;
  wire [14:0] div_mgc_div_2_b;
  wire [21:0] div_mgc_div_2_z;
  wire [21:0] div_mgc_div_3_a;
  wire [14:0] div_mgc_div_3_b;
  wire [21:0] div_mgc_div_3_z;
  wire [21:0] div_mgc_div_4_a;
  wire [14:0] div_mgc_div_4_b;
  wire [21:0] div_mgc_div_4_z;
  wire [21:0] div_mgc_div_5_a;
  wire [14:0] div_mgc_div_5_b;
  wire [21:0] div_mgc_div_5_z;
  wire [21:0] div_mgc_div_6_a;
  wire [14:0] div_mgc_div_6_b;
  wire [21:0] div_mgc_div_6_z;
  wire [21:0] div_mgc_div_7_a;
  wire [14:0] div_mgc_div_7_b;
  wire [21:0] div_mgc_div_7_z;
  wire [21:0] div_mgc_div_8_a;
  wire [14:0] div_mgc_div_8_b;
  wire [21:0] div_mgc_div_8_z;
  wire [13:0] div_mgc_div_9_a;
  wire [6:0] div_mgc_div_9_b;
  wire [13:0] div_mgc_div_9_z;
  wire [13:0] div_mgc_div_10_a;
  wire [6:0] div_mgc_div_10_b;
  wire [13:0] div_mgc_div_10_z;


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
      .d(10'b0),
      .z(V_OUT_rsc_z)
    );
  mgc_div #(.width_a(22),
  .width_b(15),
  .signd(1)) div_mgc_div (
      .a(div_mgc_div_a),
      .b(div_mgc_div_b),
      .z(div_mgc_div_z)
    );
  mgc_div #(.width_a(22),
  .width_b(15),
  .signd(1)) div_mgc_div_1 (
      .a(div_mgc_div_1_a),
      .b(div_mgc_div_1_b),
      .z(div_mgc_div_1_z)
    );
  mgc_div #(.width_a(22),
  .width_b(15),
  .signd(1)) div_mgc_div_2 (
      .a(div_mgc_div_2_a),
      .b(div_mgc_div_2_b),
      .z(div_mgc_div_2_z)
    );
  mgc_div #(.width_a(22),
  .width_b(15),
  .signd(1)) div_mgc_div_3 (
      .a(div_mgc_div_3_a),
      .b(div_mgc_div_3_b),
      .z(div_mgc_div_3_z)
    );
  mgc_div #(.width_a(22),
  .width_b(15),
  .signd(1)) div_mgc_div_4 (
      .a(div_mgc_div_4_a),
      .b(div_mgc_div_4_b),
      .z(div_mgc_div_4_z)
    );
  mgc_div #(.width_a(22),
  .width_b(15),
  .signd(1)) div_mgc_div_5 (
      .a(div_mgc_div_5_a),
      .b(div_mgc_div_5_b),
      .z(div_mgc_div_5_z)
    );
  mgc_div #(.width_a(22),
  .width_b(15),
  .signd(1)) div_mgc_div_6 (
      .a(div_mgc_div_6_a),
      .b(div_mgc_div_6_b),
      .z(div_mgc_div_6_z)
    );
  mgc_div #(.width_a(22),
  .width_b(15),
  .signd(1)) div_mgc_div_7 (
      .a(div_mgc_div_7_a),
      .b(div_mgc_div_7_b),
      .z(div_mgc_div_7_z)
    );
  mgc_div #(.width_a(22),
  .width_b(15),
  .signd(1)) div_mgc_div_8 (
      .a(div_mgc_div_8_a),
      .b(div_mgc_div_8_b),
      .z(div_mgc_div_8_z)
    );
  mgc_div #(.width_a(14),
  .width_b(7),
  .signd(0)) div_mgc_div_9 (
      .a(div_mgc_div_9_a),
      .b(div_mgc_div_9_b),
      .z(div_mgc_div_9_z)
    );
  mgc_div #(.width_a(14),
  .width_b(7),
  .signd(0)) div_mgc_div_10 (
      .a(div_mgc_div_10_a),
      .b(div_mgc_div_10_b),
      .z(div_mgc_div_10_z)
    );
  HSVRGB_core HSVRGB_core_inst (
      .clk(clk),
      .arst_n(arst_n),
      .R_IN_rsc_mgc_in_wire_d(R_IN_rsc_mgc_in_wire_d),
      .G_IN_rsc_mgc_in_wire_d(G_IN_rsc_mgc_in_wire_d),
      .B_IN_rsc_mgc_in_wire_d(B_IN_rsc_mgc_in_wire_d),
      .H_OUT_rsc_mgc_out_stdreg_d(H_OUT_rsc_mgc_out_stdreg_d),
      .S_OUT_rsc_mgc_out_stdreg_d(S_OUT_rsc_mgc_out_stdreg_d),
      .div_mgc_div_a(div_mgc_div_a),
      .div_mgc_div_b(div_mgc_div_b),
      .div_mgc_div_z(div_mgc_div_z),
      .div_mgc_div_1_a(div_mgc_div_1_a),
      .div_mgc_div_1_b(div_mgc_div_1_b),
      .div_mgc_div_1_z(div_mgc_div_1_z),
      .div_mgc_div_2_a(div_mgc_div_2_a),
      .div_mgc_div_2_b(div_mgc_div_2_b),
      .div_mgc_div_2_z(div_mgc_div_2_z),
      .div_mgc_div_3_a(div_mgc_div_3_a),
      .div_mgc_div_3_b(div_mgc_div_3_b),
      .div_mgc_div_3_z(div_mgc_div_3_z),
      .div_mgc_div_4_a(div_mgc_div_4_a),
      .div_mgc_div_4_b(div_mgc_div_4_b),
      .div_mgc_div_4_z(div_mgc_div_4_z),
      .div_mgc_div_5_a(div_mgc_div_5_a),
      .div_mgc_div_5_b(div_mgc_div_5_b),
      .div_mgc_div_5_z(div_mgc_div_5_z),
      .div_mgc_div_6_a(div_mgc_div_6_a),
      .div_mgc_div_6_b(div_mgc_div_6_b),
      .div_mgc_div_6_z(div_mgc_div_6_z),
      .div_mgc_div_7_a(div_mgc_div_7_a),
      .div_mgc_div_7_b(div_mgc_div_7_b),
      .div_mgc_div_7_z(div_mgc_div_7_z),
      .div_mgc_div_8_a(div_mgc_div_8_a),
      .div_mgc_div_8_b(div_mgc_div_8_b),
      .div_mgc_div_8_z(div_mgc_div_8_z),
      .div_mgc_div_9_a(div_mgc_div_9_a),
      .div_mgc_div_9_b(div_mgc_div_9_b),
      .div_mgc_div_9_z(div_mgc_div_9_z),
      .div_mgc_div_10_a(div_mgc_div_10_a),
      .div_mgc_div_10_b(div_mgc_div_10_b),
      .div_mgc_div_10_z(div_mgc_div_10_z)
    );
endmodule



