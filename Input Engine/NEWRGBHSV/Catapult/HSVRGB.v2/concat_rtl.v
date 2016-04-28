
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
//  Generated date: Wed Apr 27 16:08:28 2016
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    HSVRGB_core
// ------------------------------------------------------------------


module HSVRGB_core (
  clk, arst_n, r_rsc_mgc_in_wire_d, g_rsc_mgc_in_wire_d, b_rsc_mgc_in_wire_d, H_OUT_rsc_mgc_out_stdreg_d,
      S_OUT_rsc_mgc_out_stdreg_d, div_mgc_div_a, div_mgc_div_b, div_mgc_div_z, div_mgc_div_1_a,
      div_mgc_div_1_b, div_mgc_div_1_z, div_mgc_div_2_a, div_mgc_div_2_b, div_mgc_div_2_z,
      div_mgc_div_3_a, div_mgc_div_3_b, div_mgc_div_3_z, div_mgc_div_4_a, div_mgc_div_4_b,
      div_mgc_div_4_z, div_mgc_div_5_a, div_mgc_div_5_b, div_mgc_div_5_z, div_mgc_div_6_a,
      div_mgc_div_6_b, div_mgc_div_6_z, div_mgc_div_7_a, div_mgc_div_7_b, div_mgc_div_7_z,
      div_mgc_div_8_a, div_mgc_div_8_b, div_mgc_div_8_z, div_mgc_div_9_a, div_mgc_div_9_b,
      div_mgc_div_9_z, div_mgc_div_10_a, div_mgc_div_10_b, div_mgc_div_10_z
);
  input clk;
  input arst_n;
  input [9:0] r_rsc_mgc_in_wire_d;
  input [9:0] g_rsc_mgc_in_wire_d;
  input [9:0] b_rsc_mgc_in_wire_d;
  output [9:0] H_OUT_rsc_mgc_out_stdreg_d;
  reg [9:0] H_OUT_rsc_mgc_out_stdreg_d;
  output [9:0] S_OUT_rsc_mgc_out_stdreg_d;
  reg [9:0] S_OUT_rsc_mgc_out_stdreg_d;
  output [17:0] div_mgc_div_a;
  output [14:0] div_mgc_div_b;
  input [17:0] div_mgc_div_z;
  output [17:0] div_mgc_div_1_a;
  output [14:0] div_mgc_div_1_b;
  input [17:0] div_mgc_div_1_z;
  output [17:0] div_mgc_div_2_a;
  output [14:0] div_mgc_div_2_b;
  input [17:0] div_mgc_div_2_z;
  output [17:0] div_mgc_div_3_a;
  output [14:0] div_mgc_div_3_b;
  input [17:0] div_mgc_div_3_z;
  output [17:0] div_mgc_div_4_a;
  output [14:0] div_mgc_div_4_b;
  input [17:0] div_mgc_div_4_z;
  output [17:0] div_mgc_div_5_a;
  output [14:0] div_mgc_div_5_b;
  input [17:0] div_mgc_div_5_z;
  output [17:0] div_mgc_div_6_a;
  output [14:0] div_mgc_div_6_b;
  input [17:0] div_mgc_div_6_z;
  output [17:0] div_mgc_div_7_a;
  output [14:0] div_mgc_div_7_b;
  input [17:0] div_mgc_div_7_z;
  output [17:0] div_mgc_div_8_a;
  output [14:0] div_mgc_div_8_b;
  input [17:0] div_mgc_div_8_z;
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
  wire else_7_else_1_if_equal_tmp;
  wire else_7_if_1_equal_tmp;
  wire if_7_equal_tmp;
  wire [6:0] mux1h_24_tmp;
  wire and_dcpl;
  wire and_dcpl_10;
  wire or_tmp_12;
  wire or_tmp_14;
  wire or_tmp_15;
  wire nand_tmp;
  wire and_dcpl_54;
  wire and_dcpl_55;
  wire and_dcpl_56;
  wire and_dcpl_57;
  wire and_dcpl_59;
  wire and_dcpl_60;
  wire or_dcpl_20;
  wire and_dcpl_74;
  wire and_dcpl_75;
  wire and_dcpl_78;
  wire or_dcpl_25;
  wire and_dcpl_94;
  wire and_dcpl_95;
  wire and_dcpl_112;
  wire or_dcpl_33;
  wire or_tmp_22;
  wire or_tmp_32;
  wire or_tmp_42;
  wire and_dcpl_220;
  wire mux_tmp_16;
  wire and_dcpl_223;
  wire and_dcpl_226;
  wire or_dcpl_110;
  wire or_tmp_56;
  wire and_tmp_17;
  wire or_tmp_70;
  wire and_tmp_19;
  wire or_tmp_84;
  wire and_tmp_21;
  wire and_dcpl_282;
  wire or_dcpl_134;
  wire or_tmp_99;
  wire or_tmp_103;
  wire or_tmp_104;
  wire or_dcpl_140;
  wire or_tmp_113;
  wire or_tmp_117;
  wire or_dcpl_146;
  wire or_tmp_127;
  wire or_tmp_131;
  wire or_dcpl_166;
  wire or_dcpl_169;
  reg else_7_if_div_2cyc;
  reg [13:0] s_sva_2_duc;
  reg [1:0] else_7_if_1_div_3cyc;
  reg [4:0] else_7_if_1_ac_fixed_cctor_sg1_1_sva_duc;
  reg [1:0] else_7_else_1_if_div_3cyc;
  reg [4:0] div_sdt_2_sva_duc;
  reg [1:0] else_7_else_1_else_div_3cyc;
  reg [4:0] div_sdt_3_sva_duc;
  reg else_7_else_1_and_svs_1;
  reg if_7_equal_svs_3;
  reg unequal_tmp_1;
  reg unequal_tmp_2;
  reg else_7_and_svs_3;
  reg [6:0] max_sg1_lpi_dfm_3_mut_3;
  reg [9:0] acc_3_itm_1;
  wire [10:0] nl_acc_3_itm_1;
  reg if_7_equal_svs_st_1;
  reg if_7_equal_svs_st_2;
  reg [6:0] max_sg1_lpi_dfm_3_st_2;
  reg else_7_if_div_2cyc_st_2;
  reg else_7_and_svs_st_1;
  reg else_7_and_svs_st_2;
  reg [1:0] else_7_if_1_div_3cyc_st_2;
  reg [1:0] else_7_if_1_div_3cyc_st_3;
  reg else_7_else_1_and_svs_st_2;
  reg [1:0] else_7_else_1_if_div_3cyc_st_2;
  reg else_7_else_1_and_svs_st_3;
  reg [1:0] else_7_else_1_if_div_3cyc_st_3;
  reg [1:0] else_7_else_1_else_div_3cyc_st_2;
  reg [1:0] else_7_else_1_else_div_3cyc_st_3;
  reg main_stage_0_2;
  reg main_stage_0_3;
  reg main_stage_0_4;
  reg [10:0] else_7_else_1_else_conc_tmp_mut_3_sg1;
  reg [10:0] else_7_else_1_else_conc_tmp_mut_4_sg1;
  reg [10:0] else_7_else_1_if_conc_tmp_mut_3_sg1;
  reg [10:0] else_7_else_1_if_conc_tmp_mut_4_sg1;
  reg [10:0] else_7_if_1_conc_1_tmp_mut_5_sg1;
  reg [10:0] else_7_if_1_conc_1_tmp_mut_6_sg1;
  reg [6:0] else_7_if_conc_tmp_mut_3_sg1;
  reg [6:0] mut_24_sg1_1;
  wire and_137_cse;
  wire and_143_cse;
  wire mux_21_cse;
  wire or_51_cse;
  wire and_142_cse;
  wire mux_23_cse;
  wire mux_25_cse;
  wire and_250_cse;
  wire and_256_cse;
  wire and_272_cse;
  wire and_278_cse;
  wire and_294_cse;
  wire and_300_cse;
  wire and_317_cse;
  wire and_323_cse;
  wire and_339_cse;
  wire and_345_cse;
  wire and_361_cse;
  wire and_367_cse;
  wire and_136_cse;
  wire or_322_cse;
  wire and_407_cse;
  reg [6:0] reg_div_mgc_div_7_b_tmp;
  reg [10:0] reg_div_mgc_div_7_a_tmp;
  reg [6:0] reg_div_mgc_div_8_b_tmp;
  reg [10:0] reg_div_mgc_div_8_a_tmp;
  reg [6:0] reg_div_mgc_div_b_tmp;
  reg [10:0] reg_div_mgc_div_a_tmp;
  reg [6:0] reg_div_mgc_div_4_b_tmp;
  reg [10:0] reg_div_mgc_div_4_a_tmp;
  reg [6:0] reg_div_mgc_div_5_b_tmp;
  reg [10:0] reg_div_mgc_div_5_a_tmp;
  reg [6:0] reg_div_mgc_div_6_b_tmp;
  reg [10:0] reg_div_mgc_div_6_a_tmp;
  reg [6:0] reg_div_mgc_div_1_b_tmp;
  reg [10:0] reg_div_mgc_div_1_a_tmp;
  reg [6:0] reg_div_mgc_div_2_b_tmp;
  reg [10:0] reg_div_mgc_div_2_a_tmp;
  reg [6:0] reg_div_mgc_div_3_b_tmp;
  reg [10:0] reg_div_mgc_div_3_a_tmp;
  reg [6:0] reg_div_mgc_div_10_a_tmp;
  reg [6:0] reg_div_mgc_div_9_a_tmp;
  wire and_177_cse;
  wire and_183_cse;
  wire and_217_cse;
  wire and_223_cse;
  wire mux_30_cse;
  wire mux_36_cse;
  wire mux_42_cse;
  wire mux_50_cse;
  wire mux_58_cse;
  wire mux_66_cse;
  wire and_29_cse;
  wire mux_18_cse;
  wire [4:0] else_7_if_1_ac_fixed_cctor_sg1_1_sva_duc_mx0;
  wire [4:0] div_sdt_2_sva_duc_mx0;
  wire [3:0] else_7_else_1_if_ac_fixed_cctor_sg2_1_sva;
  wire [4:0] nl_else_7_else_1_if_ac_fixed_cctor_sg2_1_sva;
  wire [4:0] div_sdt_3_sva_duc_mx0;
  wire [2:0] else_7_else_1_else_ac_fixed_cctor_sg2_1_sva;
  wire [3:0] nl_else_7_else_1_else_ac_fixed_cctor_sg2_1_sva;
  wire h_sg2_lpi_dfm_1_mx0;
  wire [1:0] acc_imod;
  wire [2:0] nl_acc_imod;
  wire [1:0] else_7_if_1_acc_idiv;
  wire [2:0] nl_else_7_if_1_acc_idiv;
  wire [9:0] g_1_lpi_dfm;
  wire [9:0] b_1_lpi_dfm;
  wire [1:0] acc_imod_1;
  wire [2:0] nl_acc_imod_1;
  wire [1:0] else_7_else_1_if_acc_idiv;
  wire [2:0] nl_else_7_else_1_if_acc_idiv;
  wire [9:0] r_1_lpi_dfm;
  wire [1:0] acc_imod_2;
  wire [2:0] nl_acc_imod_2;
  wire [1:0] else_7_else_1_else_acc_idiv;
  wire [2:0] nl_else_7_else_1_else_acc_idiv;
  wire unequal_tmp;
  wire [6:0] min_sg1_lpi_dfm_3;
  wire [5:0] else_7_acc_itm;
  wire [6:0] nl_else_7_acc_itm;
  wire [7:0] else_7_acc_4_itm;
  wire [8:0] nl_else_7_acc_4_itm;
  wire [11:0] else_7_if_1_acc_1_itm;
  wire [12:0] nl_else_7_if_1_acc_1_itm;
  wire [11:0] else_7_else_1_if_acc_2_itm;
  wire [12:0] nl_else_7_else_1_if_acc_2_itm;
  wire [11:0] else_7_else_1_else_acc_2_itm;
  wire [12:0] nl_else_7_else_1_else_acc_2_itm;
  wire [11:0] if_if_acc_itm;
  wire [12:0] nl_if_if_acc_itm;
  wire [11:0] else_1_if_acc_itm;
  wire [12:0] nl_else_1_if_acc_itm;
  wire [11:0] if_3_if_acc_itm;
  wire [12:0] nl_if_3_if_acc_itm;
  wire [11:0] else_5_if_acc_itm;
  wire [12:0] nl_else_5_if_acc_itm;
  wire [11:0] if_3_acc_1_itm;
  wire [12:0] nl_if_3_acc_1_itm;
  wire [11:0] if_acc_1_itm;
  wire [12:0] nl_if_acc_1_itm;
  wire [14:0] mul_1_itm;
  wire [29:0] nl_mul_1_itm;

  wire[0:0] mux_29_nl;
  wire[0:0] mux_28_nl;
  wire[0:0] mux_35_nl;
  wire[0:0] mux_34_nl;
  wire[0:0] mux_41_nl;
  wire[0:0] mux_40_nl;
  wire[0:0] mux_49_nl;
  wire[0:0] mux_48_nl;
  wire[0:0] mux_47_nl;
  wire[0:0] mux_57_nl;
  wire[0:0] mux_56_nl;
  wire[0:0] mux_55_nl;
  wire[0:0] mux_65_nl;
  wire[0:0] mux_64_nl;
  wire[0:0] mux_63_nl;
  wire[1:0] else_7_mux1h_nl;
  wire[0:0] else_7_mux_4_nl;
  wire[0:0] else_7_else_1_mux_nl;
  wire[0:0] else_7_mux_5_nl;
  wire[0:0] else_7_else_1_mux_1_nl;
  wire[0:0] else_7_else_1_mux_3_nl;
  wire[13:0] mux1h_26_nl;

  // Interconnect Declarations for Component Instantiations 
  assign and_136_cse = (~((mux1h_24_tmp[0]) | (mux1h_24_tmp[1]))) & (~((mux1h_24_tmp[2])
      | (mux1h_24_tmp[3]))) & (~((mux1h_24_tmp[4]) | (mux1h_24_tmp[5]) | (mux1h_24_tmp[6])));
  assign or_51_cse = and_136_cse | (~((r_rsc_mgc_in_wire_d[7]) | (r_rsc_mgc_in_wire_d[8])
      | (r_rsc_mgc_in_wire_d[9])));
  assign and_137_cse = or_51_cse & and_dcpl_112 & (~((else_7_if_1_acc_tmp[1]) | (else_7_if_1_acc_tmp[0])));
  assign and_142_cse = ((mux1h_24_tmp[0]) | (mux1h_24_tmp[1]) | (mux1h_24_tmp[2])
      | (mux1h_24_tmp[3]) | (mux1h_24_tmp[4]) | (mux1h_24_tmp[5]) | (mux1h_24_tmp[6]))
      & ((r_rsc_mgc_in_wire_d[7]) | (r_rsc_mgc_in_wire_d[8]) | (r_rsc_mgc_in_wire_d[9]));
  assign and_143_cse = (and_142_cse | or_dcpl_33 | (else_7_if_1_acc_tmp[1]) | (else_7_if_1_acc_tmp[0]))
      & and_29_cse & (~((else_7_if_1_div_3cyc[1]) | (else_7_if_1_div_3cyc[0])));
  assign mux_21_cse = MUX_s_1_2_2({(or_tmp_14 & or_tmp_15 & or_tmp_22) , or_tmp_22},
      (else_7_if_1_acc_tmp[1]) | (else_7_if_1_acc_tmp[0]) | (~ else_7_if_1_equal_tmp)
      | if_7_equal_tmp);
  assign div_mgc_div_7_b = {1'b0, {reg_div_mgc_div_7_b_tmp , 7'b0}};
  assign div_mgc_div_7_a = {reg_div_mgc_div_7_a_tmp , 7'b0};
  assign mux_23_cse = MUX_s_1_2_2({(or_tmp_14 & or_tmp_15 & or_tmp_32) , or_tmp_32},
      (else_7_if_1_acc_tmp[1]) | (~ (else_7_if_1_acc_tmp[0])) | (~ else_7_if_1_equal_tmp)
      | if_7_equal_tmp);
  assign and_177_cse = or_51_cse & and_dcpl_112 & (~ (else_7_if_1_acc_tmp[1])) &
      (else_7_if_1_acc_tmp[0]);
  assign and_183_cse = (and_142_cse | or_dcpl_33 | (else_7_if_1_acc_tmp[1]) | (~
      (else_7_if_1_acc_tmp[0]))) & and_29_cse & (~ (else_7_if_1_div_3cyc[1])) & (else_7_if_1_div_3cyc[0]);
  assign div_mgc_div_8_b = {1'b0, {reg_div_mgc_div_8_b_tmp , 7'b0}};
  assign div_mgc_div_8_a = {reg_div_mgc_div_8_a_tmp , 7'b0};
  assign mux_25_cse = MUX_s_1_2_2({(or_tmp_14 & or_tmp_15 & or_tmp_42) , or_tmp_42},
      (~ (else_7_if_1_acc_tmp[1])) | (else_7_if_1_acc_tmp[0]) | (~ else_7_if_1_equal_tmp)
      | if_7_equal_tmp);
  assign and_217_cse = or_51_cse & and_dcpl_112 & (else_7_if_1_acc_tmp[1]) & (~ (else_7_if_1_acc_tmp[0]));
  assign and_223_cse = (and_142_cse | or_dcpl_33 | (~ (else_7_if_1_acc_tmp[1])) |
      (else_7_if_1_acc_tmp[0])) & and_29_cse & (else_7_if_1_div_3cyc[1]) & (~ (else_7_if_1_div_3cyc[0]));
  assign div_mgc_div_b = {1'b0, {reg_div_mgc_div_b_tmp , 7'b0}};
  assign div_mgc_div_a = {reg_div_mgc_div_a_tmp , 7'b0};
  assign and_250_cse = (~ mux_tmp_16) & and_dcpl_220 & (~((else_7_else_1_if_acc_tmp[1])
      | (else_7_else_1_if_acc_tmp[0])));
  assign and_256_cse = (mux_tmp_16 | or_dcpl_110 | (else_7_else_1_if_acc_tmp[1])
      | (else_7_else_1_if_acc_tmp[0])) & and_dcpl_226 & and_dcpl_223 & (~ (else_7_else_1_if_div_3cyc[0]));
  assign mux_28_nl = MUX_s_1_2_2({(~(or_tmp_14 | (~ and_tmp_17))) , or_tmp_56}, or_tmp_12);
  assign mux_29_nl = MUX_s_1_2_2({and_tmp_17 , (mux_28_nl)}, or_tmp_15);
  assign mux_30_cse = MUX_s_1_2_2({(mux_29_nl) , or_tmp_56}, (else_7_else_1_if_acc_tmp[1])
      | (else_7_else_1_if_acc_tmp[0]) | (~ else_7_else_1_if_equal_tmp) | if_7_equal_tmp);
  assign div_mgc_div_4_b = {1'b0, {reg_div_mgc_div_4_b_tmp , 7'b0}};
  assign div_mgc_div_4_a = {reg_div_mgc_div_4_a_tmp , 7'b0};
  assign and_272_cse = (~ mux_tmp_16) & and_dcpl_220 & (~ (else_7_else_1_if_acc_tmp[1]))
      & (else_7_else_1_if_acc_tmp[0]);
  assign and_278_cse = (mux_tmp_16 | or_dcpl_110 | (else_7_else_1_if_acc_tmp[1])
      | (~ (else_7_else_1_if_acc_tmp[0]))) & and_dcpl_226 & and_dcpl_223 & (else_7_else_1_if_div_3cyc[0]);
  assign mux_34_nl = MUX_s_1_2_2({(~(or_tmp_14 | (~ and_tmp_19))) , or_tmp_70}, or_tmp_12);
  assign mux_35_nl = MUX_s_1_2_2({and_tmp_19 , (mux_34_nl)}, or_tmp_15);
  assign mux_36_cse = MUX_s_1_2_2({(mux_35_nl) , or_tmp_70}, (else_7_else_1_if_acc_tmp[1])
      | (~ (else_7_else_1_if_acc_tmp[0])) | (~ else_7_else_1_if_equal_tmp) | if_7_equal_tmp);
  assign div_mgc_div_5_b = {1'b0, {reg_div_mgc_div_5_b_tmp , 7'b0}};
  assign div_mgc_div_5_a = {reg_div_mgc_div_5_a_tmp , 7'b0};
  assign and_294_cse = (~ mux_tmp_16) & and_dcpl_220 & (else_7_else_1_if_acc_tmp[1])
      & (~ (else_7_else_1_if_acc_tmp[0]));
  assign and_300_cse = (mux_tmp_16 | or_dcpl_110 | (~ (else_7_else_1_if_acc_tmp[1]))
      | (else_7_else_1_if_acc_tmp[0])) & and_dcpl_226 & else_7_else_1_and_svs_1 &
      (else_7_else_1_if_div_3cyc[1]) & (~ (else_7_else_1_if_div_3cyc[0]));
  assign mux_40_nl = MUX_s_1_2_2({(~(or_tmp_14 | (~ and_tmp_21))) , or_tmp_84}, or_tmp_12);
  assign mux_41_nl = MUX_s_1_2_2({and_tmp_21 , (mux_40_nl)}, or_tmp_15);
  assign mux_42_cse = MUX_s_1_2_2({(mux_41_nl) , or_tmp_84}, (~ (else_7_else_1_if_acc_tmp[1]))
      | (else_7_else_1_if_acc_tmp[0]) | (~ else_7_else_1_if_equal_tmp) | if_7_equal_tmp);
  assign div_mgc_div_6_b = {1'b0, {reg_div_mgc_div_6_b_tmp , 7'b0}};
  assign div_mgc_div_6_a = {reg_div_mgc_div_6_a_tmp , 7'b0};
  assign and_317_cse = mux_18_cse & (~((else_7_else_1_else_acc_tmp[1]) | (else_7_else_1_else_acc_tmp[0])
      | if_7_equal_tmp));
  assign and_323_cse = ((~ mux_18_cse) | or_dcpl_134) & and_dcpl_226 & and_dcpl_282
      & (~ (else_7_else_1_else_div_3cyc[0]));
  assign mux_47_nl = MUX_s_1_2_2({or_tmp_103 , (~ or_tmp_99)}, else_7_else_1_if_equal_tmp);
  assign mux_48_nl = MUX_s_1_2_2({(mux_47_nl) , or_tmp_103}, or_tmp_12);
  assign mux_49_nl = MUX_s_1_2_2({(or_tmp_104 & or_tmp_99) , (~ (mux_48_nl))}, or_tmp_15);
  assign mux_50_cse = MUX_s_1_2_2({(mux_49_nl) , or_tmp_99}, or_dcpl_134);
  assign div_mgc_div_1_b = {1'b0, {reg_div_mgc_div_1_b_tmp , 7'b0}};
  assign div_mgc_div_1_a = {reg_div_mgc_div_1_a_tmp , 7'b0};
  assign and_339_cse = mux_18_cse & (~ (else_7_else_1_else_acc_tmp[1])) & (else_7_else_1_else_acc_tmp[0])
      & (~ if_7_equal_tmp);
  assign and_345_cse = ((~ mux_18_cse) | or_dcpl_140) & and_dcpl_226 & and_dcpl_282
      & (else_7_else_1_else_div_3cyc[0]);
  assign mux_55_nl = MUX_s_1_2_2({or_tmp_117 , (~ or_tmp_113)}, else_7_else_1_if_equal_tmp);
  assign mux_56_nl = MUX_s_1_2_2({(mux_55_nl) , or_tmp_117}, or_tmp_12);
  assign mux_57_nl = MUX_s_1_2_2({(or_tmp_104 & or_tmp_113) , (~ (mux_56_nl))}, or_tmp_15);
  assign mux_58_cse = MUX_s_1_2_2({(mux_57_nl) , or_tmp_113}, or_dcpl_140);
  assign div_mgc_div_2_b = {1'b0, {reg_div_mgc_div_2_b_tmp , 7'b0}};
  assign div_mgc_div_2_a = {reg_div_mgc_div_2_a_tmp , 7'b0};
  assign and_361_cse = mux_18_cse & (else_7_else_1_else_acc_tmp[1]) & (~ (else_7_else_1_else_acc_tmp[0]))
      & (~ if_7_equal_tmp);
  assign and_367_cse = ((~ mux_18_cse) | or_dcpl_146) & and_dcpl_226 & (~ else_7_else_1_and_svs_1)
      & (else_7_else_1_else_div_3cyc[1]) & (~ (else_7_else_1_else_div_3cyc[0]));
  assign mux_63_nl = MUX_s_1_2_2({or_tmp_131 , (~ or_tmp_127)}, else_7_else_1_if_equal_tmp);
  assign mux_64_nl = MUX_s_1_2_2({(mux_63_nl) , or_tmp_131}, or_tmp_12);
  assign mux_65_nl = MUX_s_1_2_2({(or_tmp_104 & or_tmp_127) , (~ (mux_64_nl))}, or_tmp_15);
  assign mux_66_cse = MUX_s_1_2_2({(mux_65_nl) , or_tmp_127}, or_dcpl_146);
  assign div_mgc_div_3_b = {1'b0, {reg_div_mgc_div_3_b_tmp , 7'b0}};
  assign div_mgc_div_3_a = {reg_div_mgc_div_3_a_tmp , 7'b0};
  assign and_29_cse = and_dcpl_10 & else_7_and_svs_st_1;
  assign div_mgc_div_10_a = {reg_div_mgc_div_10_a_tmp , 7'b0};
  assign div_mgc_div_9_a = {reg_div_mgc_div_9_a_tmp , 7'b0};
  assign mux_18_cse = MUX_s_1_2_2({nand_tmp , (or_tmp_12 & ((~ else_7_if_1_equal_tmp)
      | (r_rsc_mgc_in_wire_d[9]) | (r_rsc_mgc_in_wire_d[8]) | (r_rsc_mgc_in_wire_d[7]))
      & or_tmp_15)}, else_7_else_1_if_equal_tmp);
  assign or_322_cse = or_dcpl_169 | or_dcpl_166;
  assign and_407_cse = (~((max_sg1_lpi_dfm_3_st_2[6]) | (max_sg1_lpi_dfm_3_st_2[5])))
      & (~((max_sg1_lpi_dfm_3_st_2[4]) | (max_sg1_lpi_dfm_3_st_2[3]))) & (~((max_sg1_lpi_dfm_3_st_2[2])
      | (max_sg1_lpi_dfm_3_st_2[1]) | (max_sg1_lpi_dfm_3_st_2[0])));
  assign else_7_mux1h_nl = MUX1HOT_v_2_3_2({(else_7_else_1_else_ac_fixed_cctor_sg2_1_sva[2:1])
      , (else_7_else_1_if_ac_fixed_cctor_sg2_1_sva[3:2]) , (else_7_if_1_ac_fixed_cctor_sg1_1_sva_duc_mx0[4:3])},
      {(~(else_7_else_1_and_svs_st_3 | else_7_and_svs_3)) , (else_7_else_1_and_svs_st_3
      & (~ else_7_and_svs_3)) , else_7_and_svs_3});
  assign else_7_else_1_mux_nl = MUX_s_1_2_2({(else_7_else_1_else_ac_fixed_cctor_sg2_1_sva[0])
      , (else_7_else_1_if_ac_fixed_cctor_sg2_1_sva[1])}, else_7_else_1_and_svs_st_3);
  assign else_7_mux_4_nl = MUX_s_1_2_2({(else_7_else_1_mux_nl) , (else_7_if_1_ac_fixed_cctor_sg1_1_sva_duc_mx0[2])},
      else_7_and_svs_3);
  assign else_7_else_1_mux_1_nl = MUX_s_1_2_2({(div_sdt_3_sva_duc_mx0[1]) , (else_7_else_1_if_ac_fixed_cctor_sg2_1_sva[0])},
      else_7_else_1_and_svs_st_3);
  assign else_7_mux_5_nl = MUX_s_1_2_2({(else_7_else_1_mux_1_nl) , (else_7_if_1_ac_fixed_cctor_sg1_1_sva_duc_mx0[1])},
      else_7_and_svs_3);
  assign nl_else_7_acc_itm = ({(~ (else_7_mux1h_nl)) , (~ (else_7_mux_4_nl)) , (~
      (else_7_mux_5_nl)) , (~ h_sg2_lpi_dfm_1_mx0) , 1'b1}) + ({h_sg2_lpi_dfm_1_mx0
      , 5'b1});
  assign else_7_acc_itm = nl_else_7_acc_itm[5:0];
  assign else_7_if_1_ac_fixed_cctor_sg1_1_sva_duc_mx0 = MUX1HOT_v_5_4_2({(div_mgc_div_7_z[4:0])
      , (div_mgc_div_8_z[4:0]) , (div_mgc_div_z[4:0]) , else_7_if_1_ac_fixed_cctor_sg1_1_sva_duc},
      {and_dcpl_54 , and_dcpl_55 , and_dcpl_56 , and_dcpl_57});
  assign div_sdt_2_sva_duc_mx0 = MUX1HOT_v_5_4_2({(div_mgc_div_4_z[4:0]) , (div_mgc_div_5_z[4:0])
      , (div_mgc_div_6_z[4:0]) , div_sdt_2_sva_duc}, {(~((else_7_else_1_if_div_3cyc_st_3[1])
      | (else_7_else_1_if_div_3cyc_st_3[0]))) , ((~ (else_7_else_1_if_div_3cyc_st_3[1]))
      & (else_7_else_1_if_div_3cyc_st_3[0])) , ((else_7_else_1_if_div_3cyc_st_3[1])
      & (~ (else_7_else_1_if_div_3cyc_st_3[0]))) , and_dcpl_74});
  assign nl_else_7_else_1_if_ac_fixed_cctor_sg2_1_sva = (div_sdt_2_sva_duc_mx0[4:1])
      + 4'b1;
  assign else_7_else_1_if_ac_fixed_cctor_sg2_1_sva = nl_else_7_else_1_if_ac_fixed_cctor_sg2_1_sva[3:0];
  assign div_sdt_3_sva_duc_mx0 = MUX1HOT_v_5_4_2({(div_mgc_div_1_z[4:0]) , (div_mgc_div_2_z[4:0])
      , (div_mgc_div_3_z[4:0]) , div_sdt_3_sva_duc}, {(~((else_7_else_1_else_div_3cyc_st_3[1])
      | (else_7_else_1_else_div_3cyc_st_3[0]))) , ((~ (else_7_else_1_else_div_3cyc_st_3[1]))
      & (else_7_else_1_else_div_3cyc_st_3[0])) , ((else_7_else_1_else_div_3cyc_st_3[1])
      & (~ (else_7_else_1_else_div_3cyc_st_3[0]))) , and_dcpl_94});
  assign nl_else_7_else_1_else_ac_fixed_cctor_sg2_1_sva = (div_sdt_3_sva_duc_mx0[4:2])
      + 3'b1;
  assign else_7_else_1_else_ac_fixed_cctor_sg2_1_sva = nl_else_7_else_1_else_ac_fixed_cctor_sg2_1_sva[2:0];
  assign else_7_else_1_mux_3_nl = MUX_s_1_2_2({(div_sdt_3_sva_duc_mx0[0]) , (div_sdt_2_sva_duc_mx0[0])},
      else_7_else_1_and_svs_st_3);
  assign h_sg2_lpi_dfm_1_mx0 = MUX_s_1_2_2({(else_7_else_1_mux_3_nl) , (else_7_if_1_ac_fixed_cctor_sg1_1_sva_duc_mx0[0])},
      else_7_and_svs_3);
  assign mux1h_24_tmp = MUX1HOT_v_7_3_2({(r_rsc_mgc_in_wire_d[6:0]) , (b_rsc_mgc_in_wire_d[6:0])
      , (g_rsc_mgc_in_wire_d[6:0])}, {(~((if_if_acc_itm[11]) | (if_acc_1_itm[11])))
      , (((if_if_acc_itm[11]) & (~ (if_acc_1_itm[11]))) | ((else_1_if_acc_itm[11])
      & (if_acc_1_itm[11]))) , ((~ (else_1_if_acc_itm[11])) & (if_acc_1_itm[11]))});
  assign nl_else_7_acc_4_itm = ({mux1h_24_tmp , 1'b1}) + ({(~ min_sg1_lpi_dfm_3)
      , 1'b1});
  assign else_7_acc_4_itm = nl_else_7_acc_4_itm[7:0];
  assign nl_else_7_if_1_acc_1_itm = ({1'b1 , g_1_lpi_dfm , 1'b1}) + conv_u2s_11_12({(~
      b_1_lpi_dfm) , 1'b1});
  assign else_7_if_1_acc_1_itm = nl_else_7_if_1_acc_1_itm[11:0];
  assign nl_else_7_else_1_if_acc_2_itm = ({1'b1 , b_1_lpi_dfm , 1'b1}) + conv_u2s_11_12({(~
      r_1_lpi_dfm) , 1'b1});
  assign else_7_else_1_if_acc_2_itm = nl_else_7_else_1_if_acc_2_itm[11:0];
  assign nl_else_7_else_1_else_acc_2_itm = ({1'b1 , r_1_lpi_dfm , 1'b1}) + conv_u2s_11_12({(~
      g_1_lpi_dfm) , 1'b1});
  assign else_7_else_1_else_acc_2_itm = nl_else_7_else_1_else_acc_2_itm[11:0];
  assign else_7_if_1_equal_tmp = (r_1_lpi_dfm[6:0]) == mux1h_24_tmp;
  assign if_7_equal_tmp = mux1h_24_tmp == min_sg1_lpi_dfm_3;
  assign nl_if_if_acc_itm = ({1'b1 , r_rsc_mgc_in_wire_d , 1'b1}) + conv_u2u_11_12({(~
      b_rsc_mgc_in_wire_d) , 1'b1});
  assign if_if_acc_itm = nl_if_if_acc_itm[11:0];
  assign nl_else_1_if_acc_itm = ({1'b1 , g_rsc_mgc_in_wire_d , 1'b1}) + conv_u2u_11_12({(~
      b_rsc_mgc_in_wire_d) , 1'b1});
  assign else_1_if_acc_itm = nl_else_1_if_acc_itm[11:0];
  assign nl_if_3_if_acc_itm = ({1'b1 , b_rsc_mgc_in_wire_d , 1'b1}) + conv_u2u_11_12({(~
      r_rsc_mgc_in_wire_d) , 1'b1});
  assign if_3_if_acc_itm = nl_if_3_if_acc_itm[11:0];
  assign nl_else_5_if_acc_itm = ({1'b1 , b_rsc_mgc_in_wire_d , 1'b1}) + conv_u2u_11_12({(~
      g_rsc_mgc_in_wire_d) , 1'b1});
  assign else_5_if_acc_itm = nl_else_5_if_acc_itm[11:0];
  assign nl_else_7_if_1_acc_tmp = conv_u2u_1_2(acc_imod[0]) + conv_u2u_1_2(acc_imod[1]);
  assign else_7_if_1_acc_tmp = nl_else_7_if_1_acc_tmp[1:0];
  assign nl_acc_imod = conv_s2s_1_2(else_7_if_1_acc_idiv[1]) + conv_u2s_1_2(else_7_if_1_acc_idiv[0]);
  assign acc_imod = nl_acc_imod[1:0];
  assign nl_else_7_if_1_acc_idiv = else_7_if_1_div_3cyc + 2'b1;
  assign else_7_if_1_acc_idiv = nl_else_7_if_1_acc_idiv[1:0];
  assign g_1_lpi_dfm = g_rsc_mgc_in_wire_d & ({{9{unequal_tmp}}, unequal_tmp});
  assign b_1_lpi_dfm = b_rsc_mgc_in_wire_d & ({{9{unequal_tmp}}, unequal_tmp});
  assign nl_else_7_else_1_if_acc_tmp = conv_u2u_1_2(acc_imod_1[0]) + conv_u2u_1_2(acc_imod_1[1]);
  assign else_7_else_1_if_acc_tmp = nl_else_7_else_1_if_acc_tmp[1:0];
  assign nl_acc_imod_1 = conv_s2s_1_2(else_7_else_1_if_acc_idiv[1]) + conv_u2s_1_2(else_7_else_1_if_acc_idiv[0]);
  assign acc_imod_1 = nl_acc_imod_1[1:0];
  assign nl_else_7_else_1_if_acc_idiv = else_7_else_1_if_div_3cyc + 2'b1;
  assign else_7_else_1_if_acc_idiv = nl_else_7_else_1_if_acc_idiv[1:0];
  assign r_1_lpi_dfm = r_rsc_mgc_in_wire_d & ({{9{unequal_tmp}}, unequal_tmp});
  assign nl_else_7_else_1_else_acc_tmp = conv_u2u_1_2(acc_imod_2[0]) + conv_u2u_1_2(acc_imod_2[1]);
  assign else_7_else_1_else_acc_tmp = nl_else_7_else_1_else_acc_tmp[1:0];
  assign nl_acc_imod_2 = conv_s2s_1_2(else_7_else_1_else_acc_idiv[1]) + conv_u2s_1_2(else_7_else_1_else_acc_idiv[0]);
  assign acc_imod_2 = nl_acc_imod_2[1:0];
  assign nl_else_7_else_1_else_acc_idiv = else_7_else_1_else_div_3cyc + 2'b1;
  assign else_7_else_1_else_acc_idiv = nl_else_7_else_1_else_acc_idiv[1:0];
  assign unequal_tmp = (mux1h_24_tmp[6]) | (mux1h_24_tmp[5]) | (mux1h_24_tmp[4])
      | (mux1h_24_tmp[3]) | (mux1h_24_tmp[2]) | (mux1h_24_tmp[1]) | (mux1h_24_tmp[0]);
  assign min_sg1_lpi_dfm_3 = MUX1HOT_v_7_3_2({(r_rsc_mgc_in_wire_d[6:0]) , (b_rsc_mgc_in_wire_d[6:0])
      , (g_rsc_mgc_in_wire_d[6:0])}, {(~((if_3_if_acc_itm[11]) | (if_3_acc_1_itm[11])))
      , (((if_3_if_acc_itm[11]) & (~ (if_3_acc_1_itm[11]))) | ((else_5_if_acc_itm[11])
      & (if_3_acc_1_itm[11]))) , ((~ (else_5_if_acc_itm[11])) & (if_3_acc_1_itm[11]))});
  assign nl_if_3_acc_1_itm = ({1'b1 , g_rsc_mgc_in_wire_d , 1'b1}) + conv_u2u_11_12({(~
      r_rsc_mgc_in_wire_d) , 1'b1});
  assign if_3_acc_1_itm = nl_if_3_acc_1_itm[11:0];
  assign nl_if_acc_1_itm = ({1'b1 , r_rsc_mgc_in_wire_d , 1'b1}) + conv_u2u_11_12({(~
      g_rsc_mgc_in_wire_d) , 1'b1});
  assign if_acc_1_itm = nl_if_acc_1_itm[11:0];
  assign mux1h_26_nl = MUX1HOT_v_14_3_2({div_mgc_div_10_z , div_mgc_div_9_z , s_sva_2_duc},
      {(~((~(or_dcpl_169 | or_dcpl_166)) | else_7_if_div_2cyc_st_2)) , (or_322_cse
      & else_7_if_div_2cyc_st_2) , and_407_cse});
  assign nl_mul_1_itm = conv_u2u_14_15((mux1h_26_nl) & ({{13{unequal_tmp_2}}, unequal_tmp_2})
      & (signext_14_1(~ if_7_equal_svs_st_2))) * 15'b11001;
  assign mul_1_itm = nl_mul_1_itm[14:0];
  assign else_7_else_1_if_equal_tmp = (g_1_lpi_dfm[6:0]) == mux1h_24_tmp;
  assign and_dcpl = main_stage_0_3 & (~ if_7_equal_svs_st_2);
  assign and_dcpl_10 = main_stage_0_2 & (~ if_7_equal_svs_st_1);
  assign or_tmp_12 = (g_rsc_mgc_in_wire_d[9]) | (g_rsc_mgc_in_wire_d[8]) | (g_rsc_mgc_in_wire_d[7]);
  assign or_tmp_14 = (r_rsc_mgc_in_wire_d[9]) | (r_rsc_mgc_in_wire_d[8]) | (r_rsc_mgc_in_wire_d[7]);
  assign or_tmp_15 = (mux1h_24_tmp[6]) | (mux1h_24_tmp[5]) | (mux1h_24_tmp[4]) |
      (mux1h_24_tmp[3]) | (mux1h_24_tmp[2]) | (mux1h_24_tmp[1]) | (mux1h_24_tmp[0]);
  assign nand_tmp = ~(else_7_if_1_equal_tmp & (~(or_tmp_14 & or_tmp_15)));
  assign and_dcpl_54 = ~((else_7_if_1_div_3cyc_st_3[1]) | (else_7_if_1_div_3cyc_st_3[0]));
  assign and_dcpl_55 = (~ (else_7_if_1_div_3cyc_st_3[1])) & (else_7_if_1_div_3cyc_st_3[0]);
  assign and_dcpl_56 = (else_7_if_1_div_3cyc_st_3[1]) & (~ (else_7_if_1_div_3cyc_st_3[0]));
  assign and_dcpl_57 = (else_7_if_1_div_3cyc_st_3[1]) & (else_7_if_1_div_3cyc_st_3[0]);
  assign and_dcpl_59 = main_stage_0_4 & (~ if_7_equal_svs_3);
  assign and_dcpl_60 = and_dcpl_59 & else_7_and_svs_3;
  assign or_dcpl_20 = (~ main_stage_0_4) | if_7_equal_svs_3;
  assign and_dcpl_74 = (else_7_else_1_if_div_3cyc_st_3[1]) & (else_7_else_1_if_div_3cyc_st_3[0]);
  assign and_dcpl_75 = else_7_else_1_and_svs_st_3 & (~ (else_7_else_1_if_div_3cyc_st_3[1]));
  assign and_dcpl_78 = and_dcpl_59 & (~ else_7_and_svs_3);
  assign or_dcpl_25 = or_dcpl_20 | else_7_and_svs_3;
  assign and_dcpl_94 = (else_7_else_1_else_div_3cyc_st_3[1]) & (else_7_else_1_else_div_3cyc_st_3[0]);
  assign and_dcpl_95 = ~(else_7_else_1_and_svs_st_3 | (else_7_else_1_else_div_3cyc_st_3[1]));
  assign and_dcpl_112 = else_7_if_1_equal_tmp & (~ if_7_equal_tmp);
  assign or_dcpl_33 = (~ else_7_if_1_equal_tmp) | if_7_equal_tmp;
  assign or_tmp_22 = (else_7_if_1_div_3cyc[0]) | (else_7_if_1_div_3cyc[1]) | (~ main_stage_0_2)
      | if_7_equal_svs_st_1 | (~ else_7_and_svs_st_1);
  assign or_tmp_32 = (~ (else_7_if_1_div_3cyc[0])) | (else_7_if_1_div_3cyc[1]) |
      (~ main_stage_0_2) | if_7_equal_svs_st_1 | (~ else_7_and_svs_st_1);
  assign or_tmp_42 = (else_7_if_1_div_3cyc[0]) | (~ (else_7_if_1_div_3cyc[1])) |
      (~ main_stage_0_2) | if_7_equal_svs_st_1 | (~ else_7_and_svs_st_1);
  assign and_dcpl_220 = else_7_else_1_if_equal_tmp & (~ if_7_equal_tmp);
  assign mux_tmp_16 = MUX_s_1_2_2({(~ nand_tmp) , (else_7_if_1_equal_tmp | (mux1h_24_tmp[6])
      | (mux1h_24_tmp[5]) | (mux1h_24_tmp[4]) | (mux1h_24_tmp[3]) | (mux1h_24_tmp[2])
      | (mux1h_24_tmp[1]) | (mux1h_24_tmp[0]))}, or_tmp_12);
  assign and_dcpl_223 = else_7_else_1_and_svs_1 & (~ (else_7_else_1_if_div_3cyc[1]));
  assign and_dcpl_226 = and_dcpl_10 & (~ else_7_and_svs_st_1);
  assign or_dcpl_110 = (~ else_7_else_1_if_equal_tmp) | if_7_equal_tmp;
  assign or_tmp_56 = (else_7_else_1_if_div_3cyc[0]) | (else_7_else_1_if_div_3cyc[1])
      | (~ main_stage_0_2) | if_7_equal_svs_st_1 | else_7_and_svs_st_1 | (~ else_7_else_1_and_svs_1);
  assign and_tmp_17 = else_7_if_1_equal_tmp & or_tmp_56;
  assign or_tmp_70 = (~ (else_7_else_1_if_div_3cyc[0])) | (else_7_else_1_if_div_3cyc[1])
      | (~ main_stage_0_2) | if_7_equal_svs_st_1 | else_7_and_svs_st_1 | (~ else_7_else_1_and_svs_1);
  assign and_tmp_19 = else_7_if_1_equal_tmp & or_tmp_70;
  assign or_tmp_84 = (else_7_else_1_if_div_3cyc[0]) | (~ (else_7_else_1_if_div_3cyc[1]))
      | (~ main_stage_0_2) | if_7_equal_svs_st_1 | else_7_and_svs_st_1 | (~ else_7_else_1_and_svs_1);
  assign and_tmp_21 = else_7_if_1_equal_tmp & or_tmp_84;
  assign and_dcpl_282 = ~(else_7_else_1_and_svs_1 | (else_7_else_1_else_div_3cyc[1]));
  assign or_dcpl_134 = (else_7_else_1_else_acc_tmp[1]) | (else_7_else_1_else_acc_tmp[0])
      | if_7_equal_tmp;
  assign or_tmp_99 = (else_7_else_1_else_div_3cyc[0]) | (else_7_else_1_else_div_3cyc[1])
      | (~ main_stage_0_2) | if_7_equal_svs_st_1 | else_7_and_svs_st_1 | else_7_else_1_and_svs_1;
  assign or_tmp_103 = or_tmp_14 | (~(else_7_if_1_equal_tmp & or_tmp_99));
  assign or_tmp_104 = else_7_else_1_if_equal_tmp | else_7_if_1_equal_tmp;
  assign or_dcpl_140 = (else_7_else_1_else_acc_tmp[1]) | (~ (else_7_else_1_else_acc_tmp[0]))
      | if_7_equal_tmp;
  assign or_tmp_113 = (~ (else_7_else_1_else_div_3cyc[0])) | (else_7_else_1_else_div_3cyc[1])
      | (~ main_stage_0_2) | if_7_equal_svs_st_1 | else_7_and_svs_st_1 | else_7_else_1_and_svs_1;
  assign or_tmp_117 = or_tmp_14 | (~(else_7_if_1_equal_tmp & or_tmp_113));
  assign or_dcpl_146 = (~ (else_7_else_1_else_acc_tmp[1])) | (else_7_else_1_else_acc_tmp[0])
      | if_7_equal_tmp;
  assign or_tmp_127 = (else_7_else_1_else_div_3cyc[0]) | (~ (else_7_else_1_else_div_3cyc[1]))
      | (~ main_stage_0_2) | if_7_equal_svs_st_1 | else_7_and_svs_st_1 | else_7_else_1_and_svs_1;
  assign or_tmp_131 = or_tmp_14 | (~(else_7_if_1_equal_tmp & or_tmp_127));
  assign or_dcpl_166 = (max_sg1_lpi_dfm_3_st_2[2]) | (max_sg1_lpi_dfm_3_st_2[1])
      | (max_sg1_lpi_dfm_3_st_2[0]);
  assign or_dcpl_169 = (max_sg1_lpi_dfm_3_st_2[6]) | (max_sg1_lpi_dfm_3_st_2[5])
      | (max_sg1_lpi_dfm_3_st_2[4]) | (max_sg1_lpi_dfm_3_st_2[3]);
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      S_OUT_rsc_mgc_out_stdreg_d <= 10'b0;
      H_OUT_rsc_mgc_out_stdreg_d <= 10'b0;
      else_7_if_1_ac_fixed_cctor_sg1_1_sva_duc <= 5'b0;
      else_7_if_1_div_3cyc_st_3 <= 2'b0;
      div_sdt_2_sva_duc <= 5'b0;
      div_sdt_3_sva_duc <= 5'b0;
      else_7_else_1_if_div_3cyc_st_3 <= 2'b0;
      else_7_else_1_else_div_3cyc_st_3 <= 2'b0;
      else_7_else_1_and_svs_st_3 <= 1'b0;
      else_7_and_svs_3 <= 1'b0;
      acc_3_itm_1 <= 10'b0;
      if_7_equal_svs_3 <= 1'b0;
      else_7_if_div_2cyc_st_2 <= 1'b0;
      mut_24_sg1_1 <= 7'b0;
      else_7_if_1_conc_1_tmp_mut_6_sg1 <= 11'b0;
      else_7_if_1_div_3cyc_st_2 <= 2'b0;
      else_7_else_1_if_conc_tmp_mut_4_sg1 <= 11'b0;
      else_7_else_1_if_div_3cyc_st_2 <= 2'b0;
      else_7_else_1_else_conc_tmp_mut_4_sg1 <= 11'b0;
      else_7_else_1_else_div_3cyc_st_2 <= 2'b0;
      else_7_else_1_and_svs_st_2 <= 1'b0;
      else_7_and_svs_st_2 <= 1'b0;
      max_sg1_lpi_dfm_3_st_2 <= 7'b0;
      if_7_equal_svs_st_2 <= 1'b0;
      div_mgc_div_10_b <= 7'b0;
      div_mgc_div_9_b <= 7'b0;
      max_sg1_lpi_dfm_3_mut_3 <= 7'b0;
      else_7_if_conc_tmp_mut_3_sg1 <= 7'b0;
      else_7_if_1_conc_1_tmp_mut_5_sg1 <= 11'b0;
      else_7_else_1_if_conc_tmp_mut_3_sg1 <= 11'b0;
      else_7_else_1_else_conc_tmp_mut_3_sg1 <= 11'b0;
      else_7_and_svs_st_1 <= 1'b0;
      if_7_equal_svs_st_1 <= 1'b0;
      else_7_if_div_2cyc <= 1'b0;
      else_7_if_1_div_3cyc <= 2'b0;
      else_7_else_1_if_div_3cyc <= 2'b0;
      else_7_else_1_else_div_3cyc <= 2'b0;
      main_stage_0_2 <= 1'b0;
      main_stage_0_3 <= 1'b0;
      main_stage_0_4 <= 1'b0;
      s_sva_2_duc <= 14'b0;
      unequal_tmp_2 <= 1'b0;
      unequal_tmp_1 <= 1'b0;
      else_7_else_1_and_svs_1 <= 1'b0;
      reg_div_mgc_div_7_b_tmp <= 7'b0;
      reg_div_mgc_div_7_a_tmp <= 11'b0;
      reg_div_mgc_div_8_b_tmp <= 7'b0;
      reg_div_mgc_div_8_a_tmp <= 11'b0;
      reg_div_mgc_div_b_tmp <= 7'b0;
      reg_div_mgc_div_a_tmp <= 11'b0;
      reg_div_mgc_div_4_b_tmp <= 7'b0;
      reg_div_mgc_div_4_a_tmp <= 11'b0;
      reg_div_mgc_div_5_b_tmp <= 7'b0;
      reg_div_mgc_div_5_a_tmp <= 11'b0;
      reg_div_mgc_div_6_b_tmp <= 7'b0;
      reg_div_mgc_div_6_a_tmp <= 11'b0;
      reg_div_mgc_div_1_b_tmp <= 7'b0;
      reg_div_mgc_div_1_a_tmp <= 11'b0;
      reg_div_mgc_div_2_b_tmp <= 7'b0;
      reg_div_mgc_div_2_a_tmp <= 11'b0;
      reg_div_mgc_div_3_b_tmp <= 7'b0;
      reg_div_mgc_div_3_a_tmp <= 11'b0;
      reg_div_mgc_div_10_a_tmp <= 7'b0;
      reg_div_mgc_div_9_a_tmp <= 7'b0;
    end
    else begin
      S_OUT_rsc_mgc_out_stdreg_d <= MUX_v_10_2_2({S_OUT_rsc_mgc_out_stdreg_d , acc_3_itm_1},
          main_stage_0_4);
      H_OUT_rsc_mgc_out_stdreg_d <= MUX_v_10_2_2({H_OUT_rsc_mgc_out_stdreg_d , ({3'b0
          , ((else_7_acc_itm[5:2]) & (signext_4_1(~ if_7_equal_svs_3))) , ((else_7_acc_itm[1])
          & (~ if_7_equal_svs_3)) , 2'b0})}, main_stage_0_4);
      else_7_if_1_ac_fixed_cctor_sg1_1_sva_duc <= MUX1HOT_v_5_4_2({(div_mgc_div_7_z[4:0])
          , (div_mgc_div_8_z[4:0]) , (div_mgc_div_z[4:0]) , else_7_if_1_ac_fixed_cctor_sg1_1_sva_duc},
          {(and_dcpl_60 & and_dcpl_54) , (and_dcpl_60 & and_dcpl_55) , (and_dcpl_60
          & and_dcpl_56) , (or_dcpl_20 | (~ else_7_and_svs_3) | and_dcpl_57)});
      else_7_if_1_div_3cyc_st_3 <= else_7_if_1_div_3cyc_st_2;
      div_sdt_2_sva_duc <= MUX1HOT_v_5_4_2({(div_mgc_div_4_z[4:0]) , (div_mgc_div_5_z[4:0])
          , (div_mgc_div_6_z[4:0]) , div_sdt_2_sva_duc}, {(and_dcpl_78 & and_dcpl_75
          & (~ (else_7_else_1_if_div_3cyc_st_3[0]))) , (and_dcpl_78 & and_dcpl_75
          & (else_7_else_1_if_div_3cyc_st_3[0])) , (and_dcpl_78 & else_7_else_1_and_svs_st_3
          & (else_7_else_1_if_div_3cyc_st_3[1]) & (~ (else_7_else_1_if_div_3cyc_st_3[0])))
          , (or_dcpl_25 | and_dcpl_74 | (~ else_7_else_1_and_svs_st_3))});
      div_sdt_3_sva_duc <= MUX1HOT_v_5_4_2({(div_mgc_div_1_z[4:0]) , (div_mgc_div_2_z[4:0])
          , (div_mgc_div_3_z[4:0]) , div_sdt_3_sva_duc}, {(and_dcpl_78 & and_dcpl_95
          & (~ (else_7_else_1_else_div_3cyc_st_3[0]))) , (and_dcpl_78 & and_dcpl_95
          & (else_7_else_1_else_div_3cyc_st_3[0])) , (and_dcpl_78 & (~ else_7_else_1_and_svs_st_3)
          & (else_7_else_1_else_div_3cyc_st_3[1]) & (~ (else_7_else_1_else_div_3cyc_st_3[0])))
          , (or_dcpl_25 | and_dcpl_94 | else_7_else_1_and_svs_st_3)});
      else_7_else_1_if_div_3cyc_st_3 <= else_7_else_1_if_div_3cyc_st_2;
      else_7_else_1_else_div_3cyc_st_3 <= else_7_else_1_else_div_3cyc_st_2;
      else_7_else_1_and_svs_st_3 <= else_7_else_1_and_svs_st_2;
      else_7_and_svs_3 <= else_7_and_svs_st_2;
      acc_3_itm_1 <= nl_acc_3_itm_1[9:0];
      if_7_equal_svs_3 <= if_7_equal_svs_st_2;
      else_7_if_div_2cyc_st_2 <= else_7_if_div_2cyc;
      mut_24_sg1_1 <= else_7_if_conc_tmp_mut_3_sg1;
      else_7_if_1_conc_1_tmp_mut_6_sg1 <= else_7_if_1_conc_1_tmp_mut_5_sg1;
      else_7_if_1_div_3cyc_st_2 <= else_7_if_1_div_3cyc;
      else_7_else_1_if_conc_tmp_mut_4_sg1 <= else_7_else_1_if_conc_tmp_mut_3_sg1;
      else_7_else_1_if_div_3cyc_st_2 <= else_7_else_1_if_div_3cyc;
      else_7_else_1_else_conc_tmp_mut_4_sg1 <= else_7_else_1_else_conc_tmp_mut_3_sg1;
      else_7_else_1_else_div_3cyc_st_2 <= else_7_else_1_else_div_3cyc;
      else_7_else_1_and_svs_st_2 <= else_7_else_1_and_svs_1;
      else_7_and_svs_st_2 <= else_7_and_svs_st_1;
      max_sg1_lpi_dfm_3_st_2 <= max_sg1_lpi_dfm_3_mut_3;
      if_7_equal_svs_st_2 <= if_7_equal_svs_st_1;
      div_mgc_div_10_b <= MUX_v_7_2_2({max_sg1_lpi_dfm_3_mut_3 , mux1h_24_tmp}, else_7_if_div_2cyc);
      div_mgc_div_9_b <= MUX_v_7_2_2({mux1h_24_tmp , max_sg1_lpi_dfm_3_mut_3}, else_7_if_div_2cyc);
      max_sg1_lpi_dfm_3_mut_3 <= mux1h_24_tmp;
      else_7_if_conc_tmp_mut_3_sg1 <= else_7_acc_4_itm[7:1];
      else_7_if_1_conc_1_tmp_mut_5_sg1 <= else_7_if_1_acc_1_itm[11:1];
      else_7_else_1_if_conc_tmp_mut_3_sg1 <= else_7_else_1_if_acc_2_itm[11:1];
      else_7_else_1_else_conc_tmp_mut_3_sg1 <= else_7_else_1_else_acc_2_itm[11:1];
      else_7_and_svs_st_1 <= else_7_if_1_equal_tmp & (~((r_1_lpi_dfm[9]) | (r_1_lpi_dfm[8])
          | (r_1_lpi_dfm[7])));
      if_7_equal_svs_st_1 <= if_7_equal_tmp;
      else_7_if_div_2cyc <= MUX_s_1_2_2({(~ else_7_if_div_2cyc) , else_7_if_div_2cyc},
          and_136_cse | if_7_equal_tmp);
      else_7_if_1_div_3cyc <= MUX_v_2_2_2({else_7_if_1_acc_tmp , else_7_if_1_div_3cyc},
          and_142_cse | or_dcpl_33);
      else_7_else_1_if_div_3cyc <= MUX_v_2_2_2({else_7_else_1_if_acc_tmp , else_7_else_1_if_div_3cyc},
          mux_tmp_16 | or_dcpl_110);
      else_7_else_1_else_div_3cyc <= MUX_v_2_2_2({else_7_else_1_else_acc_tmp , else_7_else_1_else_div_3cyc},
          (~ mux_18_cse) | if_7_equal_tmp);
      main_stage_0_2 <= 1'b1;
      main_stage_0_3 <= main_stage_0_2;
      main_stage_0_4 <= main_stage_0_3;
      s_sva_2_duc <= MUX1HOT_v_14_3_2({div_mgc_div_10_z , div_mgc_div_9_z , s_sva_2_duc},
          {(or_322_cse & and_dcpl & (~ else_7_if_div_2cyc_st_2)) , (or_322_cse &
          and_dcpl & else_7_if_div_2cyc_st_2) , (and_407_cse | (~ main_stage_0_3)
          | if_7_equal_svs_st_2)});
      unequal_tmp_2 <= unequal_tmp_1;
      unequal_tmp_1 <= unequal_tmp;
      else_7_else_1_and_svs_1 <= else_7_else_1_if_equal_tmp & (~((g_1_lpi_dfm[9])
          | (g_1_lpi_dfm[8]) | (g_1_lpi_dfm[7])));
      reg_div_mgc_div_7_b_tmp <= MUX1HOT_v_7_3_2({(else_7_acc_4_itm[7:1]) , else_7_if_conc_tmp_mut_3_sg1
          , mut_24_sg1_1}, {and_137_cse , and_143_cse , mux_21_cse});
      reg_div_mgc_div_7_a_tmp <= MUX1HOT_v_11_3_2({(else_7_if_1_acc_1_itm[11:1])
          , else_7_if_1_conc_1_tmp_mut_5_sg1 , else_7_if_1_conc_1_tmp_mut_6_sg1},
          {and_137_cse , and_143_cse , mux_21_cse});
      reg_div_mgc_div_8_b_tmp <= MUX1HOT_v_7_3_2({(else_7_acc_4_itm[7:1]) , else_7_if_conc_tmp_mut_3_sg1
          , mut_24_sg1_1}, {and_177_cse , and_183_cse , mux_23_cse});
      reg_div_mgc_div_8_a_tmp <= MUX1HOT_v_11_3_2({(else_7_if_1_acc_1_itm[11:1])
          , else_7_if_1_conc_1_tmp_mut_5_sg1 , else_7_if_1_conc_1_tmp_mut_6_sg1},
          {and_177_cse , and_183_cse , mux_23_cse});
      reg_div_mgc_div_b_tmp <= MUX1HOT_v_7_3_2({(else_7_acc_4_itm[7:1]) , else_7_if_conc_tmp_mut_3_sg1
          , mut_24_sg1_1}, {and_217_cse , and_223_cse , mux_25_cse});
      reg_div_mgc_div_a_tmp <= MUX1HOT_v_11_3_2({(else_7_if_1_acc_1_itm[11:1]) ,
          else_7_if_1_conc_1_tmp_mut_5_sg1 , else_7_if_1_conc_1_tmp_mut_6_sg1}, {and_217_cse
          , and_223_cse , mux_25_cse});
      reg_div_mgc_div_4_b_tmp <= MUX1HOT_v_7_3_2({(else_7_acc_4_itm[7:1]) , else_7_if_conc_tmp_mut_3_sg1
          , mut_24_sg1_1}, {and_250_cse , and_256_cse , mux_30_cse});
      reg_div_mgc_div_4_a_tmp <= MUX1HOT_v_11_3_2({(else_7_else_1_if_acc_2_itm[11:1])
          , else_7_else_1_if_conc_tmp_mut_3_sg1 , else_7_else_1_if_conc_tmp_mut_4_sg1},
          {and_250_cse , and_256_cse , mux_30_cse});
      reg_div_mgc_div_5_b_tmp <= MUX1HOT_v_7_3_2({(else_7_acc_4_itm[7:1]) , else_7_if_conc_tmp_mut_3_sg1
          , mut_24_sg1_1}, {and_272_cse , and_278_cse , mux_36_cse});
      reg_div_mgc_div_5_a_tmp <= MUX1HOT_v_11_3_2({(else_7_else_1_if_acc_2_itm[11:1])
          , else_7_else_1_if_conc_tmp_mut_3_sg1 , else_7_else_1_if_conc_tmp_mut_4_sg1},
          {and_272_cse , and_278_cse , mux_36_cse});
      reg_div_mgc_div_6_b_tmp <= MUX1HOT_v_7_3_2({(else_7_acc_4_itm[7:1]) , else_7_if_conc_tmp_mut_3_sg1
          , mut_24_sg1_1}, {and_294_cse , and_300_cse , mux_42_cse});
      reg_div_mgc_div_6_a_tmp <= MUX1HOT_v_11_3_2({(else_7_else_1_if_acc_2_itm[11:1])
          , else_7_else_1_if_conc_tmp_mut_3_sg1 , else_7_else_1_if_conc_tmp_mut_4_sg1},
          {and_294_cse , and_300_cse , mux_42_cse});
      reg_div_mgc_div_1_b_tmp <= MUX1HOT_v_7_3_2({(else_7_acc_4_itm[7:1]) , else_7_if_conc_tmp_mut_3_sg1
          , mut_24_sg1_1}, {and_317_cse , and_323_cse , mux_50_cse});
      reg_div_mgc_div_1_a_tmp <= MUX1HOT_v_11_3_2({(else_7_else_1_else_acc_2_itm[11:1])
          , else_7_else_1_else_conc_tmp_mut_3_sg1 , else_7_else_1_else_conc_tmp_mut_4_sg1},
          {and_317_cse , and_323_cse , mux_50_cse});
      reg_div_mgc_div_2_b_tmp <= MUX1HOT_v_7_3_2({(else_7_acc_4_itm[7:1]) , else_7_if_conc_tmp_mut_3_sg1
          , mut_24_sg1_1}, {and_339_cse , and_345_cse , mux_58_cse});
      reg_div_mgc_div_2_a_tmp <= MUX1HOT_v_11_3_2({(else_7_else_1_else_acc_2_itm[11:1])
          , else_7_else_1_else_conc_tmp_mut_3_sg1 , else_7_else_1_else_conc_tmp_mut_4_sg1},
          {and_339_cse , and_345_cse , mux_58_cse});
      reg_div_mgc_div_3_b_tmp <= MUX1HOT_v_7_3_2({(else_7_acc_4_itm[7:1]) , else_7_if_conc_tmp_mut_3_sg1
          , mut_24_sg1_1}, {and_361_cse , and_367_cse , mux_66_cse});
      reg_div_mgc_div_3_a_tmp <= MUX1HOT_v_11_3_2({(else_7_else_1_else_acc_2_itm[11:1])
          , else_7_else_1_else_conc_tmp_mut_3_sg1 , else_7_else_1_else_conc_tmp_mut_4_sg1},
          {and_361_cse , and_367_cse , mux_66_cse});
      reg_div_mgc_div_10_a_tmp <= MUX_v_7_2_2({else_7_if_conc_tmp_mut_3_sg1 , (else_7_acc_4_itm[7:1])},
          else_7_if_div_2cyc);
      reg_div_mgc_div_9_a_tmp <= MUX_v_7_2_2({(else_7_acc_4_itm[7:1]) , else_7_if_conc_tmp_mut_3_sg1},
          else_7_if_div_2cyc);
    end
  end
  assign nl_acc_3_itm_1  = (mul_1_itm[14:5]) + conv_u2u_1_10(mul_1_itm[4]);

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


  function [4:0] MUX1HOT_v_5_4_2;
    input [19:0] inputs;
    input [3:0] sel;
    reg [4:0] result;
    integer i;
  begin
    result = inputs[0+:5] & {5{sel[0]}};
    for( i = 1; i < 4; i = i + 1 )
      result = result | (inputs[i*5+:5] & {5{sel[i]}});
    MUX1HOT_v_5_4_2 = result;
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


  function [10:0] MUX1HOT_v_11_3_2;
    input [32:0] inputs;
    input [2:0] sel;
    reg [10:0] result;
    integer i;
  begin
    result = inputs[0+:11] & {11{sel[0]}};
    for( i = 1; i < 3; i = i + 1 )
      result = result | (inputs[i*11+:11] & {11{sel[i]}});
    MUX1HOT_v_11_3_2 = result;
  end
  endfunction


  function signed [11:0] conv_u2s_11_12 ;
    input [10:0]  vector ;
  begin
    conv_u2s_11_12 = {1'b0, vector};
  end
  endfunction


  function  [11:0] conv_u2u_11_12 ;
    input [10:0]  vector ;
  begin
    conv_u2u_11_12 = {1'b0, vector};
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
  r_rsc_z, g_rsc_z, b_rsc_z, H_OUT_rsc_z, S_OUT_rsc_z, V_OUT_rsc_z, clk, arst_n
);
  input [9:0] r_rsc_z;
  input [9:0] g_rsc_z;
  input [9:0] b_rsc_z;
  output [9:0] H_OUT_rsc_z;
  output [9:0] S_OUT_rsc_z;
  output [9:0] V_OUT_rsc_z;
  input clk;
  input arst_n;


  // Interconnect Declarations
  wire [9:0] r_rsc_mgc_in_wire_d;
  wire [9:0] g_rsc_mgc_in_wire_d;
  wire [9:0] b_rsc_mgc_in_wire_d;
  wire [9:0] H_OUT_rsc_mgc_out_stdreg_d;
  wire [9:0] S_OUT_rsc_mgc_out_stdreg_d;
  wire [17:0] div_mgc_div_a;
  wire [14:0] div_mgc_div_b;
  wire [17:0] div_mgc_div_z;
  wire [17:0] div_mgc_div_1_a;
  wire [14:0] div_mgc_div_1_b;
  wire [17:0] div_mgc_div_1_z;
  wire [17:0] div_mgc_div_2_a;
  wire [14:0] div_mgc_div_2_b;
  wire [17:0] div_mgc_div_2_z;
  wire [17:0] div_mgc_div_3_a;
  wire [14:0] div_mgc_div_3_b;
  wire [17:0] div_mgc_div_3_z;
  wire [17:0] div_mgc_div_4_a;
  wire [14:0] div_mgc_div_4_b;
  wire [17:0] div_mgc_div_4_z;
  wire [17:0] div_mgc_div_5_a;
  wire [14:0] div_mgc_div_5_b;
  wire [17:0] div_mgc_div_5_z;
  wire [17:0] div_mgc_div_6_a;
  wire [14:0] div_mgc_div_6_b;
  wire [17:0] div_mgc_div_6_z;
  wire [17:0] div_mgc_div_7_a;
  wire [14:0] div_mgc_div_7_b;
  wire [17:0] div_mgc_div_7_z;
  wire [17:0] div_mgc_div_8_a;
  wire [14:0] div_mgc_div_8_b;
  wire [17:0] div_mgc_div_8_z;
  wire [13:0] div_mgc_div_9_a;
  wire [6:0] div_mgc_div_9_b;
  wire [13:0] div_mgc_div_9_z;
  wire [13:0] div_mgc_div_10_a;
  wire [6:0] div_mgc_div_10_b;
  wire [13:0] div_mgc_div_10_z;


  // Interconnect Declarations for Component Instantiations 
  mgc_in_wire #(.rscid(1),
  .width(10)) r_rsc_mgc_in_wire (
      .d(r_rsc_mgc_in_wire_d),
      .z(r_rsc_z)
    );
  mgc_in_wire #(.rscid(2),
  .width(10)) g_rsc_mgc_in_wire (
      .d(g_rsc_mgc_in_wire_d),
      .z(g_rsc_z)
    );
  mgc_in_wire #(.rscid(3),
  .width(10)) b_rsc_mgc_in_wire (
      .d(b_rsc_mgc_in_wire_d),
      .z(b_rsc_z)
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
  mgc_div #(.width_a(18),
  .width_b(15),
  .signd(1)) div_mgc_div (
      .a(div_mgc_div_a),
      .b(div_mgc_div_b),
      .z(div_mgc_div_z)
    );
  mgc_div #(.width_a(18),
  .width_b(15),
  .signd(1)) div_mgc_div_1 (
      .a(div_mgc_div_1_a),
      .b(div_mgc_div_1_b),
      .z(div_mgc_div_1_z)
    );
  mgc_div #(.width_a(18),
  .width_b(15),
  .signd(1)) div_mgc_div_2 (
      .a(div_mgc_div_2_a),
      .b(div_mgc_div_2_b),
      .z(div_mgc_div_2_z)
    );
  mgc_div #(.width_a(18),
  .width_b(15),
  .signd(1)) div_mgc_div_3 (
      .a(div_mgc_div_3_a),
      .b(div_mgc_div_3_b),
      .z(div_mgc_div_3_z)
    );
  mgc_div #(.width_a(18),
  .width_b(15),
  .signd(1)) div_mgc_div_4 (
      .a(div_mgc_div_4_a),
      .b(div_mgc_div_4_b),
      .z(div_mgc_div_4_z)
    );
  mgc_div #(.width_a(18),
  .width_b(15),
  .signd(1)) div_mgc_div_5 (
      .a(div_mgc_div_5_a),
      .b(div_mgc_div_5_b),
      .z(div_mgc_div_5_z)
    );
  mgc_div #(.width_a(18),
  .width_b(15),
  .signd(1)) div_mgc_div_6 (
      .a(div_mgc_div_6_a),
      .b(div_mgc_div_6_b),
      .z(div_mgc_div_6_z)
    );
  mgc_div #(.width_a(18),
  .width_b(15),
  .signd(1)) div_mgc_div_7 (
      .a(div_mgc_div_7_a),
      .b(div_mgc_div_7_b),
      .z(div_mgc_div_7_z)
    );
  mgc_div #(.width_a(18),
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
      .r_rsc_mgc_in_wire_d(r_rsc_mgc_in_wire_d),
      .g_rsc_mgc_in_wire_d(g_rsc_mgc_in_wire_d),
      .b_rsc_mgc_in_wire_d(b_rsc_mgc_in_wire_d),
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



