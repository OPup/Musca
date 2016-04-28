
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
//  Generated by:   oh1015@EEWS104A-009
//  Generated date: Thu Apr 28 11:04:16 2016
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    HSVRGB_core
// ------------------------------------------------------------------


module HSVRGB_core (
  clk, arst_n, r_rsc_mgc_in_wire_d, g_rsc_mgc_in_wire_d, b_rsc_mgc_in_wire_d, H_OUT_rsc_mgc_out_stdreg_d,
      V_OUT_rsc_mgc_out_stdreg_d, div_mgc_div_a, div_mgc_div_b, div_mgc_div_z, div_mgc_div_1_a,
      div_mgc_div_1_b, div_mgc_div_1_z, div_mgc_div_2_a, div_mgc_div_2_b, div_mgc_div_2_z,
      div_mgc_div_3_a, div_mgc_div_3_b, div_mgc_div_3_z, div_mgc_div_4_a, div_mgc_div_4_b,
      div_mgc_div_4_z, div_mgc_div_5_a, div_mgc_div_5_b, div_mgc_div_5_z, div_mgc_div_6_a,
      div_mgc_div_6_b, div_mgc_div_6_z, div_mgc_div_7_a, div_mgc_div_7_b, div_mgc_div_7_z,
      div_mgc_div_8_a, div_mgc_div_8_b, div_mgc_div_8_z, div_mgc_div_9_a, div_mgc_div_9_b,
      div_mgc_div_9_z, div_mgc_div_10_a, div_mgc_div_10_b, div_mgc_div_10_z, div_mgc_div_11_a,
      div_mgc_div_11_b, div_mgc_div_11_z
);
  input clk;
  input arst_n;
  input [9:0] r_rsc_mgc_in_wire_d;
  input [9:0] g_rsc_mgc_in_wire_d;
  input [9:0] b_rsc_mgc_in_wire_d;
  output [9:0] H_OUT_rsc_mgc_out_stdreg_d;
  reg [9:0] H_OUT_rsc_mgc_out_stdreg_d;
  output [9:0] V_OUT_rsc_mgc_out_stdreg_d;
  reg [9:0] V_OUT_rsc_mgc_out_stdreg_d;
  output [20:0] div_mgc_div_a;
  output [20:0] div_mgc_div_b;
  input [20:0] div_mgc_div_z;
  output [20:0] div_mgc_div_1_a;
  output [20:0] div_mgc_div_1_b;
  input [20:0] div_mgc_div_1_z;
  output [20:0] div_mgc_div_2_a;
  output [20:0] div_mgc_div_2_b;
  input [20:0] div_mgc_div_2_z;
  output [20:0] div_mgc_div_3_a;
  output [20:0] div_mgc_div_3_b;
  input [20:0] div_mgc_div_3_z;
  output [20:0] div_mgc_div_4_a;
  output [20:0] div_mgc_div_4_b;
  input [20:0] div_mgc_div_4_z;
  output [20:0] div_mgc_div_5_a;
  output [20:0] div_mgc_div_5_b;
  input [20:0] div_mgc_div_5_z;
  output [20:0] div_mgc_div_6_a;
  output [20:0] div_mgc_div_6_b;
  input [20:0] div_mgc_div_6_z;
  output [20:0] div_mgc_div_7_a;
  output [20:0] div_mgc_div_7_b;
  input [20:0] div_mgc_div_7_z;
  output [20:0] div_mgc_div_8_a;
  output [20:0] div_mgc_div_8_b;
  input [20:0] div_mgc_div_8_z;
  output [20:0] div_mgc_div_9_a;
  output [20:0] div_mgc_div_9_b;
  input [20:0] div_mgc_div_9_z;
  output [20:0] div_mgc_div_10_a;
  output [20:0] div_mgc_div_10_b;
  input [20:0] div_mgc_div_10_z;
  output [20:0] div_mgc_div_11_a;
  output [20:0] div_mgc_div_11_b;
  input [20:0] div_mgc_div_11_z;


  // Interconnect Declarations
  wire [1:0] else_7_if_1_acc_tmp;
  wire [2:0] nl_else_7_if_1_acc_tmp;
  wire [1:0] else_7_else_1_if_acc_tmp;
  wire [2:0] nl_else_7_else_1_if_acc_tmp;
  wire [1:0] else_7_else_1_else_acc_tmp;
  wire [2:0] nl_else_7_else_1_else_acc_tmp;
  wire else_7_else_1_equal_tmp;
  wire else_7_equal_tmp;
  wire and_dcpl_23;
  wire and_dcpl_56;
  wire and_dcpl_141;
  wire and_dcpl_166;
  wire and_dcpl_243;
  wire and_dcpl_247;
  wire and_dcpl_252;
  wire and_dcpl_276;
  wire and_dcpl_277;
  wire and_dcpl_279;
  wire and_dcpl_282;
  wire and_dcpl_285;
  wire and_dcpl_293;
  wire and_dcpl_294;
  wire or_dcpl_355;
  wire and_dcpl_321;
  wire and_dcpl_322;
  wire and_dcpl_324;
  wire and_dcpl_327;
  wire and_dcpl_330;
  wire and_dcpl_339;
  wire and_dcpl_366;
  wire or_tmp_77;
  wire not_tmp_87;
  wire or_tmp_82;
  wire or_tmp_84;
  wire mux_tmp_25;
  wire or_tmp_87;
  wire and_tmp;
  wire and_dcpl_388;
  wire nor_tmp_9;
  wire mux_tmp_32;
  wire and_tmp_2;
  wire mux_tmp_40;
  wire or_tmp_129;
  wire mux_tmp_42;
  wire or_tmp_149;
  wire and_dcpl_455;
  wire or_tmp_156;
  wire and_tmp_4;
  wire mux_tmp_52;
  wire and_tmp_6;
  wire nor_tmp_23;
  wire mux_tmp_57;
  wire and_tmp_9;
  wire or_tmp_194;
  wire mux_tmp_62;
  wire or_tmp_204;
  wire mux_tmp_64;
  wire nor_tmp_25;
  wire mux_tmp_69;
  wire or_tmp_225;
  wire and_dcpl_567;
  wire or_tmp_238;
  wire and_tmp_13;
  wire mux_tmp_76;
  wire and_tmp_15;
  wire nor_tmp_31;
  wire mux_tmp_81;
  wire and_tmp_18;
  wire or_tmp_276;
  wire mux_tmp_86;
  wire or_tmp_286;
  wire mux_tmp_88;
  wire nor_tmp_33;
  wire mux_tmp_93;
  wire or_tmp_307;
  wire mux_tmp_95;
  wire and_dcpl_678;
  wire and_dcpl_680;
  wire and_dcpl_682;
  wire and_dcpl_684;
  reg else_7_equal_svs;
  reg [8:0] else_7_acc_psp_sva;
  reg [1:0] else_7_if_1_div_4cyc;
  reg [8:0] else_7_if_1_ac_fixed_cctor_sg1_1_sva_duc;
  reg [1:0] else_7_else_1_if_div_4cyc;
  reg [1:0] else_7_else_1_else_div_4cyc;
  reg else_7_else_1_equal_svs_1;
  reg else_7_else_1_equal_svs_2;
  reg else_7_else_1_equal_svs_3;
  reg else_7_else_1_equal_svs_4;
  reg unequal_tmp_2;
  reg unequal_tmp_3;
  reg unequal_tmp_4;
  reg unequal_tmp_5;
  reg else_7_equal_svs_2;
  reg else_7_equal_svs_3;
  reg else_7_equal_svs_4;
  reg [8:0] acc_5_itm_1;
  wire [9:0] nl_acc_5_itm_1;
  reg [8:0] acc_5_itm_2;
  reg [8:0] acc_5_itm_3;
  reg [8:0] acc_5_itm_4;
  reg [9:0] acc_2_psp_sva_st_1;
  reg [9:0] acc_2_psp_sva_st_2;
  reg [9:0] acc_2_psp_sva_st_3;
  reg else_7_equal_svs_st_1;
  reg else_7_equal_svs_st_2;
  reg else_7_equal_svs_st_3;
  reg [1:0] else_7_if_1_div_4cyc_st_1;
  reg [1:0] else_7_if_1_div_4cyc_st_2;
  reg [1:0] else_7_if_1_div_4cyc_st_3;
  reg [9:0] acc_2_psp_sva_st_4;
  reg else_7_equal_svs_st_4;
  reg [1:0] else_7_if_1_div_4cyc_st_4;
  reg else_7_else_1_equal_svs_st_1;
  reg else_7_else_1_equal_svs_st_2;
  reg else_7_else_1_equal_svs_st_3;
  reg [1:0] else_7_else_1_if_div_4cyc_st_1;
  reg [1:0] else_7_else_1_if_div_4cyc_st_2;
  reg [1:0] else_7_else_1_if_div_4cyc_st_3;
  reg else_7_else_1_equal_svs_st_4;
  reg [1:0] else_7_else_1_if_div_4cyc_st_4;
  reg [1:0] else_7_else_1_else_div_4cyc_st_1;
  reg [1:0] else_7_else_1_else_div_4cyc_st_2;
  reg [1:0] else_7_else_1_else_div_4cyc_st_3;
  reg [1:0] else_7_else_1_else_div_4cyc_st_4;
  reg main_stage_0_2;
  reg main_stage_0_3;
  reg main_stage_0_4;
  reg main_stage_0_5;
  reg [10:0] else_7_if_1_conc_1_tmp_mut_4_sg1;
  reg [10:0] else_7_if_1_conc_1_tmp_mut_5_sg1;
  reg [10:0] else_7_if_1_conc_1_tmp_mut_6_sg1;
  reg [10:0] else_7_else_1_else_conc_tmp_mut_4_sg1;
  reg [10:0] else_7_else_1_else_conc_tmp_mut_5_sg1;
  reg [10:0] else_7_else_1_else_conc_tmp_mut_6_sg1;
  reg [10:0] else_7_else_1_else_conc_tmp_mut_7_sg1;
  reg [10:0] else_7_else_1_else_conc_tmp_mut_8_sg1;
  reg [10:0] else_7_else_1_else_conc_tmp_mut_9_sg1;
  reg [10:0] else_7_else_1_else_conc_tmp_mut_10_sg1;
  reg [10:0] else_7_else_1_else_conc_tmp_mut_11_sg1;
  reg [10:0] else_7_else_1_else_conc_tmp_mut_12_sg1;
  reg [10:0] else_7_else_1_else_conc_tmp_mut_13_sg1;
  reg [10:0] else_7_else_1_else_conc_tmp_mut_14_sg1;
  reg [10:0] else_7_else_1_else_conc_tmp_mut_15_sg1;
  reg [10:0] else_7_else_1_if_conc_tmp_mut_4_sg1;
  reg [10:0] else_7_else_1_if_conc_tmp_mut_5_sg1;
  reg [10:0] else_7_else_1_if_conc_tmp_mut_6_sg1;
  reg [10:0] else_7_else_1_if_conc_tmp_mut_7_sg1;
  reg [10:0] else_7_else_1_if_conc_tmp_mut_8_sg1;
  reg [10:0] else_7_else_1_if_conc_tmp_mut_9_sg1;
  reg [10:0] else_7_else_1_if_conc_tmp_mut_10_sg1;
  reg [10:0] else_7_else_1_if_conc_tmp_mut_11_sg1;
  reg [10:0] else_7_else_1_if_conc_tmp_mut_12_sg1;
  reg [10:0] else_7_else_1_if_conc_tmp_mut_13_sg1;
  reg [10:0] else_7_else_1_if_conc_tmp_mut_14_sg1;
  reg [10:0] else_7_else_1_if_conc_tmp_mut_15_sg1;
  reg [10:0] else_7_if_1_conc_1_tmp_mut_7_sg1;
  reg [10:0] else_7_if_1_conc_1_tmp_mut_8_sg1;
  reg [10:0] else_7_if_1_conc_1_tmp_mut_9_sg1;
  reg [10:0] else_7_if_1_conc_1_tmp_mut_10_sg1;
  reg [10:0] else_7_if_1_conc_1_tmp_mut_11_sg1;
  reg [10:0] else_7_if_1_conc_1_tmp_mut_12_sg1;
  reg [10:0] else_7_if_1_conc_1_tmp_mut_13_sg1;
  reg [10:0] else_7_if_1_conc_1_tmp_mut_14_sg1;
  reg [10:0] else_7_if_1_conc_1_tmp_mut_15_sg1;
  reg [9:0] mut_12_sg1_1;
  reg [9:0] mut_13_sg1_1;
  reg [9:0] mut_14_sg1_1;
  reg [9:0] mut_15_sg1_1;
  reg [9:0] mut_16_sg1_1;
  reg [9:0] mut_17_sg1_1;
  reg [9:0] mut_18_sg1_1;
  reg [9:0] mut_19_sg1_1;
  reg [9:0] mut_20_sg1_1;
  reg [9:0] mut_21_sg1_1;
  reg [9:0] mut_22_sg1_1;
  reg [9:0] mut_23_sg1_1;
  reg [9:0] mut_24_sg1_1;
  reg [9:0] mut_25_sg1_1;
  reg [9:0] mut_26_sg1_1;
  reg [9:0] mut_27_sg1_1;
  reg [9:0] mut_28_sg1_1;
  reg [9:0] mut_29_sg1_1;
  reg [9:0] mut_30_sg1_1;
  reg [9:0] mut_31_sg1_1;
  reg [9:0] mut_32_sg1_1;
  reg [9:0] mut_33_sg1_1;
  reg [9:0] mut_34_sg1_1;
  reg [9:0] mut_35_sg1_1;
  reg [9:0] mut_36_sg1_1;
  reg [9:0] mut_37_sg1_1;
  reg [9:0] mut_38_sg1_1;
  reg [9:0] mut_39_sg1_1;
  reg [9:0] mut_40_sg1_1;
  reg [9:0] mut_41_sg1_1;
  reg [9:0] mut_42_sg1_1;
  reg [9:0] mut_43_sg1_1;
  reg [9:0] mut_44_sg1_1;
  reg [9:0] mut_45_sg1_1;
  reg [9:0] mut_46_sg1_1;
  reg [9:0] mut_47_sg1_1;
  wire [5:0] h_sg5_2_lpi_dfm_2;
  wire h_sg4_lpi_dfm_1_mx0;
  wire h_sg3_lpi_dfm_1_mx0;
  wire h_sg2_lpi_dfm_1_mx0;
  wire or_366_cse;
  wire and_1035_cse;
  wire and_378_cse;
  wire and_382_cse;
  wire and_386_cse;
  wire or_484_cse;
  wire and_406_cse;
  wire and_410_cse;
  wire and_430_cse;
  wire and_434_cse;
  wire and_452_cse;
  wire and_456_cse;
  wire and_477_cse;
  wire and_483_cse;
  wire and_508_cse;
  wire and_514_cse;
  wire and_539_cse;
  wire and_545_cse;
  wire and_568_cse;
  wire and_574_cse;
  wire and_598_cse;
  wire and_604_cse;
  wire and_629_cse;
  wire and_635_cse;
  wire and_660_cse;
  wire and_666_cse;
  wire and_689_cse;
  wire and_695_cse;
  wire and_718_cse;
  wire or_486_cse;
  wire or_529_cse;
  wire or_566_cse;
  wire or_640_cse;
  wire or_794_cse;
  reg reg_div_sdt_2_sva_duc_tmp;
  reg reg_div_sdt_2_sva_duc_tmp_8;
  reg [1:0] reg_div_sdt_3_sva_duc_tmp_7;
  reg [9:0] reg_div_mgc_div_9_b_tmp;
  reg [10:0] reg_div_mgc_div_9_a_tmp;
  reg [9:0] reg_div_mgc_div_10_b_tmp;
  reg [10:0] reg_div_mgc_div_10_a_tmp;
  reg [9:0] reg_div_mgc_div_11_b_tmp;
  reg [10:0] reg_div_mgc_div_11_a_tmp;
  reg [9:0] reg_div_mgc_div_b_tmp;
  reg [10:0] reg_div_mgc_div_a_tmp;
  reg [9:0] reg_div_mgc_div_5_b_tmp;
  reg [10:0] reg_div_mgc_div_5_a_tmp;
  reg [9:0] reg_div_mgc_div_6_b_tmp;
  reg [10:0] reg_div_mgc_div_6_a_tmp;
  reg [9:0] reg_div_mgc_div_7_b_tmp;
  reg [10:0] reg_div_mgc_div_7_a_tmp;
  reg [9:0] reg_div_mgc_div_8_b_tmp;
  reg [10:0] reg_div_mgc_div_8_a_tmp;
  reg [9:0] reg_div_mgc_div_1_b_tmp;
  reg [10:0] reg_div_mgc_div_1_a_tmp;
  reg [9:0] reg_div_mgc_div_2_b_tmp;
  reg [10:0] reg_div_mgc_div_2_a_tmp;
  reg [9:0] reg_div_mgc_div_3_b_tmp;
  reg [10:0] reg_div_mgc_div_3_a_tmp;
  reg [9:0] reg_div_mgc_div_4_b_tmp;
  reg [10:0] reg_div_mgc_div_4_a_tmp;
  wire mux_68_cse;
  wire and_402_cse;
  wire mux_75_cse;
  wire and_426_cse;
  wire and_448_cse;
  wire mux_89_cse;
  wire and_471_cse;
  wire mux_94_cse;
  wire and_503_cse;
  wire mux_99_cse;
  wire and_534_cse;
  wire and_563_cse;
  wire and_592_cse;
  wire mux_118_cse;
  wire and_624_cse;
  wire mux_123_cse;
  wire and_655_cse;
  wire and_684_cse;
  wire and_208_cse;
  wire and_106_cse;
  wire and_242_cse;
  wire and_148_cse;
  wire mux_111_cse;
  wire mux_84_cse;
  wire mux_105_cse;
  wire mux_129_cse;
  wire mux_136_cse;
  wire mux_112_cse;
  wire [9:0] else_7_acc_2_itm;
  wire [10:0] nl_else_7_acc_2_itm;
  wire [10:0] acc_itm;
  wire [11:0] nl_acc_itm;
  wire [8:0] else_7_acc_psp_sva_1;
  wire [8:0] else_7_if_1_ac_fixed_cctor_sg1_1_sva_duc_mx0;
  wire [7:0] else_7_else_1_if_ac_fixed_cctor_sg2_1_sva;
  wire [8:0] nl_else_7_else_1_if_ac_fixed_cctor_sg2_1_sva;
  wire [8:0] div_sdt_3_sva_duc_mx0;
  wire [6:0] else_7_else_1_else_ac_fixed_cctor_sg2_1_sva;
  wire [7:0] nl_else_7_else_1_else_ac_fixed_cctor_sg2_1_sva;
  wire [9:0] g_1_lpi_dfm;
  wire [9:0] b_1_lpi_dfm;
  wire [9:0] r_1_lpi_dfm;
  wire [9:0] max_sg1_lpi_dfm_3;
  wire or_cse;
  wire [11:0] if_if_acc_itm;
  wire [12:0] nl_if_if_acc_itm;
  wire [11:0] else_1_if_acc_itm;
  wire [12:0] nl_else_1_if_acc_itm;
  wire [11:0] if_3_if_acc_itm;
  wire [12:0] nl_if_3_if_acc_itm;
  wire [11:0] else_5_if_acc_itm;
  wire [12:0] nl_else_5_if_acc_itm;
  wire [11:0] else_7_if_1_acc_1_itm;
  wire [12:0] nl_else_7_if_1_acc_1_itm;
  wire [11:0] else_7_else_1_if_acc_2_itm;
  wire [12:0] nl_else_7_else_1_if_acc_2_itm;
  wire [11:0] else_7_else_1_else_acc_2_itm;
  wire [12:0] nl_else_7_else_1_else_acc_2_itm;
  wire [11:0] if_3_acc_1_itm;
  wire [12:0] nl_if_3_acc_1_itm;
  wire [11:0] if_acc_1_itm;
  wire [12:0] nl_if_acc_1_itm;
  wire [13:0] mul_itm;
  wire [27:0] nl_mul_itm;
  wire else_7_or_itm;

  wire[0:0] mux_63_nl;
  wire[0:0] mux_66_nl;
  wire[0:0] mux_67_nl;
  wire[0:0] mux_71_nl;
  wire[0:0] mux_73_nl;
  wire[0:0] mux_74_nl;
  wire[0:0] mux_78_nl;
  wire[0:0] mux_81_nl;
  wire[0:0] mux_88_nl;
  wire[0:0] mux_91_nl;
  wire[0:0] mux_93_nl;
  wire[0:0] mux_96_nl;
  wire[0:0] mux_98_nl;
  wire[0:0] mux_101_nl;
  wire[0:0] mux_103_nl;
  wire[0:0] mux_108_nl;
  wire[0:0] mux_110_nl;
  wire[0:0] mux_115_nl;
  wire[0:0] mux_117_nl;
  wire[0:0] mux_120_nl;
  wire[0:0] mux_122_nl;
  wire[0:0] mux_125_nl;
  wire[0:0] mux_127_nl;
  wire[0:0] mux_132_nl;
  wire[0:0] mux_134_nl;
  wire[7:0] mux1h_3_nl;
  wire[6:0] mux1h_6_nl;
  wire[0:0] else_7_else_1_mux_3_nl;
  wire[0:0] else_7_else_1_mux_4_nl;
  wire[0:0] else_7_else_1_mux_5_nl;
  wire[0:0] mux1h_2_nl;
  wire[9:0] mux1h_32_nl;
  wire[0:0] mux_140_nl;
  wire[0:0] mux_64_nl;
  wire[0:0] mux_79_nl;
  wire[0:0] mux_83_nl;

  // Interconnect Declarations for Component Instantiations 
  assign and_1035_cse = (~((acc_2_psp_sva_st_4[9]) | (acc_2_psp_sva_st_4[8]) | (acc_2_psp_sva_st_4[7])))
      & (~((acc_2_psp_sva_st_4[6]) | (acc_2_psp_sva_st_4[5]))) & (~((acc_2_psp_sva_st_4[4])
      | (acc_2_psp_sva_st_4[3]) | (acc_2_psp_sva_st_4[2]))) & (~((acc_2_psp_sva_st_4[1])
      | (acc_2_psp_sva_st_4[0])));
  assign or_366_cse = (acc_2_psp_sva_st_4[9]) | (acc_2_psp_sva_st_4[8]) | (acc_2_psp_sva_st_4[7])
      | (acc_2_psp_sva_st_4[6]) | (acc_2_psp_sva_st_4[5]) | (acc_2_psp_sva_st_4[4])
      | (acc_2_psp_sva_st_4[3]) | (acc_2_psp_sva_st_4[2]) | (acc_2_psp_sva_st_4[1])
      | (acc_2_psp_sva_st_4[0]);
  assign or_484_cse = (acc_itm[1]) | (acc_itm[2]) | (acc_itm[3]) | (acc_itm[4]) |
      (acc_itm[5]) | (acc_itm[6]) | (acc_itm[7]) | (acc_itm[8]) | (acc_itm[9]) |
      (acc_itm[10]);
  assign and_378_cse = or_484_cse & and_dcpl_366 & (~ (else_7_if_1_acc_tmp[1]));
  assign mux_63_nl = MUX_s_1_2_2({not_tmp_87 , or_tmp_77}, or_486_cse);
  assign and_382_cse = (mux_63_nl) & and_dcpl_141 & (~((else_7_if_1_div_4cyc_st_1[1])
      | (else_7_if_1_div_4cyc_st_1[0])));
  assign mux_66_nl = MUX_s_1_2_2({(~(else_7_equal_tmp | (~ mux_tmp_25))) , mux_tmp_25},
      or_486_cse);
  assign and_386_cse = (mux_66_nl) & and_dcpl_23 & (~((else_7_if_1_div_4cyc_st_2[1])
      | (else_7_if_1_div_4cyc_st_2[0])));
  assign mux_67_nl = MUX_s_1_2_2({and_tmp , (~(or_cse | (~ and_tmp)))}, else_7_equal_tmp);
  assign mux_68_cse = MUX_s_1_2_2({(mux_67_nl) , and_tmp}, (else_7_if_1_acc_tmp[1])
      | (else_7_if_1_acc_tmp[0]));
  assign div_mgc_div_9_b = {1'b0, {reg_div_mgc_div_9_b_tmp , 10'b0}};
  assign div_mgc_div_9_a = {reg_div_mgc_div_9_a_tmp , 10'b0};
  assign mux_71_nl = MUX_s_1_2_2({(~(nor_tmp_9 | (~ or_tmp_77))) , or_tmp_77}, or_529_cse);
  assign and_406_cse = (mux_71_nl) & and_dcpl_141 & (~ (else_7_if_1_div_4cyc_st_1[1]))
      & (else_7_if_1_div_4cyc_st_1[0]);
  assign mux_73_nl = MUX_s_1_2_2({(~(nor_tmp_9 | (~ mux_tmp_32))) , mux_tmp_32},
      or_529_cse);
  assign and_410_cse = (mux_73_nl) & and_dcpl_23 & (~ (else_7_if_1_div_4cyc_st_2[1]))
      & (else_7_if_1_div_4cyc_st_2[0]);
  assign and_402_cse = or_484_cse & and_dcpl_388 & (~ (else_7_if_1_acc_tmp[1]));
  assign mux_74_nl = MUX_s_1_2_2({and_tmp_2 , (~(or_cse | (~ and_tmp_2)))}, nor_tmp_9);
  assign mux_75_cse = MUX_s_1_2_2({(mux_74_nl) , and_tmp_2}, else_7_if_1_acc_tmp[1]);
  assign div_mgc_div_10_b = {1'b0, {reg_div_mgc_div_10_b_tmp , 10'b0}};
  assign div_mgc_div_10_a = {reg_div_mgc_div_10_a_tmp , 10'b0};
  assign mux_78_nl = MUX_s_1_2_2({not_tmp_87 , or_tmp_77}, or_566_cse);
  assign and_430_cse = (mux_78_nl) & and_dcpl_141 & (else_7_if_1_div_4cyc_st_1[1])
      & (~ (else_7_if_1_div_4cyc_st_1[0]));
  assign mux_81_nl = MUX_s_1_2_2({(~(else_7_equal_tmp | (~ mux_tmp_40))) , mux_tmp_40},
      or_566_cse);
  assign and_434_cse = (mux_81_nl) & and_dcpl_23 & (else_7_if_1_div_4cyc_st_2[1])
      & (~ (else_7_if_1_div_4cyc_st_2[0]));
  assign and_426_cse = or_484_cse & and_dcpl_366 & (else_7_if_1_acc_tmp[1]);
  assign div_mgc_div_11_b = {1'b0, {reg_div_mgc_div_11_b_tmp , 10'b0}};
  assign div_mgc_div_11_a = {reg_div_mgc_div_11_a_tmp , 10'b0};
  assign and_452_cse = (~(or_cse & (else_7_if_1_acc_tmp[1]) & (else_7_if_1_acc_tmp[0])
      & else_7_equal_tmp)) & or_tmp_77 & and_dcpl_141 & (else_7_if_1_div_4cyc_st_1[1])
      & (else_7_if_1_div_4cyc_st_1[0]);
  assign mux_88_nl = MUX_s_1_2_2({(~ or_tmp_82) , or_tmp_84}, (else_7_if_1_div_4cyc_st_1[0])
      & (else_7_if_1_div_4cyc_st_1[1]) & else_7_equal_svs_st_1);
  assign and_456_cse = (~((or_cse & (else_7_if_1_acc_tmp[1]) & (else_7_if_1_acc_tmp[0])
      & else_7_equal_tmp) | (mux_88_nl))) & and_dcpl_23 & (else_7_if_1_div_4cyc_st_2[1])
      & (else_7_if_1_div_4cyc_st_2[0]);
  assign and_448_cse = or_484_cse & and_dcpl_388 & (else_7_if_1_acc_tmp[1]);
  assign mux_89_cse = MUX_s_1_2_2({or_tmp_149 , (or_cse | or_tmp_149)}, (else_7_if_1_acc_tmp[1])
      & (else_7_if_1_acc_tmp[0]) & else_7_equal_tmp);
  assign div_mgc_div_b = {1'b0, {reg_div_mgc_div_b_tmp , 10'b0}};
  assign div_mgc_div_a = {reg_div_mgc_div_a_tmp , 10'b0};
  assign mux_91_nl = MUX_s_1_2_2({and_tmp_4 , or_tmp_77}, or_tmp_156);
  assign and_477_cse = (mux_91_nl) & and_208_cse & (~((else_7_else_1_if_div_4cyc_st_1[1])
      | (else_7_else_1_if_div_4cyc_st_1[0])));
  assign mux_93_nl = MUX_s_1_2_2({(or_640_cse & mux_tmp_52) , mux_tmp_52}, or_tmp_156);
  assign and_483_cse = (mux_93_nl) & and_106_cse & (~((else_7_else_1_if_div_4cyc_st_2[1])
      | (else_7_else_1_if_div_4cyc_st_2[0])));
  assign and_471_cse = or_484_cse & and_dcpl_455 & (~((else_7_else_1_if_acc_tmp[0])
      | (else_7_else_1_if_acc_tmp[1])));
  assign mux_94_cse = MUX_s_1_2_2({(~(or_cse | (~ and_tmp_6))) , and_tmp_6}, (else_7_else_1_if_acc_tmp[1])
      | (else_7_else_1_if_acc_tmp[0]) | (~ else_7_else_1_equal_tmp) | else_7_equal_tmp);
  assign div_mgc_div_5_b = {1'b0, {reg_div_mgc_div_5_b_tmp , 10'b0}};
  assign div_mgc_div_5_a = {reg_div_mgc_div_5_a_tmp , 10'b0};
  assign mux_96_nl = MUX_s_1_2_2({or_tmp_77 , and_tmp_4}, nor_tmp_23);
  assign and_508_cse = (mux_96_nl) & and_208_cse & (~ (else_7_else_1_if_div_4cyc_st_1[1]))
      & (else_7_else_1_if_div_4cyc_st_1[0]);
  assign mux_98_nl = MUX_s_1_2_2({mux_tmp_57 , (or_640_cse & mux_tmp_57)}, nor_tmp_23);
  assign and_514_cse = (mux_98_nl) & and_106_cse & (~ (else_7_else_1_if_div_4cyc_st_2[1]))
      & (else_7_else_1_if_div_4cyc_st_2[0]);
  assign and_503_cse = or_484_cse & and_dcpl_455 & (else_7_else_1_if_acc_tmp[0])
      & (~ (else_7_else_1_if_acc_tmp[1]));
  assign mux_99_cse = MUX_s_1_2_2({(~(or_cse | (~ and_tmp_9))) , and_tmp_9}, (else_7_else_1_if_acc_tmp[1])
      | (~ (else_7_else_1_if_acc_tmp[0])) | (~ else_7_else_1_equal_tmp) | else_7_equal_tmp);
  assign div_mgc_div_6_b = {1'b0, {reg_div_mgc_div_6_b_tmp , 10'b0}};
  assign div_mgc_div_6_a = {reg_div_mgc_div_6_a_tmp , 10'b0};
  assign mux_101_nl = MUX_s_1_2_2({and_tmp_4 , or_tmp_77}, or_tmp_194);
  assign and_539_cse = (mux_101_nl) & and_208_cse & (else_7_else_1_if_div_4cyc_st_1[1])
      & (~ (else_7_else_1_if_div_4cyc_st_1[0]));
  assign mux_103_nl = MUX_s_1_2_2({(or_640_cse & mux_tmp_62) , mux_tmp_62}, or_tmp_194);
  assign and_545_cse = (mux_103_nl) & and_106_cse & (else_7_else_1_if_div_4cyc_st_2[1])
      & (~ (else_7_else_1_if_div_4cyc_st_2[0]));
  assign and_534_cse = or_484_cse & and_dcpl_455 & (~ (else_7_else_1_if_acc_tmp[0]))
      & (else_7_else_1_if_acc_tmp[1]);
  assign div_mgc_div_7_b = {1'b0, {reg_div_mgc_div_7_b_tmp , 10'b0}};
  assign div_mgc_div_7_a = {reg_div_mgc_div_7_a_tmp , 10'b0};
  assign mux_108_nl = MUX_s_1_2_2({or_tmp_77 , and_tmp_4}, nor_tmp_25);
  assign and_568_cse = (mux_108_nl) & and_208_cse & (else_7_else_1_if_div_4cyc_st_1[1])
      & (else_7_else_1_if_div_4cyc_st_1[0]);
  assign mux_110_nl = MUX_s_1_2_2({mux_tmp_69 , (or_640_cse & mux_tmp_69)}, nor_tmp_25);
  assign and_574_cse = (mux_110_nl) & and_106_cse & (else_7_else_1_if_div_4cyc_st_2[1])
      & (else_7_else_1_if_div_4cyc_st_2[0]);
  assign and_563_cse = or_484_cse & and_dcpl_455 & (else_7_else_1_if_acc_tmp[0])
      & (else_7_else_1_if_acc_tmp[1]);
  assign div_mgc_div_8_b = {1'b0, {reg_div_mgc_div_8_b_tmp , 10'b0}};
  assign div_mgc_div_8_a = {reg_div_mgc_div_8_a_tmp , 10'b0};
  assign mux_115_nl = MUX_s_1_2_2({and_tmp_13 , or_tmp_77}, or_tmp_238);
  assign and_598_cse = (mux_115_nl) & and_242_cse & (~((else_7_else_1_else_div_4cyc_st_1[1])
      | (else_7_else_1_else_div_4cyc_st_1[0])));
  assign mux_117_nl = MUX_s_1_2_2({(or_794_cse & mux_tmp_76) , mux_tmp_76}, or_tmp_238);
  assign and_604_cse = (mux_117_nl) & and_148_cse & (~((else_7_else_1_else_div_4cyc_st_2[1])
      | (else_7_else_1_else_div_4cyc_st_2[0])));
  assign and_592_cse = or_484_cse & and_dcpl_567 & (~((else_7_else_1_else_acc_tmp[0])
      | (else_7_else_1_else_acc_tmp[1])));
  assign mux_118_cse = MUX_s_1_2_2({(~(or_cse | (~ and_tmp_15))) , and_tmp_15}, (else_7_else_1_else_acc_tmp[1])
      | (else_7_else_1_else_acc_tmp[0]) | else_7_else_1_equal_tmp | else_7_equal_tmp);
  assign div_mgc_div_1_b = {1'b0, {reg_div_mgc_div_1_b_tmp , 10'b0}};
  assign div_mgc_div_1_a = {reg_div_mgc_div_1_a_tmp , 10'b0};
  assign mux_120_nl = MUX_s_1_2_2({or_tmp_77 , and_tmp_13}, nor_tmp_31);
  assign and_629_cse = (mux_120_nl) & and_242_cse & (~ (else_7_else_1_else_div_4cyc_st_1[1]))
      & (else_7_else_1_else_div_4cyc_st_1[0]);
  assign mux_122_nl = MUX_s_1_2_2({mux_tmp_81 , (or_794_cse & mux_tmp_81)}, nor_tmp_31);
  assign and_635_cse = (mux_122_nl) & and_148_cse & (~ (else_7_else_1_else_div_4cyc_st_2[1]))
      & (else_7_else_1_else_div_4cyc_st_2[0]);
  assign and_624_cse = or_484_cse & and_dcpl_567 & (else_7_else_1_else_acc_tmp[0])
      & (~ (else_7_else_1_else_acc_tmp[1]));
  assign mux_123_cse = MUX_s_1_2_2({(~(or_cse | (~ and_tmp_18))) , and_tmp_18}, (else_7_else_1_else_acc_tmp[1])
      | (~ (else_7_else_1_else_acc_tmp[0])) | else_7_else_1_equal_tmp | else_7_equal_tmp);
  assign div_mgc_div_2_b = {1'b0, {reg_div_mgc_div_2_b_tmp , 10'b0}};
  assign div_mgc_div_2_a = {reg_div_mgc_div_2_a_tmp , 10'b0};
  assign mux_125_nl = MUX_s_1_2_2({and_tmp_13 , or_tmp_77}, or_tmp_276);
  assign and_660_cse = (mux_125_nl) & and_242_cse & (else_7_else_1_else_div_4cyc_st_1[1])
      & (~ (else_7_else_1_else_div_4cyc_st_1[0]));
  assign mux_127_nl = MUX_s_1_2_2({(or_794_cse & mux_tmp_86) , mux_tmp_86}, or_tmp_276);
  assign and_666_cse = (mux_127_nl) & and_148_cse & (else_7_else_1_else_div_4cyc_st_2[1])
      & (~ (else_7_else_1_else_div_4cyc_st_2[0]));
  assign and_655_cse = or_484_cse & and_dcpl_567 & (~ (else_7_else_1_else_acc_tmp[0]))
      & (else_7_else_1_else_acc_tmp[1]);
  assign div_mgc_div_3_b = {1'b0, {reg_div_mgc_div_3_b_tmp , 10'b0}};
  assign div_mgc_div_3_a = {reg_div_mgc_div_3_a_tmp , 10'b0};
  assign mux_132_nl = MUX_s_1_2_2({or_tmp_77 , and_tmp_13}, nor_tmp_33);
  assign and_689_cse = (mux_132_nl) & and_242_cse & (else_7_else_1_else_div_4cyc_st_1[1])
      & (else_7_else_1_else_div_4cyc_st_1[0]);
  assign mux_134_nl = MUX_s_1_2_2({mux_tmp_93 , (or_794_cse & mux_tmp_93)}, nor_tmp_33);
  assign and_695_cse = (mux_134_nl) & and_148_cse & (else_7_else_1_else_div_4cyc_st_2[1])
      & (else_7_else_1_else_div_4cyc_st_2[0]);
  assign and_684_cse = or_484_cse & and_dcpl_567 & (else_7_else_1_else_acc_tmp[0])
      & (else_7_else_1_else_acc_tmp[1]);
  assign div_mgc_div_4_b = {1'b0, {reg_div_mgc_div_4_b_tmp , 10'b0}};
  assign div_mgc_div_4_a = {reg_div_mgc_div_4_a_tmp , 10'b0};
  assign and_106_cse = and_dcpl_56 & else_7_else_1_equal_svs_st_2;
  assign and_148_cse = and_dcpl_56 & (~ else_7_else_1_equal_svs_st_2);
  assign and_208_cse = and_dcpl_166 & else_7_else_1_equal_svs_st_1;
  assign and_242_cse = and_dcpl_166 & (~ else_7_else_1_equal_svs_st_1);
  assign and_718_cse = and_dcpl_684 & and_dcpl_682 & and_dcpl_680 & and_dcpl_678;
  assign or_cse = (acc_itm[10]) | (acc_itm[9]) | (acc_itm[8]) | (acc_itm[7]) | (acc_itm[6])
      | (acc_itm[5]) | (acc_itm[4]) | (acc_itm[3]) | (acc_itm[2]) | (acc_itm[1]);
  assign else_7_acc_psp_sva_1 = MUX_v_9_2_2({(else_7_acc_2_itm[9:1]) , else_7_acc_psp_sva},
      and_1035_cse);
  assign nl_else_7_acc_2_itm = ({(~ h_sg5_2_lpi_dfm_2) , (~ h_sg4_lpi_dfm_1_mx0)
      , (~ h_sg3_lpi_dfm_1_mx0) , (~ h_sg2_lpi_dfm_1_mx0) , 1'b1}) + ({(h_sg5_2_lpi_dfm_2[1:0])
      , h_sg4_lpi_dfm_1_mx0 , h_sg3_lpi_dfm_1_mx0 , h_sg2_lpi_dfm_1_mx0 , 5'b1});
  assign else_7_acc_2_itm = nl_else_7_acc_2_itm[9:0];
  assign else_7_if_1_ac_fixed_cctor_sg1_1_sva_duc_mx0 = MUX1HOT_v_9_5_2({(div_mgc_div_9_z[8:0])
      , (div_mgc_div_10_z[8:0]) , (div_mgc_div_11_z[8:0]) , (div_mgc_div_z[8:0])
      , else_7_if_1_ac_fixed_cctor_sg1_1_sva_duc}, {(and_dcpl_243 & (~ (else_7_if_1_div_4cyc_st_4[0])))
      , (and_dcpl_243 & (else_7_if_1_div_4cyc_st_4[0])) , (and_dcpl_247 & (~ (else_7_if_1_div_4cyc_st_4[0])))
      , (and_dcpl_247 & (else_7_if_1_div_4cyc_st_4[0])) , (~ else_7_equal_svs_st_4)});
  assign mux1h_3_nl = MUX1HOT_v_8_4_2({(div_mgc_div_5_z[8:1]) , (div_mgc_div_6_z[8:1])
      , (div_mgc_div_7_z[8:1]) , (div_mgc_div_8_z[8:1])}, {and_dcpl_276 , and_dcpl_279
      , and_dcpl_282 , and_dcpl_285});
  assign nl_else_7_else_1_if_ac_fixed_cctor_sg2_1_sva = (mux1h_3_nl) + 8'b1;
  assign else_7_else_1_if_ac_fixed_cctor_sg2_1_sva = nl_else_7_else_1_if_ac_fixed_cctor_sg2_1_sva[7:0];
  assign div_sdt_3_sva_duc_mx0 = MUX1HOT_v_9_5_2({(div_mgc_div_1_z[8:0]) , (div_mgc_div_2_z[8:0])
      , (div_mgc_div_3_z[8:0]) , (div_mgc_div_4_z[8:0]) , ({reg_div_sdt_2_sva_duc_tmp
      , reg_div_sdt_2_sva_duc_tmp , reg_div_sdt_2_sva_duc_tmp , reg_div_sdt_2_sva_duc_tmp
      , reg_div_sdt_2_sva_duc_tmp , reg_div_sdt_2_sva_duc_tmp , reg_div_sdt_2_sva_duc_tmp
      , reg_div_sdt_3_sva_duc_tmp_7})}, {(and_dcpl_322 & and_dcpl_321) , (and_dcpl_322
      & and_dcpl_324) , (and_dcpl_322 & and_dcpl_327) , (and_dcpl_322 & and_dcpl_330)
      , (else_7_equal_svs_st_4 | else_7_else_1_equal_svs_st_4)});
  assign mux1h_6_nl = MUX1HOT_v_7_4_2({(div_mgc_div_1_z[8:2]) , (div_mgc_div_2_z[8:2])
      , (div_mgc_div_3_z[8:2]) , (div_mgc_div_4_z[8:2])}, {and_dcpl_321 , and_dcpl_324
      , and_dcpl_327 , and_dcpl_330});
  assign nl_else_7_else_1_else_ac_fixed_cctor_sg2_1_sva = (mux1h_6_nl) + 7'b1;
  assign else_7_else_1_else_ac_fixed_cctor_sg2_1_sva = nl_else_7_else_1_else_ac_fixed_cctor_sg2_1_sva[6:0];
  assign h_sg5_2_lpi_dfm_2 = MUX1HOT_v_6_3_2({(else_7_else_1_else_ac_fixed_cctor_sg2_1_sva[6:1])
      , (else_7_else_1_if_ac_fixed_cctor_sg2_1_sva[7:2]) , (else_7_if_1_ac_fixed_cctor_sg1_1_sva_duc_mx0[8:3])},
      {(~(else_7_else_1_equal_svs_4 | else_7_equal_svs_4)) , (else_7_else_1_equal_svs_4
      & (~ else_7_equal_svs_4)) , else_7_equal_svs_4});
  assign else_7_else_1_mux_3_nl = MUX_s_1_2_2({(else_7_else_1_else_ac_fixed_cctor_sg2_1_sva[0])
      , (else_7_else_1_if_ac_fixed_cctor_sg2_1_sva[1])}, else_7_else_1_equal_svs_4);
  assign h_sg4_lpi_dfm_1_mx0 = MUX_s_1_2_2({(else_7_else_1_mux_3_nl) , (else_7_if_1_ac_fixed_cctor_sg1_1_sva_duc_mx0[2])},
      else_7_equal_svs_4);
  assign else_7_else_1_mux_4_nl = MUX_s_1_2_2({(div_sdt_3_sva_duc_mx0[1]) , (else_7_else_1_if_ac_fixed_cctor_sg2_1_sva[0])},
      else_7_else_1_equal_svs_4);
  assign h_sg3_lpi_dfm_1_mx0 = MUX_s_1_2_2({(else_7_else_1_mux_4_nl) , (else_7_if_1_ac_fixed_cctor_sg1_1_sva_duc_mx0[1])},
      else_7_equal_svs_4);
  assign mux1h_2_nl = MUX1HOT_s_1_5_2({(div_mgc_div_5_z[0]) , (div_mgc_div_6_z[0])
      , (div_mgc_div_7_z[0]) , (div_mgc_div_8_z[0]) , reg_div_sdt_2_sva_duc_tmp_8},
      {(and_dcpl_277 & and_dcpl_276) , (and_dcpl_277 & and_dcpl_279) , (and_dcpl_277
      & and_dcpl_282) , (and_dcpl_277 & and_dcpl_285) , (else_7_equal_svs_st_4 |
      (~ else_7_else_1_equal_svs_st_4))});
  assign else_7_else_1_mux_5_nl = MUX_s_1_2_2({(div_sdt_3_sva_duc_mx0[0]) , (mux1h_2_nl)},
      else_7_else_1_equal_svs_4);
  assign h_sg2_lpi_dfm_1_mx0 = MUX_s_1_2_2({(else_7_else_1_mux_5_nl) , (else_7_if_1_ac_fixed_cctor_sg1_1_sva_duc_mx0[0])},
      else_7_equal_svs_4);
  assign mux1h_32_nl = MUX1HOT_v_10_3_2({r_rsc_mgc_in_wire_d , b_rsc_mgc_in_wire_d
      , g_rsc_mgc_in_wire_d}, {(~((if_3_if_acc_itm[11]) | (if_3_acc_1_itm[11])))
      , (((if_3_if_acc_itm[11]) & (~ (if_3_acc_1_itm[11]))) | ((else_5_if_acc_itm[11])
      & (if_3_acc_1_itm[11]))) , ((~ (else_5_if_acc_itm[11])) & (if_3_acc_1_itm[11]))});
  assign nl_acc_itm = ({max_sg1_lpi_dfm_3 , 1'b1}) + ({(~ (mux1h_32_nl)) , 1'b1});
  assign acc_itm = nl_acc_itm[10:0];
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
  assign nl_else_7_if_1_acc_1_itm = ({1'b1 , g_1_lpi_dfm , 1'b1}) + conv_u2s_11_12({(~
      b_1_lpi_dfm) , 1'b1});
  assign else_7_if_1_acc_1_itm = nl_else_7_if_1_acc_1_itm[11:0];
  assign nl_else_7_if_1_acc_tmp = else_7_if_1_div_4cyc + 2'b1;
  assign else_7_if_1_acc_tmp = nl_else_7_if_1_acc_tmp[1:0];
  assign g_1_lpi_dfm = g_rsc_mgc_in_wire_d & ({{9{else_7_or_itm}}, else_7_or_itm});
  assign b_1_lpi_dfm = b_rsc_mgc_in_wire_d & ({{9{else_7_or_itm}}, else_7_or_itm});
  assign nl_else_7_else_1_if_acc_2_itm = ({1'b1 , b_1_lpi_dfm , 1'b1}) + conv_u2s_11_12({(~
      r_1_lpi_dfm) , 1'b1});
  assign else_7_else_1_if_acc_2_itm = nl_else_7_else_1_if_acc_2_itm[11:0];
  assign nl_else_7_else_1_if_acc_tmp = else_7_else_1_if_div_4cyc + 2'b1;
  assign else_7_else_1_if_acc_tmp = nl_else_7_else_1_if_acc_tmp[1:0];
  assign r_1_lpi_dfm = r_rsc_mgc_in_wire_d & ({{9{else_7_or_itm}}, else_7_or_itm});
  assign nl_else_7_else_1_else_acc_2_itm = ({1'b1 , r_1_lpi_dfm , 1'b1}) + conv_u2s_11_12({(~
      g_1_lpi_dfm) , 1'b1});
  assign else_7_else_1_else_acc_2_itm = nl_else_7_else_1_else_acc_2_itm[11:0];
  assign nl_else_7_else_1_else_acc_tmp = else_7_else_1_else_div_4cyc + 2'b1;
  assign else_7_else_1_else_acc_tmp = nl_else_7_else_1_else_acc_tmp[1:0];
  assign else_7_else_1_equal_tmp = g_1_lpi_dfm == max_sg1_lpi_dfm_3;
  assign max_sg1_lpi_dfm_3 = MUX1HOT_v_10_3_2({r_rsc_mgc_in_wire_d , b_rsc_mgc_in_wire_d
      , g_rsc_mgc_in_wire_d}, {(~((if_if_acc_itm[11]) | (if_acc_1_itm[11]))) , (((if_if_acc_itm[11])
      & (~ (if_acc_1_itm[11]))) | ((else_1_if_acc_itm[11]) & (if_acc_1_itm[11])))
      , ((~ (else_1_if_acc_itm[11])) & (if_acc_1_itm[11]))});
  assign else_7_equal_tmp = r_1_lpi_dfm == max_sg1_lpi_dfm_3;
  assign nl_if_3_acc_1_itm = ({1'b1 , g_rsc_mgc_in_wire_d , 1'b1}) + conv_u2u_11_12({(~
      r_rsc_mgc_in_wire_d) , 1'b1});
  assign if_3_acc_1_itm = nl_if_3_acc_1_itm[11:0];
  assign nl_if_acc_1_itm = ({1'b1 , r_rsc_mgc_in_wire_d , 1'b1}) + conv_u2u_11_12({(~
      g_rsc_mgc_in_wire_d) , 1'b1});
  assign if_acc_1_itm = nl_if_acc_1_itm[11:0];
  assign nl_mul_itm = 14'b11001 * conv_u2u_10_14(max_sg1_lpi_dfm_3);
  assign mul_itm = nl_mul_itm[13:0];
  assign else_7_or_itm = (max_sg1_lpi_dfm_3[9]) | (max_sg1_lpi_dfm_3[8]) | (max_sg1_lpi_dfm_3[7])
      | (max_sg1_lpi_dfm_3[6]) | (max_sg1_lpi_dfm_3[5]) | (max_sg1_lpi_dfm_3[4])
      | (max_sg1_lpi_dfm_3[3]) | (max_sg1_lpi_dfm_3[2]) | (max_sg1_lpi_dfm_3[1])
      | (max_sg1_lpi_dfm_3[0]);
  assign and_dcpl_23 = main_stage_0_3 & else_7_equal_svs_st_2;
  assign and_dcpl_56 = main_stage_0_3 & (~ else_7_equal_svs_st_2);
  assign and_dcpl_141 = main_stage_0_2 & else_7_equal_svs_st_1;
  assign and_dcpl_166 = main_stage_0_2 & (~ else_7_equal_svs_st_1);
  assign and_dcpl_243 = else_7_equal_svs_st_4 & (~ (else_7_if_1_div_4cyc_st_4[1]));
  assign and_dcpl_247 = else_7_equal_svs_st_4 & (else_7_if_1_div_4cyc_st_4[1]);
  assign and_dcpl_252 = main_stage_0_5 & else_7_equal_svs_st_4;
  assign and_dcpl_276 = ~((else_7_else_1_if_div_4cyc_st_4[1]) | (else_7_else_1_if_div_4cyc_st_4[0]));
  assign and_dcpl_277 = (~ else_7_equal_svs_st_4) & else_7_else_1_equal_svs_st_4;
  assign and_dcpl_279 = (~ (else_7_else_1_if_div_4cyc_st_4[1])) & (else_7_else_1_if_div_4cyc_st_4[0]);
  assign and_dcpl_282 = (else_7_else_1_if_div_4cyc_st_4[1]) & (~ (else_7_else_1_if_div_4cyc_st_4[0]));
  assign and_dcpl_285 = (else_7_else_1_if_div_4cyc_st_4[1]) & (else_7_else_1_if_div_4cyc_st_4[0]);
  assign and_dcpl_293 = main_stage_0_5 & (~ else_7_equal_svs_st_4);
  assign and_dcpl_294 = and_dcpl_293 & else_7_else_1_equal_svs_st_4;
  assign or_dcpl_355 = (~ main_stage_0_5) | else_7_equal_svs_st_4;
  assign and_dcpl_321 = ~((else_7_else_1_else_div_4cyc_st_4[1]) | (else_7_else_1_else_div_4cyc_st_4[0]));
  assign and_dcpl_322 = ~(else_7_equal_svs_st_4 | else_7_else_1_equal_svs_st_4);
  assign and_dcpl_324 = (~ (else_7_else_1_else_div_4cyc_st_4[1])) & (else_7_else_1_else_div_4cyc_st_4[0]);
  assign and_dcpl_327 = (else_7_else_1_else_div_4cyc_st_4[1]) & (~ (else_7_else_1_else_div_4cyc_st_4[0]));
  assign and_dcpl_330 = (else_7_else_1_else_div_4cyc_st_4[1]) & (else_7_else_1_else_div_4cyc_st_4[0]);
  assign and_dcpl_339 = and_dcpl_293 & (~ else_7_else_1_equal_svs_st_4);
  assign and_dcpl_366 = else_7_equal_tmp & (~ (else_7_if_1_acc_tmp[0]));
  assign or_tmp_77 = (acc_2_psp_sva_st_1[1]) | (acc_2_psp_sva_st_1[2]) | (acc_2_psp_sva_st_1[3])
      | (acc_2_psp_sva_st_1[4]) | (acc_2_psp_sva_st_1[5]) | (acc_2_psp_sva_st_1[6])
      | (acc_2_psp_sva_st_1[7]) | (acc_2_psp_sva_st_1[8]) | (acc_2_psp_sva_st_1[0])
      | (acc_2_psp_sva_st_1[9]);
  assign not_tmp_87 = ~(else_7_equal_tmp | (~ or_tmp_77));
  assign or_486_cse = (~ or_cse) | (else_7_if_1_acc_tmp[1]) | (else_7_if_1_acc_tmp[0]);
  assign or_tmp_82 = (acc_2_psp_sva_st_2[0]) | (acc_2_psp_sva_st_2[1]) | (acc_2_psp_sva_st_2[2])
      | (acc_2_psp_sva_st_2[3]) | (acc_2_psp_sva_st_2[4]) | (acc_2_psp_sva_st_2[5])
      | (acc_2_psp_sva_st_2[6]) | (acc_2_psp_sva_st_2[7]) | (acc_2_psp_sva_st_2[8])
      | (acc_2_psp_sva_st_2[9]);
  assign or_tmp_84 = ~((~(or_tmp_77 & main_stage_0_2)) & or_tmp_82);
  assign mux_140_nl = MUX_s_1_2_2({or_tmp_82 , (~ or_tmp_84)}, else_7_equal_svs_st_1);
  assign mux_tmp_25 = MUX_s_1_2_2({(mux_140_nl) , or_tmp_82}, (else_7_if_1_div_4cyc_st_1[0])
      | (else_7_if_1_div_4cyc_st_1[1]));
  assign or_tmp_87 = (acc_2_psp_sva_st_1[0]) | (acc_2_psp_sva_st_1[1]) | (acc_2_psp_sva_st_1[2])
      | (acc_2_psp_sva_st_1[3]) | (acc_2_psp_sva_st_1[4]) | (acc_2_psp_sva_st_1[5])
      | (acc_2_psp_sva_st_1[6]) | (acc_2_psp_sva_st_1[7]) | (acc_2_psp_sva_st_1[8])
      | (acc_2_psp_sva_st_1[9]);
  assign and_tmp = ((~ or_tmp_87) | (~ main_stage_0_2) | (~ else_7_equal_svs_st_1)
      | (else_7_if_1_div_4cyc_st_1[0]) | (else_7_if_1_div_4cyc_st_1[1])) & ((~ or_tmp_82)
      | (~ main_stage_0_3) | (~ else_7_equal_svs_st_2) | (else_7_if_1_div_4cyc_st_2[0])
      | (else_7_if_1_div_4cyc_st_2[1]));
  assign and_dcpl_388 = else_7_equal_tmp & (else_7_if_1_acc_tmp[0]);
  assign nor_tmp_9 = (else_7_if_1_acc_tmp[0]) & else_7_equal_tmp;
  assign or_529_cse = (~ or_cse) | (else_7_if_1_acc_tmp[1]);
  assign mux_64_nl = MUX_s_1_2_2({or_tmp_82 , (~ or_tmp_84)}, else_7_equal_svs_st_1);
  assign mux_tmp_32 = MUX_s_1_2_2({(mux_64_nl) , or_tmp_82}, (~ (else_7_if_1_div_4cyc_st_1[0]))
      | (else_7_if_1_div_4cyc_st_1[1]));
  assign and_tmp_2 = (~(or_tmp_87 & main_stage_0_2 & else_7_equal_svs_st_1 & (else_7_if_1_div_4cyc_st_1[0])
      & (~ (else_7_if_1_div_4cyc_st_1[1])))) & (~(or_tmp_82 & main_stage_0_3 & else_7_equal_svs_st_2
      & (else_7_if_1_div_4cyc_st_2[0]) & (~ (else_7_if_1_div_4cyc_st_2[1]))));
  assign or_566_cse = (~ or_cse) | (~ (else_7_if_1_acc_tmp[1])) | (else_7_if_1_acc_tmp[0]);
  assign mux_79_nl = MUX_s_1_2_2({or_tmp_82 , (~ or_tmp_84)}, (else_7_if_1_div_4cyc_st_1[1])
      & else_7_equal_svs_st_1);
  assign mux_tmp_40 = MUX_s_1_2_2({(mux_79_nl) , or_tmp_82}, else_7_if_1_div_4cyc_st_1[0]);
  assign or_tmp_129 = ~(or_tmp_82 & main_stage_0_3 & else_7_equal_svs_st_2 & (~ (else_7_if_1_div_4cyc_st_2[0]))
      & (else_7_if_1_div_4cyc_st_2[1]));
  assign mux_tmp_42 = MUX_s_1_2_2({(~((else_7_if_1_div_4cyc_st_1[1]) | (~ or_tmp_129)))
      , or_tmp_129}, ~(or_tmp_87 & main_stage_0_2 & else_7_equal_svs_st_1 & (~ (else_7_if_1_div_4cyc_st_1[0]))));
  assign or_tmp_149 = (or_tmp_87 & main_stage_0_2 & else_7_equal_svs_st_1 & (else_7_if_1_div_4cyc_st_1[0])
      & (else_7_if_1_div_4cyc_st_1[1])) | (or_tmp_82 & main_stage_0_3 & else_7_equal_svs_st_2
      & (else_7_if_1_div_4cyc_st_2[0]) & (else_7_if_1_div_4cyc_st_2[1]));
  assign and_dcpl_455 = (~ else_7_equal_tmp) & else_7_else_1_equal_tmp;
  assign or_tmp_156 = (else_7_else_1_if_acc_tmp[1]) | (else_7_else_1_if_acc_tmp[0]);
  assign or_640_cse = (~ or_cse) | (~ else_7_else_1_equal_tmp) | else_7_equal_tmp;
  assign and_tmp_4 = or_640_cse & or_tmp_77;
  assign mux_tmp_52 = MUX_s_1_2_2({(~ or_tmp_84) , or_tmp_82}, (else_7_else_1_if_div_4cyc_st_1[0])
      | (else_7_else_1_if_div_4cyc_st_1[1]) | (~ else_7_else_1_equal_svs_st_1) |
      else_7_equal_svs_st_1);
  assign and_tmp_6 = ((~ or_tmp_87) | (~ main_stage_0_2) | else_7_equal_svs_st_1
      | (~ else_7_else_1_equal_svs_st_1) | (else_7_else_1_if_div_4cyc_st_1[0]) |
      (else_7_else_1_if_div_4cyc_st_1[1])) & ((~ or_tmp_82) | (~ main_stage_0_3)
      | else_7_equal_svs_st_2 | (~ else_7_else_1_equal_svs_st_2) | (else_7_else_1_if_div_4cyc_st_2[0])
      | (else_7_else_1_if_div_4cyc_st_2[1]));
  assign nor_tmp_23 = ~((else_7_else_1_if_acc_tmp[1]) | (~ (else_7_else_1_if_acc_tmp[0])));
  assign mux_tmp_57 = MUX_s_1_2_2({(~ or_tmp_84) , or_tmp_82}, (~ (else_7_else_1_if_div_4cyc_st_1[0]))
      | (else_7_else_1_if_div_4cyc_st_1[1]) | (~ else_7_else_1_equal_svs_st_1) |
      else_7_equal_svs_st_1);
  assign and_tmp_9 = ((~ or_tmp_87) | (~ main_stage_0_2) | else_7_equal_svs_st_1
      | (~ else_7_else_1_equal_svs_st_1) | (~ (else_7_else_1_if_div_4cyc_st_1[0]))
      | (else_7_else_1_if_div_4cyc_st_1[1])) & ((~ or_tmp_82) | (~ main_stage_0_3)
      | else_7_equal_svs_st_2 | (~ else_7_else_1_equal_svs_st_2) | (~ (else_7_else_1_if_div_4cyc_st_2[0]))
      | (else_7_else_1_if_div_4cyc_st_2[1]));
  assign or_tmp_194 = (~ (else_7_else_1_if_acc_tmp[1])) | (else_7_else_1_if_acc_tmp[0]);
  assign mux_tmp_62 = MUX_s_1_2_2({(~ or_tmp_84) , or_tmp_82}, (else_7_else_1_if_div_4cyc_st_1[0])
      | (~ (else_7_else_1_if_div_4cyc_st_1[1])) | (~ else_7_else_1_equal_svs_st_1)
      | else_7_equal_svs_st_1);
  assign or_tmp_204 = (~ or_tmp_82) | (~ main_stage_0_3) | else_7_equal_svs_st_2
      | (~ else_7_else_1_equal_svs_st_2) | (else_7_else_1_if_div_4cyc_st_2[0]) |
      (~ (else_7_else_1_if_div_4cyc_st_2[1]));
  assign mux_tmp_64 = MUX_s_1_2_2({(~((else_7_else_1_if_div_4cyc_st_1[1]) | (~ or_tmp_204)))
      , or_tmp_204}, (~ or_tmp_87) | (~ main_stage_0_2) | else_7_equal_svs_st_1 |
      (~ else_7_else_1_equal_svs_st_1) | (else_7_else_1_if_div_4cyc_st_1[0]));
  assign nor_tmp_25 = (else_7_else_1_if_acc_tmp[1]) & (else_7_else_1_if_acc_tmp[0]);
  assign mux_tmp_69 = MUX_s_1_2_2({(~ or_tmp_84) , or_tmp_82}, ~((else_7_else_1_if_div_4cyc_st_1[0])
      & (else_7_else_1_if_div_4cyc_st_1[1]) & else_7_else_1_equal_svs_st_1 & (~ else_7_equal_svs_st_1)));
  assign or_tmp_225 = ~(or_tmp_82 & main_stage_0_3 & (~ else_7_equal_svs_st_2) &
      else_7_else_1_equal_svs_st_2 & (else_7_else_1_if_div_4cyc_st_2[0]) & (else_7_else_1_if_div_4cyc_st_2[1]));
  assign mux_111_cse = MUX_s_1_2_2({((~(else_7_else_1_equal_svs_st_1 & (else_7_else_1_if_div_4cyc_st_1[0])
      & (else_7_else_1_if_div_4cyc_st_1[1]))) & or_tmp_225) , or_tmp_225}, (~ or_tmp_87)
      | (~ main_stage_0_2) | else_7_equal_svs_st_1);
  assign and_dcpl_567 = ~(else_7_equal_tmp | else_7_else_1_equal_tmp);
  assign or_tmp_238 = (else_7_else_1_else_acc_tmp[1]) | (else_7_else_1_else_acc_tmp[0]);
  assign or_794_cse = (~ or_cse) | else_7_else_1_equal_tmp | else_7_equal_tmp;
  assign and_tmp_13 = or_794_cse & or_tmp_77;
  assign mux_tmp_76 = MUX_s_1_2_2({(~ or_tmp_84) , or_tmp_82}, (else_7_else_1_else_div_4cyc_st_1[0])
      | (else_7_else_1_else_div_4cyc_st_1[1]) | else_7_else_1_equal_svs_st_1 | else_7_equal_svs_st_1);
  assign and_tmp_15 = ((~ or_tmp_87) | (~ main_stage_0_2) | else_7_equal_svs_st_1
      | else_7_else_1_equal_svs_st_1 | (else_7_else_1_else_div_4cyc_st_1[0]) | (else_7_else_1_else_div_4cyc_st_1[1]))
      & ((~ or_tmp_82) | (~ main_stage_0_3) | else_7_equal_svs_st_2 | else_7_else_1_equal_svs_st_2
      | (else_7_else_1_else_div_4cyc_st_2[0]) | (else_7_else_1_else_div_4cyc_st_2[1]));
  assign nor_tmp_31 = ~((else_7_else_1_else_acc_tmp[1]) | (~ (else_7_else_1_else_acc_tmp[0])));
  assign mux_tmp_81 = MUX_s_1_2_2({(~ or_tmp_84) , or_tmp_82}, (~ (else_7_else_1_else_div_4cyc_st_1[0]))
      | (else_7_else_1_else_div_4cyc_st_1[1]) | else_7_else_1_equal_svs_st_1 | else_7_equal_svs_st_1);
  assign and_tmp_18 = ((~ or_tmp_87) | (~ main_stage_0_2) | else_7_equal_svs_st_1
      | else_7_else_1_equal_svs_st_1 | (~ (else_7_else_1_else_div_4cyc_st_1[0]))
      | (else_7_else_1_else_div_4cyc_st_1[1])) & ((~ or_tmp_82) | (~ main_stage_0_3)
      | else_7_equal_svs_st_2 | else_7_else_1_equal_svs_st_2 | (~ (else_7_else_1_else_div_4cyc_st_2[0]))
      | (else_7_else_1_else_div_4cyc_st_2[1]));
  assign or_tmp_276 = (~ (else_7_else_1_else_acc_tmp[1])) | (else_7_else_1_else_acc_tmp[0]);
  assign mux_tmp_86 = MUX_s_1_2_2({(~ or_tmp_84) , or_tmp_82}, (else_7_else_1_else_div_4cyc_st_1[0])
      | (~ (else_7_else_1_else_div_4cyc_st_1[1])) | else_7_else_1_equal_svs_st_1
      | else_7_equal_svs_st_1);
  assign or_tmp_286 = (~ or_tmp_82) | (~ main_stage_0_3) | else_7_equal_svs_st_2
      | else_7_else_1_equal_svs_st_2 | (else_7_else_1_else_div_4cyc_st_2[0]) | (~
      (else_7_else_1_else_div_4cyc_st_2[1]));
  assign mux_tmp_88 = MUX_s_1_2_2({(~((else_7_else_1_else_div_4cyc_st_1[1]) | (~
      or_tmp_286))) , or_tmp_286}, (~ or_tmp_87) | (~ main_stage_0_2) | else_7_equal_svs_st_1
      | else_7_else_1_equal_svs_st_1 | (else_7_else_1_else_div_4cyc_st_1[0]));
  assign nor_tmp_33 = (else_7_else_1_else_acc_tmp[1]) & (else_7_else_1_else_acc_tmp[0]);
  assign mux_tmp_93 = MUX_s_1_2_2({(~ or_tmp_84) , or_tmp_82}, (~ (else_7_else_1_else_div_4cyc_st_1[0]))
      | (~ (else_7_else_1_else_div_4cyc_st_1[1])) | else_7_else_1_equal_svs_st_1
      | else_7_equal_svs_st_1);
  assign or_tmp_307 = (~ or_tmp_82) | (~ main_stage_0_3) | else_7_equal_svs_st_2
      | else_7_else_1_equal_svs_st_2 | (~((else_7_else_1_else_div_4cyc_st_2[0]) &
      (else_7_else_1_else_div_4cyc_st_2[1])));
  assign mux_tmp_95 = MUX_s_1_2_2({((~((else_7_else_1_else_div_4cyc_st_1[0]) & (else_7_else_1_else_div_4cyc_st_1[1])))
      & or_tmp_307) , or_tmp_307}, (~ or_tmp_87) | (~ main_stage_0_2) | else_7_equal_svs_st_1
      | else_7_else_1_equal_svs_st_1);
  assign and_dcpl_678 = ~((acc_itm[9]) | (acc_itm[10]));
  assign and_dcpl_680 = ~((acc_itm[6]) | (acc_itm[7]) | (acc_itm[8]));
  assign and_dcpl_682 = ~((acc_itm[4]) | (acc_itm[5]));
  assign and_dcpl_684 = ~((acc_itm[1]) | (acc_itm[2]) | (acc_itm[3]));
  assign mux_83_nl = MUX_s_1_2_2({mux_tmp_42 , (~(or_cse | (~ mux_tmp_42)))}, else_7_equal_tmp);
  assign mux_84_cse = MUX_s_1_2_2({(mux_83_nl) , mux_tmp_42}, (~ (else_7_if_1_acc_tmp[1]))
      | (else_7_if_1_acc_tmp[0]));
  assign mux_105_cse = MUX_s_1_2_2({(~(or_cse | (~ mux_tmp_64))) , mux_tmp_64}, (~
      (else_7_else_1_if_acc_tmp[1])) | (else_7_else_1_if_acc_tmp[0]) | (~ else_7_else_1_equal_tmp)
      | else_7_equal_tmp);
  assign mux_112_cse = MUX_s_1_2_2({(~(or_cse | (~ mux_111_cse))) , mux_111_cse},
      ~((else_7_else_1_if_acc_tmp[1]) & (else_7_else_1_if_acc_tmp[0]) & else_7_else_1_equal_tmp
      & (~ else_7_equal_tmp)));
  assign mux_129_cse = MUX_s_1_2_2({(~(or_cse | (~ mux_tmp_88))) , mux_tmp_88}, (~
      (else_7_else_1_else_acc_tmp[1])) | (else_7_else_1_else_acc_tmp[0]) | else_7_else_1_equal_tmp
      | else_7_equal_tmp);
  assign mux_136_cse = MUX_s_1_2_2({(~(or_cse | (~ mux_tmp_95))) , mux_tmp_95}, (~
      (else_7_else_1_else_acc_tmp[1])) | (~ (else_7_else_1_else_acc_tmp[0])) | else_7_else_1_equal_tmp
      | else_7_equal_tmp);
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      V_OUT_rsc_mgc_out_stdreg_d <= 10'b0;
      H_OUT_rsc_mgc_out_stdreg_d <= 10'b0;
      else_7_acc_psp_sva <= 9'b0;
      else_7_if_1_ac_fixed_cctor_sg1_1_sva_duc <= 9'b0;
      else_7_if_1_div_4cyc_st_4 <= 2'b0;
      else_7_else_1_if_div_4cyc_st_4 <= 2'b0;
      else_7_else_1_else_div_4cyc_st_4 <= 2'b0;
      else_7_else_1_equal_svs_st_4 <= 1'b0;
      else_7_else_1_equal_svs_4 <= 1'b0;
      else_7_equal_svs_4 <= 1'b0;
      else_7_equal_svs_st_4 <= 1'b0;
      acc_5_itm_4 <= 9'b0;
      unequal_tmp_5 <= 1'b0;
      acc_2_psp_sva_st_4 <= 10'b0;
      mut_41_sg1_1 <= 10'b0;
      else_7_if_1_conc_1_tmp_mut_9_sg1 <= 11'b0;
      mut_44_sg1_1 <= 10'b0;
      else_7_if_1_conc_1_tmp_mut_12_sg1 <= 11'b0;
      mut_47_sg1_1 <= 10'b0;
      else_7_if_1_conc_1_tmp_mut_15_sg1 <= 11'b0;
      mut_14_sg1_1 <= 10'b0;
      else_7_if_1_conc_1_tmp_mut_6_sg1 <= 11'b0;
      else_7_if_1_div_4cyc_st_3 <= 2'b0;
      mut_29_sg1_1 <= 10'b0;
      else_7_else_1_if_conc_tmp_mut_6_sg1 <= 11'b0;
      mut_32_sg1_1 <= 10'b0;
      else_7_else_1_if_conc_tmp_mut_9_sg1 <= 11'b0;
      mut_35_sg1_1 <= 10'b0;
      else_7_else_1_if_conc_tmp_mut_12_sg1 <= 11'b0;
      mut_38_sg1_1 <= 10'b0;
      else_7_else_1_if_conc_tmp_mut_15_sg1 <= 11'b0;
      else_7_else_1_if_div_4cyc_st_3 <= 2'b0;
      mut_17_sg1_1 <= 10'b0;
      else_7_else_1_else_conc_tmp_mut_6_sg1 <= 11'b0;
      mut_20_sg1_1 <= 10'b0;
      else_7_else_1_else_conc_tmp_mut_9_sg1 <= 11'b0;
      mut_23_sg1_1 <= 10'b0;
      else_7_else_1_else_conc_tmp_mut_12_sg1 <= 11'b0;
      mut_26_sg1_1 <= 10'b0;
      else_7_else_1_else_conc_tmp_mut_15_sg1 <= 11'b0;
      else_7_else_1_else_div_4cyc_st_3 <= 2'b0;
      else_7_else_1_equal_svs_st_3 <= 1'b0;
      else_7_equal_svs_st_3 <= 1'b0;
      acc_2_psp_sva_st_3 <= 10'b0;
      mut_40_sg1_1 <= 10'b0;
      else_7_if_1_conc_1_tmp_mut_8_sg1 <= 11'b0;
      mut_43_sg1_1 <= 10'b0;
      else_7_if_1_conc_1_tmp_mut_11_sg1 <= 11'b0;
      mut_46_sg1_1 <= 10'b0;
      else_7_if_1_conc_1_tmp_mut_14_sg1 <= 11'b0;
      mut_13_sg1_1 <= 10'b0;
      else_7_if_1_conc_1_tmp_mut_5_sg1 <= 11'b0;
      else_7_if_1_div_4cyc_st_2 <= 2'b0;
      mut_28_sg1_1 <= 10'b0;
      else_7_else_1_if_conc_tmp_mut_5_sg1 <= 11'b0;
      mut_31_sg1_1 <= 10'b0;
      else_7_else_1_if_conc_tmp_mut_8_sg1 <= 11'b0;
      mut_34_sg1_1 <= 10'b0;
      else_7_else_1_if_conc_tmp_mut_11_sg1 <= 11'b0;
      mut_37_sg1_1 <= 10'b0;
      else_7_else_1_if_conc_tmp_mut_14_sg1 <= 11'b0;
      else_7_else_1_if_div_4cyc_st_2 <= 2'b0;
      mut_16_sg1_1 <= 10'b0;
      else_7_else_1_else_conc_tmp_mut_5_sg1 <= 11'b0;
      mut_19_sg1_1 <= 10'b0;
      else_7_else_1_else_conc_tmp_mut_8_sg1 <= 11'b0;
      mut_22_sg1_1 <= 10'b0;
      else_7_else_1_else_conc_tmp_mut_11_sg1 <= 11'b0;
      mut_25_sg1_1 <= 10'b0;
      else_7_else_1_else_conc_tmp_mut_14_sg1 <= 11'b0;
      else_7_else_1_else_div_4cyc_st_2 <= 2'b0;
      else_7_else_1_equal_svs_st_2 <= 1'b0;
      else_7_equal_svs_st_2 <= 1'b0;
      acc_2_psp_sva_st_2 <= 10'b0;
      mut_39_sg1_1 <= 10'b0;
      else_7_if_1_conc_1_tmp_mut_7_sg1 <= 11'b0;
      mut_42_sg1_1 <= 10'b0;
      else_7_if_1_conc_1_tmp_mut_10_sg1 <= 11'b0;
      mut_45_sg1_1 <= 10'b0;
      else_7_if_1_conc_1_tmp_mut_13_sg1 <= 11'b0;
      mut_12_sg1_1 <= 10'b0;
      else_7_if_1_conc_1_tmp_mut_4_sg1 <= 11'b0;
      else_7_if_1_div_4cyc_st_1 <= 2'b0;
      mut_27_sg1_1 <= 10'b0;
      else_7_else_1_if_conc_tmp_mut_4_sg1 <= 11'b0;
      mut_30_sg1_1 <= 10'b0;
      else_7_else_1_if_conc_tmp_mut_7_sg1 <= 11'b0;
      mut_33_sg1_1 <= 10'b0;
      else_7_else_1_if_conc_tmp_mut_10_sg1 <= 11'b0;
      mut_36_sg1_1 <= 10'b0;
      else_7_else_1_if_conc_tmp_mut_13_sg1 <= 11'b0;
      else_7_else_1_if_div_4cyc_st_1 <= 2'b0;
      mut_15_sg1_1 <= 10'b0;
      else_7_else_1_else_conc_tmp_mut_4_sg1 <= 11'b0;
      mut_18_sg1_1 <= 10'b0;
      else_7_else_1_else_conc_tmp_mut_7_sg1 <= 11'b0;
      mut_21_sg1_1 <= 10'b0;
      else_7_else_1_else_conc_tmp_mut_10_sg1 <= 11'b0;
      mut_24_sg1_1 <= 10'b0;
      else_7_else_1_else_conc_tmp_mut_13_sg1 <= 11'b0;
      else_7_else_1_else_div_4cyc_st_1 <= 2'b0;
      else_7_else_1_equal_svs_st_1 <= 1'b0;
      else_7_equal_svs_st_1 <= 1'b0;
      acc_2_psp_sva_st_1 <= 10'b0;
      else_7_if_1_div_4cyc <= 2'b0;
      else_7_else_1_if_div_4cyc <= 2'b0;
      else_7_else_1_else_div_4cyc <= 2'b0;
      else_7_equal_svs <= 1'b0;
      main_stage_0_2 <= 1'b0;
      main_stage_0_3 <= 1'b0;
      main_stage_0_4 <= 1'b0;
      main_stage_0_5 <= 1'b0;
      acc_5_itm_3 <= 9'b0;
      else_7_equal_svs_3 <= 1'b0;
      unequal_tmp_4 <= 1'b0;
      else_7_else_1_equal_svs_3 <= 1'b0;
      acc_5_itm_2 <= 9'b0;
      else_7_equal_svs_2 <= 1'b0;
      unequal_tmp_3 <= 1'b0;
      else_7_else_1_equal_svs_2 <= 1'b0;
      acc_5_itm_1 <= 9'b0;
      unequal_tmp_2 <= 1'b0;
      else_7_else_1_equal_svs_1 <= 1'b0;
      reg_div_sdt_2_sva_duc_tmp <= 1'b0;
      reg_div_sdt_2_sva_duc_tmp_8 <= 1'b0;
      reg_div_sdt_3_sva_duc_tmp_7 <= 2'b0;
      reg_div_mgc_div_9_b_tmp <= 10'b0;
      reg_div_mgc_div_9_a_tmp <= 11'b0;
      reg_div_mgc_div_10_b_tmp <= 10'b0;
      reg_div_mgc_div_10_a_tmp <= 11'b0;
      reg_div_mgc_div_11_b_tmp <= 10'b0;
      reg_div_mgc_div_11_a_tmp <= 11'b0;
      reg_div_mgc_div_b_tmp <= 10'b0;
      reg_div_mgc_div_a_tmp <= 11'b0;
      reg_div_mgc_div_5_b_tmp <= 10'b0;
      reg_div_mgc_div_5_a_tmp <= 11'b0;
      reg_div_mgc_div_6_b_tmp <= 10'b0;
      reg_div_mgc_div_6_a_tmp <= 11'b0;
      reg_div_mgc_div_7_b_tmp <= 10'b0;
      reg_div_mgc_div_7_a_tmp <= 11'b0;
      reg_div_mgc_div_8_b_tmp <= 10'b0;
      reg_div_mgc_div_8_a_tmp <= 11'b0;
      reg_div_mgc_div_1_b_tmp <= 10'b0;
      reg_div_mgc_div_1_a_tmp <= 11'b0;
      reg_div_mgc_div_2_b_tmp <= 10'b0;
      reg_div_mgc_div_2_a_tmp <= 11'b0;
      reg_div_mgc_div_3_b_tmp <= 10'b0;
      reg_div_mgc_div_3_a_tmp <= 11'b0;
      reg_div_mgc_div_4_b_tmp <= 10'b0;
      reg_div_mgc_div_4_a_tmp <= 11'b0;
    end
    else begin
      V_OUT_rsc_mgc_out_stdreg_d <= MUX_v_10_2_2({V_OUT_rsc_mgc_out_stdreg_d , ({1'b0
          , acc_5_itm_4})}, main_stage_0_5);
      H_OUT_rsc_mgc_out_stdreg_d <= MUX_v_10_2_2({H_OUT_rsc_mgc_out_stdreg_d , ({((MUX_v_7_2_2({(else_7_acc_psp_sva_1[7:1])
          , ((else_7_acc_2_itm[8:2]) + 7'b101101)}, else_7_acc_psp_sva_1[8])) & ({{6{unequal_tmp_5}},
          unequal_tmp_5})) , ((else_7_acc_psp_sva_1[0]) & unequal_tmp_5) , 2'b0})},
          main_stage_0_5);
      else_7_acc_psp_sva <= MUX_v_9_2_2({else_7_acc_psp_sva , (else_7_acc_2_itm[9:1])},
          (~ and_1035_cse) & main_stage_0_5);
      else_7_if_1_ac_fixed_cctor_sg1_1_sva_duc <= MUX1HOT_v_9_5_2({(div_mgc_div_9_z[8:0])
          , (div_mgc_div_10_z[8:0]) , (div_mgc_div_11_z[8:0]) , (div_mgc_div_z[8:0])
          , else_7_if_1_ac_fixed_cctor_sg1_1_sva_duc}, {(or_366_cse & and_dcpl_252
          & (~((else_7_if_1_div_4cyc_st_4[1]) | (else_7_if_1_div_4cyc_st_4[0]))))
          , (or_366_cse & and_dcpl_252 & (~ (else_7_if_1_div_4cyc_st_4[1])) & (else_7_if_1_div_4cyc_st_4[0]))
          , (or_366_cse & and_dcpl_252 & (else_7_if_1_div_4cyc_st_4[1]) & (~ (else_7_if_1_div_4cyc_st_4[0])))
          , (or_366_cse & and_dcpl_252 & (else_7_if_1_div_4cyc_st_4[1]) & (else_7_if_1_div_4cyc_st_4[0]))
          , (and_1035_cse | (~(main_stage_0_5 & else_7_equal_svs_st_4)))});
      else_7_if_1_div_4cyc_st_4 <= else_7_if_1_div_4cyc_st_3;
      else_7_else_1_if_div_4cyc_st_4 <= else_7_else_1_if_div_4cyc_st_3;
      else_7_else_1_else_div_4cyc_st_4 <= else_7_else_1_else_div_4cyc_st_3;
      else_7_else_1_equal_svs_st_4 <= else_7_else_1_equal_svs_st_3;
      else_7_else_1_equal_svs_4 <= else_7_else_1_equal_svs_3;
      else_7_equal_svs_4 <= else_7_equal_svs_3;
      else_7_equal_svs_st_4 <= else_7_equal_svs_st_3;
      acc_5_itm_4 <= acc_5_itm_3;
      unequal_tmp_5 <= unequal_tmp_4;
      acc_2_psp_sva_st_4 <= acc_2_psp_sva_st_3;
      mut_41_sg1_1 <= mut_40_sg1_1;
      else_7_if_1_conc_1_tmp_mut_9_sg1 <= else_7_if_1_conc_1_tmp_mut_8_sg1;
      mut_44_sg1_1 <= mut_43_sg1_1;
      else_7_if_1_conc_1_tmp_mut_12_sg1 <= else_7_if_1_conc_1_tmp_mut_11_sg1;
      mut_47_sg1_1 <= mut_46_sg1_1;
      else_7_if_1_conc_1_tmp_mut_15_sg1 <= else_7_if_1_conc_1_tmp_mut_14_sg1;
      mut_14_sg1_1 <= mut_13_sg1_1;
      else_7_if_1_conc_1_tmp_mut_6_sg1 <= else_7_if_1_conc_1_tmp_mut_5_sg1;
      else_7_if_1_div_4cyc_st_3 <= else_7_if_1_div_4cyc_st_2;
      mut_29_sg1_1 <= mut_28_sg1_1;
      else_7_else_1_if_conc_tmp_mut_6_sg1 <= else_7_else_1_if_conc_tmp_mut_5_sg1;
      mut_32_sg1_1 <= mut_31_sg1_1;
      else_7_else_1_if_conc_tmp_mut_9_sg1 <= else_7_else_1_if_conc_tmp_mut_8_sg1;
      mut_35_sg1_1 <= mut_34_sg1_1;
      else_7_else_1_if_conc_tmp_mut_12_sg1 <= else_7_else_1_if_conc_tmp_mut_11_sg1;
      mut_38_sg1_1 <= mut_37_sg1_1;
      else_7_else_1_if_conc_tmp_mut_15_sg1 <= else_7_else_1_if_conc_tmp_mut_14_sg1;
      else_7_else_1_if_div_4cyc_st_3 <= else_7_else_1_if_div_4cyc_st_2;
      mut_17_sg1_1 <= mut_16_sg1_1;
      else_7_else_1_else_conc_tmp_mut_6_sg1 <= else_7_else_1_else_conc_tmp_mut_5_sg1;
      mut_20_sg1_1 <= mut_19_sg1_1;
      else_7_else_1_else_conc_tmp_mut_9_sg1 <= else_7_else_1_else_conc_tmp_mut_8_sg1;
      mut_23_sg1_1 <= mut_22_sg1_1;
      else_7_else_1_else_conc_tmp_mut_12_sg1 <= else_7_else_1_else_conc_tmp_mut_11_sg1;
      mut_26_sg1_1 <= mut_25_sg1_1;
      else_7_else_1_else_conc_tmp_mut_15_sg1 <= else_7_else_1_else_conc_tmp_mut_14_sg1;
      else_7_else_1_else_div_4cyc_st_3 <= else_7_else_1_else_div_4cyc_st_2;
      else_7_else_1_equal_svs_st_3 <= else_7_else_1_equal_svs_st_2;
      else_7_equal_svs_st_3 <= else_7_equal_svs_st_2;
      acc_2_psp_sva_st_3 <= acc_2_psp_sva_st_2;
      mut_40_sg1_1 <= mut_39_sg1_1;
      else_7_if_1_conc_1_tmp_mut_8_sg1 <= else_7_if_1_conc_1_tmp_mut_7_sg1;
      mut_43_sg1_1 <= mut_42_sg1_1;
      else_7_if_1_conc_1_tmp_mut_11_sg1 <= else_7_if_1_conc_1_tmp_mut_10_sg1;
      mut_46_sg1_1 <= mut_45_sg1_1;
      else_7_if_1_conc_1_tmp_mut_14_sg1 <= else_7_if_1_conc_1_tmp_mut_13_sg1;
      mut_13_sg1_1 <= mut_12_sg1_1;
      else_7_if_1_conc_1_tmp_mut_5_sg1 <= else_7_if_1_conc_1_tmp_mut_4_sg1;
      else_7_if_1_div_4cyc_st_2 <= else_7_if_1_div_4cyc_st_1;
      mut_28_sg1_1 <= mut_27_sg1_1;
      else_7_else_1_if_conc_tmp_mut_5_sg1 <= else_7_else_1_if_conc_tmp_mut_4_sg1;
      mut_31_sg1_1 <= mut_30_sg1_1;
      else_7_else_1_if_conc_tmp_mut_8_sg1 <= else_7_else_1_if_conc_tmp_mut_7_sg1;
      mut_34_sg1_1 <= mut_33_sg1_1;
      else_7_else_1_if_conc_tmp_mut_11_sg1 <= else_7_else_1_if_conc_tmp_mut_10_sg1;
      mut_37_sg1_1 <= mut_36_sg1_1;
      else_7_else_1_if_conc_tmp_mut_14_sg1 <= else_7_else_1_if_conc_tmp_mut_13_sg1;
      else_7_else_1_if_div_4cyc_st_2 <= else_7_else_1_if_div_4cyc_st_1;
      mut_16_sg1_1 <= mut_15_sg1_1;
      else_7_else_1_else_conc_tmp_mut_5_sg1 <= else_7_else_1_else_conc_tmp_mut_4_sg1;
      mut_19_sg1_1 <= mut_18_sg1_1;
      else_7_else_1_else_conc_tmp_mut_8_sg1 <= else_7_else_1_else_conc_tmp_mut_7_sg1;
      mut_22_sg1_1 <= mut_21_sg1_1;
      else_7_else_1_else_conc_tmp_mut_11_sg1 <= else_7_else_1_else_conc_tmp_mut_10_sg1;
      mut_25_sg1_1 <= mut_24_sg1_1;
      else_7_else_1_else_conc_tmp_mut_14_sg1 <= else_7_else_1_else_conc_tmp_mut_13_sg1;
      else_7_else_1_else_div_4cyc_st_2 <= else_7_else_1_else_div_4cyc_st_1;
      else_7_else_1_equal_svs_st_2 <= else_7_else_1_equal_svs_st_1;
      else_7_equal_svs_st_2 <= else_7_equal_svs_st_1;
      acc_2_psp_sva_st_2 <= acc_2_psp_sva_st_1;
      mut_39_sg1_1 <= MUX_v_10_2_2({(acc_itm[10:1]) , mut_39_sg1_1}, and_718_cse);
      else_7_if_1_conc_1_tmp_mut_7_sg1 <= MUX_v_11_2_2({(else_7_if_1_acc_1_itm[11:1])
          , else_7_if_1_conc_1_tmp_mut_7_sg1}, and_718_cse);
      mut_42_sg1_1 <= MUX_v_10_2_2({(acc_itm[10:1]) , mut_42_sg1_1}, and_718_cse);
      else_7_if_1_conc_1_tmp_mut_10_sg1 <= MUX_v_11_2_2({(else_7_if_1_acc_1_itm[11:1])
          , else_7_if_1_conc_1_tmp_mut_10_sg1}, and_718_cse);
      mut_45_sg1_1 <= MUX_v_10_2_2({(acc_itm[10:1]) , mut_45_sg1_1}, and_718_cse);
      else_7_if_1_conc_1_tmp_mut_13_sg1 <= MUX_v_11_2_2({(else_7_if_1_acc_1_itm[11:1])
          , else_7_if_1_conc_1_tmp_mut_13_sg1}, and_718_cse);
      mut_12_sg1_1 <= MUX_v_10_2_2({(acc_itm[10:1]) , mut_12_sg1_1}, and_718_cse);
      else_7_if_1_conc_1_tmp_mut_4_sg1 <= MUX_v_11_2_2({(else_7_if_1_acc_1_itm[11:1])
          , else_7_if_1_conc_1_tmp_mut_4_sg1}, and_718_cse);
      else_7_if_1_div_4cyc_st_1 <= MUX_v_2_2_2({else_7_if_1_acc_tmp , else_7_if_1_div_4cyc_st_1},
          and_718_cse);
      mut_27_sg1_1 <= MUX_v_10_2_2({(acc_itm[10:1]) , mut_27_sg1_1}, and_718_cse);
      else_7_else_1_if_conc_tmp_mut_4_sg1 <= MUX_v_11_2_2({(else_7_else_1_if_acc_2_itm[11:1])
          , else_7_else_1_if_conc_tmp_mut_4_sg1}, and_718_cse);
      mut_30_sg1_1 <= MUX_v_10_2_2({(acc_itm[10:1]) , mut_30_sg1_1}, and_718_cse);
      else_7_else_1_if_conc_tmp_mut_7_sg1 <= MUX_v_11_2_2({(else_7_else_1_if_acc_2_itm[11:1])
          , else_7_else_1_if_conc_tmp_mut_7_sg1}, and_718_cse);
      mut_33_sg1_1 <= MUX_v_10_2_2({(acc_itm[10:1]) , mut_33_sg1_1}, and_718_cse);
      else_7_else_1_if_conc_tmp_mut_10_sg1 <= MUX_v_11_2_2({(else_7_else_1_if_acc_2_itm[11:1])
          , else_7_else_1_if_conc_tmp_mut_10_sg1}, and_718_cse);
      mut_36_sg1_1 <= MUX_v_10_2_2({(acc_itm[10:1]) , mut_36_sg1_1}, and_718_cse);
      else_7_else_1_if_conc_tmp_mut_13_sg1 <= MUX_v_11_2_2({(else_7_else_1_if_acc_2_itm[11:1])
          , else_7_else_1_if_conc_tmp_mut_13_sg1}, and_718_cse);
      else_7_else_1_if_div_4cyc_st_1 <= MUX_v_2_2_2({else_7_else_1_if_acc_tmp , else_7_else_1_if_div_4cyc_st_1},
          and_718_cse);
      mut_15_sg1_1 <= MUX_v_10_2_2({(acc_itm[10:1]) , mut_15_sg1_1}, and_718_cse);
      else_7_else_1_else_conc_tmp_mut_4_sg1 <= MUX_v_11_2_2({(else_7_else_1_else_acc_2_itm[11:1])
          , else_7_else_1_else_conc_tmp_mut_4_sg1}, and_718_cse);
      mut_18_sg1_1 <= MUX_v_10_2_2({(acc_itm[10:1]) , mut_18_sg1_1}, and_718_cse);
      else_7_else_1_else_conc_tmp_mut_7_sg1 <= MUX_v_11_2_2({(else_7_else_1_else_acc_2_itm[11:1])
          , else_7_else_1_else_conc_tmp_mut_7_sg1}, and_718_cse);
      mut_21_sg1_1 <= MUX_v_10_2_2({(acc_itm[10:1]) , mut_21_sg1_1}, and_718_cse);
      else_7_else_1_else_conc_tmp_mut_10_sg1 <= MUX_v_11_2_2({(else_7_else_1_else_acc_2_itm[11:1])
          , else_7_else_1_else_conc_tmp_mut_10_sg1}, and_718_cse);
      mut_24_sg1_1 <= MUX_v_10_2_2({(acc_itm[10:1]) , mut_24_sg1_1}, and_718_cse);
      else_7_else_1_else_conc_tmp_mut_13_sg1 <= MUX_v_11_2_2({(else_7_else_1_else_acc_2_itm[11:1])
          , else_7_else_1_else_conc_tmp_mut_13_sg1}, and_718_cse);
      else_7_else_1_else_div_4cyc_st_1 <= MUX_v_2_2_2({else_7_else_1_else_acc_tmp
          , else_7_else_1_else_div_4cyc_st_1}, and_718_cse);
      else_7_else_1_equal_svs_st_1 <= MUX_s_1_2_2({else_7_else_1_equal_tmp , else_7_else_1_equal_svs_st_1},
          and_718_cse);
      else_7_equal_svs_st_1 <= MUX_s_1_2_2({else_7_equal_tmp , else_7_equal_svs_st_1},
          and_718_cse);
      acc_2_psp_sva_st_1 <= acc_itm[10:1];
      else_7_if_1_div_4cyc <= MUX_v_2_2_2({else_7_if_1_acc_tmp , else_7_if_1_div_4cyc},
          ~((~(and_dcpl_684 & and_dcpl_682 & and_dcpl_680 & and_dcpl_678)) & else_7_equal_tmp));
      else_7_else_1_if_div_4cyc <= MUX_v_2_2_2({else_7_else_1_if_acc_tmp , else_7_else_1_if_div_4cyc},
          and_718_cse | else_7_equal_tmp | (~ else_7_else_1_equal_tmp));
      else_7_else_1_else_div_4cyc <= MUX_v_2_2_2({else_7_else_1_else_acc_tmp , else_7_else_1_else_div_4cyc},
          and_718_cse | else_7_equal_tmp | else_7_else_1_equal_tmp);
      else_7_equal_svs <= MUX_s_1_2_2({else_7_equal_tmp , else_7_equal_svs}, and_718_cse);
      main_stage_0_2 <= 1'b1;
      main_stage_0_3 <= main_stage_0_2;
      main_stage_0_4 <= main_stage_0_3;
      main_stage_0_5 <= main_stage_0_4;
      acc_5_itm_3 <= acc_5_itm_2;
      else_7_equal_svs_3 <= else_7_equal_svs_2;
      unequal_tmp_4 <= unequal_tmp_3;
      else_7_else_1_equal_svs_3 <= else_7_else_1_equal_svs_2;
      acc_5_itm_2 <= acc_5_itm_1;
      else_7_equal_svs_2 <= else_7_equal_svs;
      unequal_tmp_3 <= unequal_tmp_2;
      else_7_else_1_equal_svs_2 <= else_7_else_1_equal_svs_1;
      acc_5_itm_1 <= nl_acc_5_itm_1[8:0];
      unequal_tmp_2 <= or_cse;
      else_7_else_1_equal_svs_1 <= else_7_else_1_equal_tmp;
      reg_div_sdt_2_sva_duc_tmp <= 1'b0;
      reg_div_sdt_2_sva_duc_tmp_8 <= MUX1HOT_s_1_5_2({(div_mgc_div_5_z[0]) , (div_mgc_div_6_z[0])
          , (div_mgc_div_7_z[0]) , (div_mgc_div_8_z[0]) , reg_div_sdt_2_sva_duc_tmp_8},
          {(or_366_cse & and_dcpl_294 & and_dcpl_276) , (or_366_cse & and_dcpl_294
          & and_dcpl_279) , (or_366_cse & and_dcpl_294 & and_dcpl_282) , (or_366_cse
          & and_dcpl_294 & and_dcpl_285) , (and_1035_cse | or_dcpl_355 | (~ else_7_else_1_equal_svs_st_4))});
      reg_div_sdt_3_sva_duc_tmp_7 <= MUX1HOT_v_2_5_2({(div_mgc_div_1_z[1:0]) , (div_mgc_div_2_z[1:0])
          , (div_mgc_div_3_z[1:0]) , (div_mgc_div_4_z[1:0]) , reg_div_sdt_3_sva_duc_tmp_7},
          {(or_366_cse & and_dcpl_339 & and_dcpl_321) , (or_366_cse & and_dcpl_339
          & and_dcpl_324) , (or_366_cse & and_dcpl_339 & and_dcpl_327) , (or_366_cse
          & and_dcpl_339 & and_dcpl_330) , (and_1035_cse | or_dcpl_355 | else_7_else_1_equal_svs_st_4)});
      reg_div_mgc_div_9_b_tmp <= MUX1HOT_v_10_4_2({(acc_itm[10:1]) , mut_39_sg1_1
          , mut_40_sg1_1 , mut_41_sg1_1}, {and_378_cse , and_382_cse , and_386_cse
          , mux_68_cse});
      reg_div_mgc_div_9_a_tmp <= MUX1HOT_v_11_4_2({(else_7_if_1_acc_1_itm[11:1])
          , else_7_if_1_conc_1_tmp_mut_7_sg1 , else_7_if_1_conc_1_tmp_mut_8_sg1 ,
          else_7_if_1_conc_1_tmp_mut_9_sg1}, {and_378_cse , and_382_cse , and_386_cse
          , mux_68_cse});
      reg_div_mgc_div_10_b_tmp <= MUX1HOT_v_10_4_2({(acc_itm[10:1]) , mut_42_sg1_1
          , mut_43_sg1_1 , mut_44_sg1_1}, {and_402_cse , and_406_cse , and_410_cse
          , mux_75_cse});
      reg_div_mgc_div_10_a_tmp <= MUX1HOT_v_11_4_2({(else_7_if_1_acc_1_itm[11:1])
          , else_7_if_1_conc_1_tmp_mut_10_sg1 , else_7_if_1_conc_1_tmp_mut_11_sg1
          , else_7_if_1_conc_1_tmp_mut_12_sg1}, {and_402_cse , and_406_cse , and_410_cse
          , mux_75_cse});
      reg_div_mgc_div_11_b_tmp <= MUX1HOT_v_10_4_2({(acc_itm[10:1]) , mut_45_sg1_1
          , mut_46_sg1_1 , mut_47_sg1_1}, {and_426_cse , and_430_cse , and_434_cse
          , mux_84_cse});
      reg_div_mgc_div_11_a_tmp <= MUX1HOT_v_11_4_2({(else_7_if_1_acc_1_itm[11:1])
          , else_7_if_1_conc_1_tmp_mut_13_sg1 , else_7_if_1_conc_1_tmp_mut_14_sg1
          , else_7_if_1_conc_1_tmp_mut_15_sg1}, {and_426_cse , and_430_cse , and_434_cse
          , mux_84_cse});
      reg_div_mgc_div_b_tmp <= MUX1HOT_v_10_4_2({(acc_itm[10:1]) , mut_12_sg1_1 ,
          mut_13_sg1_1 , mut_14_sg1_1}, {and_448_cse , and_452_cse , and_456_cse
          , (~ mux_89_cse)});
      reg_div_mgc_div_a_tmp <= MUX1HOT_v_11_4_2({(else_7_if_1_acc_1_itm[11:1]) ,
          else_7_if_1_conc_1_tmp_mut_4_sg1 , else_7_if_1_conc_1_tmp_mut_5_sg1 , else_7_if_1_conc_1_tmp_mut_6_sg1},
          {and_448_cse , and_452_cse , and_456_cse , (~ mux_89_cse)});
      reg_div_mgc_div_5_b_tmp <= MUX1HOT_v_10_4_2({(acc_itm[10:1]) , mut_27_sg1_1
          , mut_28_sg1_1 , mut_29_sg1_1}, {and_471_cse , and_477_cse , and_483_cse
          , mux_94_cse});
      reg_div_mgc_div_5_a_tmp <= MUX1HOT_v_11_4_2({(else_7_else_1_if_acc_2_itm[11:1])
          , else_7_else_1_if_conc_tmp_mut_4_sg1 , else_7_else_1_if_conc_tmp_mut_5_sg1
          , else_7_else_1_if_conc_tmp_mut_6_sg1}, {and_471_cse , and_477_cse , and_483_cse
          , mux_94_cse});
      reg_div_mgc_div_6_b_tmp <= MUX1HOT_v_10_4_2({(acc_itm[10:1]) , mut_30_sg1_1
          , mut_31_sg1_1 , mut_32_sg1_1}, {and_503_cse , and_508_cse , and_514_cse
          , mux_99_cse});
      reg_div_mgc_div_6_a_tmp <= MUX1HOT_v_11_4_2({(else_7_else_1_if_acc_2_itm[11:1])
          , else_7_else_1_if_conc_tmp_mut_7_sg1 , else_7_else_1_if_conc_tmp_mut_8_sg1
          , else_7_else_1_if_conc_tmp_mut_9_sg1}, {and_503_cse , and_508_cse , and_514_cse
          , mux_99_cse});
      reg_div_mgc_div_7_b_tmp <= MUX1HOT_v_10_4_2({(acc_itm[10:1]) , mut_33_sg1_1
          , mut_34_sg1_1 , mut_35_sg1_1}, {and_534_cse , and_539_cse , and_545_cse
          , mux_105_cse});
      reg_div_mgc_div_7_a_tmp <= MUX1HOT_v_11_4_2({(else_7_else_1_if_acc_2_itm[11:1])
          , else_7_else_1_if_conc_tmp_mut_10_sg1 , else_7_else_1_if_conc_tmp_mut_11_sg1
          , else_7_else_1_if_conc_tmp_mut_12_sg1}, {and_534_cse , and_539_cse , and_545_cse
          , mux_105_cse});
      reg_div_mgc_div_8_b_tmp <= MUX1HOT_v_10_4_2({(acc_itm[10:1]) , mut_36_sg1_1
          , mut_37_sg1_1 , mut_38_sg1_1}, {and_563_cse , and_568_cse , and_574_cse
          , mux_112_cse});
      reg_div_mgc_div_8_a_tmp <= MUX1HOT_v_11_4_2({(else_7_else_1_if_acc_2_itm[11:1])
          , else_7_else_1_if_conc_tmp_mut_13_sg1 , else_7_else_1_if_conc_tmp_mut_14_sg1
          , else_7_else_1_if_conc_tmp_mut_15_sg1}, {and_563_cse , and_568_cse , and_574_cse
          , mux_112_cse});
      reg_div_mgc_div_1_b_tmp <= MUX1HOT_v_10_4_2({(acc_itm[10:1]) , mut_15_sg1_1
          , mut_16_sg1_1 , mut_17_sg1_1}, {and_592_cse , and_598_cse , and_604_cse
          , mux_118_cse});
      reg_div_mgc_div_1_a_tmp <= MUX1HOT_v_11_4_2({(else_7_else_1_else_acc_2_itm[11:1])
          , else_7_else_1_else_conc_tmp_mut_4_sg1 , else_7_else_1_else_conc_tmp_mut_5_sg1
          , else_7_else_1_else_conc_tmp_mut_6_sg1}, {and_592_cse , and_598_cse ,
          and_604_cse , mux_118_cse});
      reg_div_mgc_div_2_b_tmp <= MUX1HOT_v_10_4_2({(acc_itm[10:1]) , mut_18_sg1_1
          , mut_19_sg1_1 , mut_20_sg1_1}, {and_624_cse , and_629_cse , and_635_cse
          , mux_123_cse});
      reg_div_mgc_div_2_a_tmp <= MUX1HOT_v_11_4_2({(else_7_else_1_else_acc_2_itm[11:1])
          , else_7_else_1_else_conc_tmp_mut_7_sg1 , else_7_else_1_else_conc_tmp_mut_8_sg1
          , else_7_else_1_else_conc_tmp_mut_9_sg1}, {and_624_cse , and_629_cse ,
          and_635_cse , mux_123_cse});
      reg_div_mgc_div_3_b_tmp <= MUX1HOT_v_10_4_2({(acc_itm[10:1]) , mut_21_sg1_1
          , mut_22_sg1_1 , mut_23_sg1_1}, {and_655_cse , and_660_cse , and_666_cse
          , mux_129_cse});
      reg_div_mgc_div_3_a_tmp <= MUX1HOT_v_11_4_2({(else_7_else_1_else_acc_2_itm[11:1])
          , else_7_else_1_else_conc_tmp_mut_10_sg1 , else_7_else_1_else_conc_tmp_mut_11_sg1
          , else_7_else_1_else_conc_tmp_mut_12_sg1}, {and_655_cse , and_660_cse ,
          and_666_cse , mux_129_cse});
      reg_div_mgc_div_4_b_tmp <= MUX1HOT_v_10_4_2({(acc_itm[10:1]) , mut_24_sg1_1
          , mut_25_sg1_1 , mut_26_sg1_1}, {and_684_cse , and_689_cse , and_695_cse
          , mux_136_cse});
      reg_div_mgc_div_4_a_tmp <= MUX1HOT_v_11_4_2({(else_7_else_1_else_acc_2_itm[11:1])
          , else_7_else_1_else_conc_tmp_mut_13_sg1 , else_7_else_1_else_conc_tmp_mut_14_sg1
          , else_7_else_1_else_conc_tmp_mut_15_sg1}, {and_684_cse , and_689_cse ,
          and_695_cse , mux_136_cse});
    end
  end
  assign nl_acc_5_itm_1  = conv_u2u_8_9(mul_itm[13:6]) + conv_u2u_1_9(mul_itm[5]);

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


  function [8:0] MUX_v_9_2_2;
    input [17:0] inputs;
    input [0:0] sel;
    reg [8:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[17:9];
      end
      1'b1 : begin
        result = inputs[8:0];
      end
      default : begin
        result = inputs[17:9];
      end
    endcase
    MUX_v_9_2_2 = result;
  end
  endfunction


  function [8:0] MUX1HOT_v_9_5_2;
    input [44:0] inputs;
    input [4:0] sel;
    reg [8:0] result;
    integer i;
  begin
    result = inputs[0+:9] & {9{sel[0]}};
    for( i = 1; i < 5; i = i + 1 )
      result = result | (inputs[i*9+:9] & {9{sel[i]}});
    MUX1HOT_v_9_5_2 = result;
  end
  endfunction


  function [7:0] MUX1HOT_v_8_4_2;
    input [31:0] inputs;
    input [3:0] sel;
    reg [7:0] result;
    integer i;
  begin
    result = inputs[0+:8] & {8{sel[0]}};
    for( i = 1; i < 4; i = i + 1 )
      result = result | (inputs[i*8+:8] & {8{sel[i]}});
    MUX1HOT_v_8_4_2 = result;
  end
  endfunction


  function [6:0] MUX1HOT_v_7_4_2;
    input [27:0] inputs;
    input [3:0] sel;
    reg [6:0] result;
    integer i;
  begin
    result = inputs[0+:7] & {7{sel[0]}};
    for( i = 1; i < 4; i = i + 1 )
      result = result | (inputs[i*7+:7] & {7{sel[i]}});
    MUX1HOT_v_7_4_2 = result;
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


  function [0:0] MUX1HOT_s_1_5_2;
    input [4:0] inputs;
    input [4:0] sel;
    reg [0:0] result;
    integer i;
  begin
    result = inputs[0+:1] & {1{sel[0]}};
    for( i = 1; i < 5; i = i + 1 )
      result = result | (inputs[i*1+:1] & {1{sel[i]}});
    MUX1HOT_s_1_5_2 = result;
  end
  endfunction


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


  function [10:0] MUX_v_11_2_2;
    input [21:0] inputs;
    input [0:0] sel;
    reg [10:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[21:11];
      end
      1'b1 : begin
        result = inputs[10:0];
      end
      default : begin
        result = inputs[21:11];
      end
    endcase
    MUX_v_11_2_2 = result;
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


  function [1:0] MUX1HOT_v_2_5_2;
    input [9:0] inputs;
    input [4:0] sel;
    reg [1:0] result;
    integer i;
  begin
    result = inputs[0+:2] & {2{sel[0]}};
    for( i = 1; i < 5; i = i + 1 )
      result = result | (inputs[i*2+:2] & {2{sel[i]}});
    MUX1HOT_v_2_5_2 = result;
  end
  endfunction


  function [9:0] MUX1HOT_v_10_4_2;
    input [39:0] inputs;
    input [3:0] sel;
    reg [9:0] result;
    integer i;
  begin
    result = inputs[0+:10] & {10{sel[0]}};
    for( i = 1; i < 4; i = i + 1 )
      result = result | (inputs[i*10+:10] & {10{sel[i]}});
    MUX1HOT_v_10_4_2 = result;
  end
  endfunction


  function [10:0] MUX1HOT_v_11_4_2;
    input [43:0] inputs;
    input [3:0] sel;
    reg [10:0] result;
    integer i;
  begin
    result = inputs[0+:11] & {11{sel[0]}};
    for( i = 1; i < 4; i = i + 1 )
      result = result | (inputs[i*11+:11] & {11{sel[i]}});
    MUX1HOT_v_11_4_2 = result;
  end
  endfunction


  function  [11:0] conv_u2u_11_12 ;
    input [10:0]  vector ;
  begin
    conv_u2u_11_12 = {1'b0, vector};
  end
  endfunction


  function signed [11:0] conv_u2s_11_12 ;
    input [10:0]  vector ;
  begin
    conv_u2s_11_12 = {1'b0, vector};
  end
  endfunction


  function  [13:0] conv_u2u_10_14 ;
    input [9:0]  vector ;
  begin
    conv_u2u_10_14 = {{4{1'b0}}, vector};
  end
  endfunction


  function  [8:0] conv_u2u_8_9 ;
    input [7:0]  vector ;
  begin
    conv_u2u_8_9 = {1'b0, vector};
  end
  endfunction


  function  [8:0] conv_u2u_1_9 ;
    input [0:0]  vector ;
  begin
    conv_u2u_1_9 = {{8{1'b0}}, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    HSVRGB
//  Generated from file(s):
//    9) $PROJECT_HOME/RGBHSV.cpp
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
  wire [9:0] V_OUT_rsc_mgc_out_stdreg_d;
  wire [20:0] div_mgc_div_a;
  wire [20:0] div_mgc_div_b;
  wire [20:0] div_mgc_div_z;
  wire [20:0] div_mgc_div_1_a;
  wire [20:0] div_mgc_div_1_b;
  wire [20:0] div_mgc_div_1_z;
  wire [20:0] div_mgc_div_2_a;
  wire [20:0] div_mgc_div_2_b;
  wire [20:0] div_mgc_div_2_z;
  wire [20:0] div_mgc_div_3_a;
  wire [20:0] div_mgc_div_3_b;
  wire [20:0] div_mgc_div_3_z;
  wire [20:0] div_mgc_div_4_a;
  wire [20:0] div_mgc_div_4_b;
  wire [20:0] div_mgc_div_4_z;
  wire [20:0] div_mgc_div_5_a;
  wire [20:0] div_mgc_div_5_b;
  wire [20:0] div_mgc_div_5_z;
  wire [20:0] div_mgc_div_6_a;
  wire [20:0] div_mgc_div_6_b;
  wire [20:0] div_mgc_div_6_z;
  wire [20:0] div_mgc_div_7_a;
  wire [20:0] div_mgc_div_7_b;
  wire [20:0] div_mgc_div_7_z;
  wire [20:0] div_mgc_div_8_a;
  wire [20:0] div_mgc_div_8_b;
  wire [20:0] div_mgc_div_8_z;
  wire [20:0] div_mgc_div_9_a;
  wire [20:0] div_mgc_div_9_b;
  wire [20:0] div_mgc_div_9_z;
  wire [20:0] div_mgc_div_10_a;
  wire [20:0] div_mgc_div_10_b;
  wire [20:0] div_mgc_div_10_z;
  wire [20:0] div_mgc_div_11_a;
  wire [20:0] div_mgc_div_11_b;
  wire [20:0] div_mgc_div_11_z;


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
      .d(10'b0),
      .z(S_OUT_rsc_z)
    );
  mgc_out_stdreg #(.rscid(6),
  .width(10)) V_OUT_rsc_mgc_out_stdreg (
      .d(V_OUT_rsc_mgc_out_stdreg_d),
      .z(V_OUT_rsc_z)
    );
  mgc_div #(.width_a(21),
  .width_b(21),
  .signd(1)) div_mgc_div (
      .a(div_mgc_div_a),
      .b(div_mgc_div_b),
      .z(div_mgc_div_z)
    );
  mgc_div #(.width_a(21),
  .width_b(21),
  .signd(1)) div_mgc_div_1 (
      .a(div_mgc_div_1_a),
      .b(div_mgc_div_1_b),
      .z(div_mgc_div_1_z)
    );
  mgc_div #(.width_a(21),
  .width_b(21),
  .signd(1)) div_mgc_div_2 (
      .a(div_mgc_div_2_a),
      .b(div_mgc_div_2_b),
      .z(div_mgc_div_2_z)
    );
  mgc_div #(.width_a(21),
  .width_b(21),
  .signd(1)) div_mgc_div_3 (
      .a(div_mgc_div_3_a),
      .b(div_mgc_div_3_b),
      .z(div_mgc_div_3_z)
    );
  mgc_div #(.width_a(21),
  .width_b(21),
  .signd(1)) div_mgc_div_4 (
      .a(div_mgc_div_4_a),
      .b(div_mgc_div_4_b),
      .z(div_mgc_div_4_z)
    );
  mgc_div #(.width_a(21),
  .width_b(21),
  .signd(1)) div_mgc_div_5 (
      .a(div_mgc_div_5_a),
      .b(div_mgc_div_5_b),
      .z(div_mgc_div_5_z)
    );
  mgc_div #(.width_a(21),
  .width_b(21),
  .signd(1)) div_mgc_div_6 (
      .a(div_mgc_div_6_a),
      .b(div_mgc_div_6_b),
      .z(div_mgc_div_6_z)
    );
  mgc_div #(.width_a(21),
  .width_b(21),
  .signd(1)) div_mgc_div_7 (
      .a(div_mgc_div_7_a),
      .b(div_mgc_div_7_b),
      .z(div_mgc_div_7_z)
    );
  mgc_div #(.width_a(21),
  .width_b(21),
  .signd(1)) div_mgc_div_8 (
      .a(div_mgc_div_8_a),
      .b(div_mgc_div_8_b),
      .z(div_mgc_div_8_z)
    );
  mgc_div #(.width_a(21),
  .width_b(21),
  .signd(1)) div_mgc_div_9 (
      .a(div_mgc_div_9_a),
      .b(div_mgc_div_9_b),
      .z(div_mgc_div_9_z)
    );
  mgc_div #(.width_a(21),
  .width_b(21),
  .signd(1)) div_mgc_div_10 (
      .a(div_mgc_div_10_a),
      .b(div_mgc_div_10_b),
      .z(div_mgc_div_10_z)
    );
  mgc_div #(.width_a(21),
  .width_b(21),
  .signd(1)) div_mgc_div_11 (
      .a(div_mgc_div_11_a),
      .b(div_mgc_div_11_b),
      .z(div_mgc_div_11_z)
    );
  HSVRGB_core HSVRGB_core_inst (
      .clk(clk),
      .arst_n(arst_n),
      .r_rsc_mgc_in_wire_d(r_rsc_mgc_in_wire_d),
      .g_rsc_mgc_in_wire_d(g_rsc_mgc_in_wire_d),
      .b_rsc_mgc_in_wire_d(b_rsc_mgc_in_wire_d),
      .H_OUT_rsc_mgc_out_stdreg_d(H_OUT_rsc_mgc_out_stdreg_d),
      .V_OUT_rsc_mgc_out_stdreg_d(V_OUT_rsc_mgc_out_stdreg_d),
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
      .div_mgc_div_10_z(div_mgc_div_10_z),
      .div_mgc_div_11_a(div_mgc_div_11_a),
      .div_mgc_div_11_b(div_mgc_div_11_b),
      .div_mgc_div_11_z(div_mgc_div_11_z)
    );
endmodule



