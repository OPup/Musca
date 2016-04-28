
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
//  Generated date: Thu Apr 28 15:37:09 2016
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    HSVRGB_core
// ------------------------------------------------------------------


module HSVRGB_core (
  clk, arst_n, r_rsc_mgc_in_wire_d, g_rsc_mgc_in_wire_d, b_rsc_mgc_in_wire_d, H_OUT_rsc_mgc_out_stdreg_d,
      S_OUT_rsc_mgc_out_stdreg_d, V_OUT_rsc_mgc_out_stdreg_d, div_mgc_div_a, div_mgc_div_b,
      div_mgc_div_z, div_mgc_div_1_a, div_mgc_div_1_b, div_mgc_div_1_z, div_mgc_div_2_a,
      div_mgc_div_2_b, div_mgc_div_2_z, div_mgc_div_3_a, div_mgc_div_3_b, div_mgc_div_3_z,
      div_mgc_div_4_a, div_mgc_div_4_b, div_mgc_div_4_z, div_mgc_div_5_a, div_mgc_div_5_b,
      div_mgc_div_5_z, div_mgc_div_6_a, div_mgc_div_6_b, div_mgc_div_6_z, div_mgc_div_7_a,
      div_mgc_div_7_b, div_mgc_div_7_z, div_mgc_div_8_a, div_mgc_div_8_b, div_mgc_div_8_z,
      div_mgc_div_9_a, div_mgc_div_9_b, div_mgc_div_9_z, div_mgc_div_10_a, div_mgc_div_10_b,
      div_mgc_div_10_z, div_mgc_div_11_a, div_mgc_div_11_b, div_mgc_div_11_z, div_mgc_div_12_a,
      div_mgc_div_12_b, div_mgc_div_12_z_oreg, div_mgc_div_13_a, div_mgc_div_13_b,
      div_mgc_div_13_z_oreg
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
  output [19:0] div_mgc_div_12_a;
  output [9:0] div_mgc_div_12_b;
  input [19:0] div_mgc_div_12_z_oreg;
  output [19:0] div_mgc_div_13_a;
  output [9:0] div_mgc_div_13_b;
  input [19:0] div_mgc_div_13_z_oreg;


  // Interconnect Declarations
  wire [1:0] else_7_if_1_acc_tmp;
  wire [2:0] nl_else_7_if_1_acc_tmp;
  wire [1:0] else_7_else_1_if_acc_tmp;
  wire [2:0] nl_else_7_else_1_if_acc_tmp;
  wire [1:0] else_7_else_1_else_acc_tmp;
  wire [2:0] nl_else_7_else_1_else_acc_tmp;
  wire else_7_else_1_equal_tmp;
  wire else_7_equal_tmp;
  wire [9:0] mux1h_32_tmp;
  wire or_tmp_1;
  wire and_dcpl_25;
  wire and_dcpl_58;
  wire and_dcpl_144;
  wire and_dcpl_169;
  wire or_tmp_3;
  wire or_tmp_59;
  wire and_dcpl_247;
  wire and_dcpl_251;
  wire and_dcpl_256;
  wire and_dcpl_280;
  wire and_dcpl_281;
  wire and_dcpl_283;
  wire and_dcpl_286;
  wire and_dcpl_289;
  wire and_dcpl_297;
  wire and_dcpl_298;
  wire or_dcpl_382;
  wire and_dcpl_325;
  wire and_dcpl_326;
  wire and_dcpl_328;
  wire and_dcpl_331;
  wire and_dcpl_334;
  wire and_dcpl_343;
  wire and_dcpl_370;
  wire or_tmp_90;
  wire or_tmp_92;
  wire and_tmp_1;
  wire and_tmp_2;
  wire and_dcpl_392;
  wire nor_tmp_10;
  wire and_tmp_5;
  wire and_tmp_6;
  wire or_tmp_141;
  wire mux_tmp_48;
  wire or_tmp_154;
  wire mux_tmp_51;
  wire or_tmp_177;
  wire or_tmp_182;
  wire and_dcpl_459;
  wire or_tmp_194;
  wire and_tmp_9;
  wire and_tmp_10;
  wire or_tmp_221;
  wire and_tmp_13;
  wire and_tmp_14;
  wire or_tmp_248;
  wire mux_tmp_76;
  wire or_tmp_261;
  wire mux_tmp_78;
  wire or_tmp_281;
  wire nor_tmp_26;
  wire mux_tmp_85;
  wire or_tmp_294;
  wire and_dcpl_571;
  wire and_tmp_17;
  wire and_tmp_18;
  wire or_tmp_341;
  wire and_tmp_21;
  wire and_tmp_22;
  wire or_tmp_368;
  wire mux_tmp_104;
  wire or_tmp_381;
  wire mux_tmp_106;
  wire or_tmp_401;
  wire nor_tmp_32;
  wire mux_tmp_113;
  wire or_tmp_414;
  wire mux_tmp_115;
  wire not_tmp_263;
  wire or_dcpl_641;
  wire or_dcpl_643;
  wire and_dcpl_682;
  wire and_dcpl_684;
  wire and_dcpl_686;
  wire and_dcpl_688;
  wire or_dcpl_650;
  wire or_dcpl_652;
  wire or_dcpl_654;
  wire or_dcpl_656;
  wire and_tmp_26;
  reg unequal_tmp_1;
  reg else_7_equal_svs;
  reg [8:0] else_7_acc_psp_sva;
  reg else_7_if_div_2cyc;
  reg [17:0] s_sg1_1_sva_2_duc;
  reg [1:0] else_7_if_1_div_4cyc;
  reg [8:0] h_sg1_4_sva_duc;
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
  reg unequal_tmp_7;
  reg unequal_tmp_8;
  reg else_7_equal_svs_2;
  reg else_7_equal_svs_3;
  reg else_7_equal_svs_4;
  reg else_7_and_5_itm_1;
  reg else_7_and_5_itm_2;
  reg else_7_and_5_itm_3;
  reg else_7_and_5_itm_4;
  reg [9:0] acc_4_itm_1;
  wire [10:0] nl_acc_4_itm_1;
  reg [8:0] acc_5_itm_1;
  wire [9:0] nl_acc_5_itm_1;
  reg [8:0] acc_5_itm_2;
  reg [8:0] acc_5_itm_3;
  reg [8:0] acc_5_itm_4;
  reg [9:0] acc_2_psp_sva_st_1;
  reg else_7_if_div_2cyc_st_1;
  reg [9:0] acc_2_psp_sva_st_2;
  reg [9:0] acc_2_psp_sva_st_3;
  reg [9:0] max_sg1_lpi_dfm_3_st_2;
  reg [9:0] max_sg1_lpi_dfm_3_st_3;
  reg else_7_if_div_2cyc_st_2;
  reg else_7_if_div_2cyc_st_3;
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
  reg [9:0] else_7_if_conc_1_tmp_mut_sg1;
  reg [9:0] else_7_if_conc_1_tmp_mut_1_sg1;
  reg [9:0] else_7_if_1_conc_2_tmp_mut_4_sg1;
  reg [9:0] else_7_if_1_conc_2_tmp_mut_5_sg1;
  reg [9:0] else_7_if_1_conc_2_tmp_mut_6_sg1;
  reg [9:0] else_7_else_1_else_conc_2_tmp_mut_4_sg1;
  reg [9:0] else_7_else_1_else_conc_2_tmp_mut_5_sg1;
  reg [9:0] else_7_else_1_else_conc_2_tmp_mut_6_sg1;
  reg [9:0] else_7_else_1_else_conc_2_tmp_mut_7_sg1;
  reg [9:0] else_7_else_1_else_conc_2_tmp_mut_8_sg1;
  reg [9:0] else_7_else_1_else_conc_2_tmp_mut_9_sg1;
  reg [9:0] else_7_else_1_else_conc_2_tmp_mut_10_sg1;
  reg [9:0] else_7_else_1_else_conc_2_tmp_mut_11_sg1;
  reg [9:0] else_7_else_1_else_conc_2_tmp_mut_12_sg1;
  reg [9:0] else_7_else_1_else_conc_2_tmp_mut_13_sg1;
  reg [9:0] else_7_else_1_else_conc_2_tmp_mut_14_sg1;
  reg [9:0] else_7_else_1_else_conc_2_tmp_mut_15_sg1;
  reg [9:0] else_7_else_1_if_conc_2_tmp_mut_4_sg1;
  reg [9:0] else_7_else_1_if_conc_2_tmp_mut_5_sg1;
  reg [9:0] else_7_else_1_if_conc_2_tmp_mut_6_sg1;
  reg [9:0] else_7_else_1_if_conc_2_tmp_mut_7_sg1;
  reg [9:0] else_7_else_1_if_conc_2_tmp_mut_8_sg1;
  reg [9:0] else_7_else_1_if_conc_2_tmp_mut_9_sg1;
  reg [9:0] else_7_else_1_if_conc_2_tmp_mut_10_sg1;
  reg [9:0] else_7_else_1_if_conc_2_tmp_mut_11_sg1;
  reg [9:0] else_7_else_1_if_conc_2_tmp_mut_12_sg1;
  reg [9:0] else_7_else_1_if_conc_2_tmp_mut_13_sg1;
  reg [9:0] else_7_else_1_if_conc_2_tmp_mut_14_sg1;
  reg [9:0] else_7_else_1_if_conc_2_tmp_mut_15_sg1;
  reg [9:0] else_7_if_1_conc_2_tmp_mut_7_sg1;
  reg [9:0] else_7_if_1_conc_2_tmp_mut_8_sg1;
  reg [9:0] else_7_if_1_conc_2_tmp_mut_9_sg1;
  reg [9:0] else_7_if_1_conc_2_tmp_mut_10_sg1;
  reg [9:0] else_7_if_1_conc_2_tmp_mut_11_sg1;
  reg [9:0] else_7_if_1_conc_2_tmp_mut_12_sg1;
  reg [9:0] else_7_if_1_conc_2_tmp_mut_13_sg1;
  reg [9:0] else_7_if_1_conc_2_tmp_mut_14_sg1;
  reg [9:0] else_7_if_1_conc_2_tmp_mut_15_sg1;
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
  wire [5:0] h_sg1_4_lpi_dfm_1_sg2_1;
  wire h_sg1_4_lpi_dfm_1_sg1_1;
  wire [1:0] h_sg1_4_lpi_dfm_4;
  wire or_407_cse;
  wire and_1083_cse;
  wire and_384_cse;
  wire and_388_cse;
  wire or_525_cse;
  wire and_414_cse;
  wire and_440_cse;
  wire and_462_cse;
  wire and_486_cse;
  wire and_518_cse;
  wire and_550_cse;
  wire and_578_cse;
  wire and_606_cse;
  wire and_638_cse;
  wire and_670_cse;
  wire and_698_cse;
  wire and_727_cse;
  reg [9:0] reg_div_mgc_div_13_b_cse;
  reg [9:0] reg_div_mgc_div_12_b_cse;
  wire or_532_cse;
  wire nand_10_cse;
  wire nand_16_cse;
  wire and_1061_cse;
  wire or_706_cse;
  wire or_751_cse;
  wire or_796_cse;
  wire or_847_cse;
  wire or_898_cse;
  wire or_943_cse;
  wire or_988_cse;
  wire or_1039_cse;
  reg reg_h_sg1_6_sva_duc_tmp;
  reg [1:0] reg_h_sg1_6_sva_duc_tmp_7;
  reg [2:0] reg_h_sg1_5_sva_duc_tmp_6;
  reg [9:0] reg_div_mgc_div_9_b_tmp;
  reg [9:0] reg_div_mgc_div_9_a_tmp;
  reg [9:0] reg_div_mgc_div_10_b_tmp;
  reg [9:0] reg_div_mgc_div_10_a_tmp;
  reg [9:0] reg_div_mgc_div_11_b_tmp;
  reg [9:0] reg_div_mgc_div_11_a_tmp;
  reg [9:0] reg_div_mgc_div_b_tmp;
  reg [9:0] reg_div_mgc_div_a_tmp;
  reg [9:0] reg_div_mgc_div_5_b_tmp;
  reg [9:0] reg_div_mgc_div_5_a_tmp;
  reg [9:0] reg_div_mgc_div_6_b_tmp;
  reg [9:0] reg_div_mgc_div_6_a_tmp;
  reg [9:0] reg_div_mgc_div_7_b_tmp;
  reg [9:0] reg_div_mgc_div_7_a_tmp;
  reg [9:0] reg_div_mgc_div_8_b_tmp;
  reg [9:0] reg_div_mgc_div_8_a_tmp;
  reg [9:0] reg_div_mgc_div_1_b_tmp;
  reg [9:0] reg_div_mgc_div_1_a_tmp;
  reg [9:0] reg_div_mgc_div_2_b_tmp;
  reg [9:0] reg_div_mgc_div_2_a_tmp;
  reg [9:0] reg_div_mgc_div_3_b_tmp;
  reg [9:0] reg_div_mgc_div_3_a_tmp;
  reg [9:0] reg_div_mgc_div_4_b_tmp;
  reg [9:0] reg_div_mgc_div_4_a_tmp;
  wire and_410_cse;
  wire and_436_cse;
  wire and_458_cse;
  wire and_466_cse;
  wire mux_111_cse;
  wire and_481_cse;
  wire and_513_cse;
  wire and_545_cse;
  wire and_573_cse;
  wire and_601_cse;
  wire and_633_cse;
  wire and_665_cse;
  wire and_693_cse;
  reg [9:0] reg_max_sg1_lpi_dfm_3_st_1_cse;
  wire and_213_cse;
  wire and_110_cse;
  wire and_247_cse;
  wire and_152_cse;
  wire mux_136_cse;
  wire and_393_cse;
  wire mux_81_cse;
  wire and_419_cse;
  wire mux_91_cse;
  wire and_444_cse;
  wire mux_102_cse;
  wire and_492_cse;
  wire mux_116_cse;
  wire and_524_cse;
  wire mux_121_cse;
  wire and_555_cse;
  wire mux_128_cse;
  wire and_583_cse;
  wire and_612_cse;
  wire mux_144_cse;
  wire and_644_cse;
  wire mux_149_cse;
  wire and_675_cse;
  wire mux_156_cse;
  wire and_703_cse;
  wire mux_165_cse;
  wire mux_137_cse;
  wire [9:0] else_7_acc_2_itm;
  wire [10:0] nl_else_7_acc_2_itm;
  wire [10:0] acc_itm;
  wire [11:0] nl_acc_itm;
  wire [8:0] else_7_acc_psp_sva_1;
  wire [8:0] h_sg1_4_sva_duc_mx0;
  wire [6:0] h_sg1_4_sva_1_sg1;
  wire [7:0] nl_h_sg1_4_sva_1_sg1;
  wire [8:0] h_sg1_5_sva_duc_mx0;
  wire else_7_nor_ssc;
  wire [9:0] g_1_lpi_dfm;
  wire [9:0] b_1_lpi_dfm;
  wire [9:0] r_1_lpi_dfm;
  wire unequal_tmp_9;
  wire or_cse;
  wire [11:0] if_if_acc_itm;
  wire [12:0] nl_if_if_acc_itm;
  wire [11:0] else_1_if_acc_itm;
  wire [12:0] nl_else_1_if_acc_itm;
  wire [11:0] if_3_if_acc_itm;
  wire [12:0] nl_if_3_if_acc_itm;
  wire [11:0] else_5_if_acc_itm;
  wire [12:0] nl_else_5_if_acc_itm;
  wire [10:0] else_7_if_1_acc_1_itm;
  wire [11:0] nl_else_7_if_1_acc_1_itm;
  wire [10:0] else_7_else_1_if_acc_2_itm;
  wire [11:0] nl_else_7_else_1_if_acc_2_itm;
  wire [10:0] else_7_else_1_else_acc_2_itm;
  wire [11:0] nl_else_7_else_1_else_acc_2_itm;
  wire [11:0] if_3_acc_1_itm;
  wire [12:0] nl_if_3_acc_1_itm;
  wire [11:0] if_acc_1_itm;
  wire [12:0] nl_if_acc_1_itm;
  wire [17:0] mul_1_itm;
  wire [35:0] nl_mul_1_itm;
  wire [13:0] mul_itm;
  wire [27:0] nl_mul_itm;

  wire[0:0] mux_77_nl;
  wire[0:0] mux_171_nl;
  wire[0:0] mux_87_nl;
  wire[0:0] mux_86_nl;
  wire[0:0] mux_96_nl;
  wire[0:0] mux_76_nl;
  wire[0:0] mux_109_nl;
  wire[0:0] mux_110_nl;
  wire[0:0] mux_114_nl;
  wire[0:0] mux_119_nl;
  wire[0:0] mux_124_nl;
  wire[0:0] mux_133_nl;
  wire[0:0] mux_142_nl;
  wire[0:0] mux_147_nl;
  wire[0:0] mux_152_nl;
  wire[0:0] mux_161_nl;
  wire[6:0] mux1h_3_nl;
  wire[5:0] mux1h_6_nl;
  wire[9:0] mux1h_33_nl;
  wire[17:0] mux1h_34_nl;
  wire[0:0] mux_79_nl;
  wire[0:0] mux_78_nl;
  wire[0:0] mux_80_nl;
  wire[0:0] mux_89_nl;
  wire[0:0] mux_88_nl;
  wire[0:0] mux_90_nl;
  wire[0:0] mux_99_nl;
  wire[0:0] mux_98_nl;
  wire[0:0] mux_101_nl;
  wire[0:0] mux_115_nl;
  wire[0:0] mux_120_nl;
  wire[0:0] mux_126_nl;
  wire[0:0] mux_135_nl;
  wire[0:0] mux_143_nl;
  wire[0:0] mux_148_nl;
  wire[0:0] mux_154_nl;
  wire[0:0] mux_163_nl;

  // Interconnect Declarations for Component Instantiations 
  assign and_1083_cse = (~((acc_2_psp_sva_st_4[9]) | (acc_2_psp_sva_st_4[8]) | (acc_2_psp_sva_st_4[7])))
      & (~((acc_2_psp_sva_st_4[6]) | (acc_2_psp_sva_st_4[5]))) & (~((acc_2_psp_sva_st_4[4])
      | (acc_2_psp_sva_st_4[3]) | (acc_2_psp_sva_st_4[2]))) & (~((acc_2_psp_sva_st_4[1])
      | (acc_2_psp_sva_st_4[0])));
  assign or_407_cse = (acc_2_psp_sva_st_4[9]) | (acc_2_psp_sva_st_4[8]) | (acc_2_psp_sva_st_4[7])
      | (acc_2_psp_sva_st_4[6]) | (acc_2_psp_sva_st_4[5]) | (acc_2_psp_sva_st_4[4])
      | (acc_2_psp_sva_st_4[3]) | (acc_2_psp_sva_st_4[2]) | (acc_2_psp_sva_st_4[1])
      | (acc_2_psp_sva_st_4[0]);
  assign or_525_cse = (acc_itm[1]) | (acc_itm[2]) | (acc_itm[3]) | (acc_itm[4]) |
      (acc_itm[5]) | (acc_itm[6]) | (acc_itm[7]) | (acc_itm[8]) | (acc_itm[9]) |
      (acc_itm[10]);
  assign and_384_cse = or_525_cse & and_dcpl_370 & (~ (else_7_if_1_acc_tmp[1]));
  assign mux_171_nl = MUX_s_1_2_2({or_tmp_90 , (~ or_tmp_92)}, else_7_equal_tmp);
  assign mux_77_nl = MUX_s_1_2_2({(mux_171_nl) , or_tmp_90}, or_tmp_3);
  assign and_388_cse = (mux_77_nl) & and_dcpl_144 & (~((else_7_if_1_div_4cyc_st_1[1])
      | (else_7_if_1_div_4cyc_st_1[0])));
  assign div_mgc_div_9_b = {1'b0, {reg_div_mgc_div_9_b_tmp , 10'b0}};
  assign div_mgc_div_9_a = {reg_div_mgc_div_9_a_tmp , 11'b0};
  assign mux_86_nl = MUX_s_1_2_2({or_tmp_90 , (~ or_tmp_92)}, nor_tmp_10);
  assign mux_87_nl = MUX_s_1_2_2({(mux_86_nl) , or_tmp_90}, else_7_if_1_acc_tmp[1]);
  assign and_414_cse = (mux_87_nl) & and_dcpl_144 & (~ (else_7_if_1_div_4cyc_st_1[1]))
      & (else_7_if_1_div_4cyc_st_1[0]);
  assign and_410_cse = or_525_cse & and_dcpl_392 & (~ (else_7_if_1_acc_tmp[1]));
  assign div_mgc_div_10_b = {1'b0, {reg_div_mgc_div_10_b_tmp , 10'b0}};
  assign div_mgc_div_10_a = {reg_div_mgc_div_10_a_tmp , 11'b0};
  assign mux_76_nl = MUX_s_1_2_2({or_tmp_90 , (~ or_tmp_92)}, else_7_equal_tmp);
  assign mux_96_nl = MUX_s_1_2_2({(mux_76_nl) , or_tmp_90}, or_tmp_141);
  assign and_440_cse = (mux_96_nl) & and_dcpl_144 & (else_7_if_1_div_4cyc_st_1[1])
      & (~ (else_7_if_1_div_4cyc_st_1[0]));
  assign and_436_cse = or_525_cse & and_dcpl_370 & (else_7_if_1_acc_tmp[1]);
  assign div_mgc_div_11_b = {1'b0, {reg_div_mgc_div_11_b_tmp , 10'b0}};
  assign div_mgc_div_11_a = {reg_div_mgc_div_11_a_tmp , 11'b0};
  assign mux_109_nl = MUX_s_1_2_2({or_tmp_90 , (~ or_tmp_92)}, and_1061_cse);
  assign and_462_cse = (mux_109_nl) & and_dcpl_144 & (else_7_if_1_div_4cyc_st_1[1])
      & (else_7_if_1_div_4cyc_st_1[0]);
  assign and_458_cse = or_525_cse & and_dcpl_392 & (else_7_if_1_acc_tmp[1]);
  assign mux_110_nl = MUX_s_1_2_2({or_tmp_177 , (or_cse | or_tmp_177)}, and_1061_cse);
  assign and_466_cse = (~ (mux_110_nl)) & and_dcpl_25 & (else_7_if_1_div_4cyc_st_2[1])
      & (else_7_if_1_div_4cyc_st_2[0]);
  assign mux_111_cse = MUX_s_1_2_2({or_tmp_182 , (or_cse | or_tmp_182)}, and_1061_cse);
  assign div_mgc_div_b = {1'b0, {reg_div_mgc_div_b_tmp , 10'b0}};
  assign div_mgc_div_a = {reg_div_mgc_div_a_tmp , 11'b0};
  assign mux_114_nl = MUX_s_1_2_2({(~ or_tmp_92) , or_tmp_90}, or_tmp_194);
  assign and_486_cse = (mux_114_nl) & and_213_cse & (~((else_7_else_1_if_div_4cyc_st_1[1])
      | (else_7_else_1_if_div_4cyc_st_1[0])));
  assign and_481_cse = or_525_cse & and_dcpl_459 & (~((else_7_else_1_if_acc_tmp[0])
      | (else_7_else_1_if_acc_tmp[1])));
  assign div_mgc_div_5_b = {1'b0, {reg_div_mgc_div_5_b_tmp , 10'b0}};
  assign div_mgc_div_5_a = {reg_div_mgc_div_5_a_tmp , 11'b0};
  assign mux_119_nl = MUX_s_1_2_2({(~ or_tmp_92) , or_tmp_90}, or_tmp_221);
  assign and_518_cse = (mux_119_nl) & and_213_cse & (~ (else_7_else_1_if_div_4cyc_st_1[1]))
      & (else_7_else_1_if_div_4cyc_st_1[0]);
  assign and_513_cse = or_525_cse & and_dcpl_459 & (else_7_else_1_if_acc_tmp[0])
      & (~ (else_7_else_1_if_acc_tmp[1]));
  assign div_mgc_div_6_b = {1'b0, {reg_div_mgc_div_6_b_tmp , 10'b0}};
  assign div_mgc_div_6_a = {reg_div_mgc_div_6_a_tmp , 11'b0};
  assign mux_124_nl = MUX_s_1_2_2({(~ or_tmp_92) , or_tmp_90}, or_tmp_248);
  assign and_550_cse = (mux_124_nl) & and_213_cse & (else_7_else_1_if_div_4cyc_st_1[1])
      & (~ (else_7_else_1_if_div_4cyc_st_1[0]));
  assign and_545_cse = or_525_cse & and_dcpl_459 & (~ (else_7_else_1_if_acc_tmp[0]))
      & (else_7_else_1_if_acc_tmp[1]);
  assign div_mgc_div_7_b = {1'b0, {reg_div_mgc_div_7_b_tmp , 10'b0}};
  assign div_mgc_div_7_a = {reg_div_mgc_div_7_a_tmp , 11'b0};
  assign mux_133_nl = MUX_s_1_2_2({(~ or_tmp_92) , or_tmp_90}, or_tmp_281);
  assign and_578_cse = (mux_133_nl) & and_213_cse & (else_7_else_1_if_div_4cyc_st_1[1])
      & (else_7_else_1_if_div_4cyc_st_1[0]);
  assign and_573_cse = or_525_cse & and_dcpl_459 & (else_7_else_1_if_acc_tmp[0])
      & (else_7_else_1_if_acc_tmp[1]);
  assign div_mgc_div_8_b = {1'b0, {reg_div_mgc_div_8_b_tmp , 10'b0}};
  assign div_mgc_div_8_a = {reg_div_mgc_div_8_a_tmp , 11'b0};
  assign mux_142_nl = MUX_s_1_2_2({(~ or_tmp_92) , or_tmp_90}, or_tmp_59);
  assign and_606_cse = (mux_142_nl) & and_247_cse & (~((else_7_else_1_else_div_4cyc_st_1[1])
      | (else_7_else_1_else_div_4cyc_st_1[0])));
  assign and_601_cse = or_525_cse & and_dcpl_571 & (~((else_7_else_1_else_acc_tmp[0])
      | (else_7_else_1_else_acc_tmp[1])));
  assign div_mgc_div_1_b = {1'b0, {reg_div_mgc_div_1_b_tmp , 10'b0}};
  assign div_mgc_div_1_a = {reg_div_mgc_div_1_a_tmp , 11'b0};
  assign mux_147_nl = MUX_s_1_2_2({(~ or_tmp_92) , or_tmp_90}, or_tmp_341);
  assign and_638_cse = (mux_147_nl) & and_247_cse & (~ (else_7_else_1_else_div_4cyc_st_1[1]))
      & (else_7_else_1_else_div_4cyc_st_1[0]);
  assign and_633_cse = or_525_cse & and_dcpl_571 & (else_7_else_1_else_acc_tmp[0])
      & (~ (else_7_else_1_else_acc_tmp[1]));
  assign div_mgc_div_2_b = {1'b0, {reg_div_mgc_div_2_b_tmp , 10'b0}};
  assign div_mgc_div_2_a = {reg_div_mgc_div_2_a_tmp , 11'b0};
  assign mux_152_nl = MUX_s_1_2_2({(~ or_tmp_92) , or_tmp_90}, or_tmp_368);
  assign and_670_cse = (mux_152_nl) & and_247_cse & (else_7_else_1_else_div_4cyc_st_1[1])
      & (~ (else_7_else_1_else_div_4cyc_st_1[0]));
  assign and_665_cse = or_525_cse & and_dcpl_571 & (~ (else_7_else_1_else_acc_tmp[0]))
      & (else_7_else_1_else_acc_tmp[1]);
  assign div_mgc_div_3_b = {1'b0, {reg_div_mgc_div_3_b_tmp , 10'b0}};
  assign div_mgc_div_3_a = {reg_div_mgc_div_3_a_tmp , 11'b0};
  assign mux_161_nl = MUX_s_1_2_2({(~ or_tmp_92) , or_tmp_90}, or_tmp_401);
  assign and_698_cse = (mux_161_nl) & and_247_cse & (else_7_else_1_else_div_4cyc_st_1[1])
      & (else_7_else_1_else_div_4cyc_st_1[0]);
  assign and_693_cse = or_525_cse & and_dcpl_571 & (else_7_else_1_else_acc_tmp[0])
      & (else_7_else_1_else_acc_tmp[1]);
  assign div_mgc_div_4_b = {1'b0, {reg_div_mgc_div_4_b_tmp , 10'b0}};
  assign div_mgc_div_4_a = {reg_div_mgc_div_4_a_tmp , 11'b0};
  assign and_110_cse = and_dcpl_58 & else_7_else_1_equal_svs_st_2;
  assign and_152_cse = and_dcpl_58 & (~ else_7_else_1_equal_svs_st_2);
  assign and_213_cse = and_dcpl_169 & else_7_else_1_equal_svs_st_1;
  assign and_247_cse = and_dcpl_169 & (~ else_7_else_1_equal_svs_st_1);
  assign div_mgc_div_13_b = reg_div_mgc_div_13_b_cse;
  assign div_mgc_div_13_a = {else_7_if_conc_1_tmp_mut_1_sg1 , 10'b0};
  assign div_mgc_div_12_b = reg_div_mgc_div_12_b_cse;
  assign div_mgc_div_12_a = {else_7_if_conc_1_tmp_mut_sg1 , 10'b0};
  assign and_727_cse = and_dcpl_688 & and_dcpl_686 & and_dcpl_684 & and_dcpl_682;
  assign and_1061_cse = (else_7_if_1_acc_tmp[1]) & (else_7_if_1_acc_tmp[0]) & else_7_equal_tmp;
  assign or_cse = (acc_itm[10]) | (acc_itm[9]) | (acc_itm[8]) | (acc_itm[7]) | (acc_itm[6])
      | (acc_itm[5]) | (acc_itm[4]) | (acc_itm[3]) | (acc_itm[2]) | (acc_itm[1]);
  assign else_7_acc_psp_sva_1 = MUX_v_9_2_2({(else_7_acc_2_itm[9:1]) , else_7_acc_psp_sva},
      and_1083_cse);
  assign nl_else_7_acc_2_itm = ({(~ h_sg1_4_lpi_dfm_1_sg2_1) , (~ h_sg1_4_lpi_dfm_1_sg1_1)
      , (~ h_sg1_4_lpi_dfm_4) , 1'b1}) + ({(h_sg1_4_lpi_dfm_1_sg2_1[1:0]) , h_sg1_4_lpi_dfm_1_sg1_1
      , h_sg1_4_lpi_dfm_4 , 5'b1});
  assign else_7_acc_2_itm = nl_else_7_acc_2_itm[9:0];
  assign h_sg1_4_sva_duc_mx0 = MUX1HOT_v_9_5_2({(div_mgc_div_9_z[8:0]) , (div_mgc_div_10_z[8:0])
      , (div_mgc_div_11_z[8:0]) , (div_mgc_div_z[8:0]) , h_sg1_4_sva_duc}, {(and_dcpl_247
      & (~ (else_7_if_1_div_4cyc_st_4[0]))) , (and_dcpl_247 & (else_7_if_1_div_4cyc_st_4[0]))
      , (and_dcpl_251 & (~ (else_7_if_1_div_4cyc_st_4[0]))) , (and_dcpl_251 & (else_7_if_1_div_4cyc_st_4[0]))
      , (~ else_7_equal_svs_st_4)});
  assign mux1h_3_nl = MUX1HOT_v_7_4_2({(div_mgc_div_5_z[8:2]) , (div_mgc_div_6_z[8:2])
      , (div_mgc_div_7_z[8:2]) , (div_mgc_div_8_z[8:2])}, {and_dcpl_280 , and_dcpl_283
      , and_dcpl_286 , and_dcpl_289});
  assign nl_h_sg1_4_sva_1_sg1 = (mux1h_3_nl) + 7'b1;
  assign h_sg1_4_sva_1_sg1 = nl_h_sg1_4_sva_1_sg1[6:0];
  assign h_sg1_5_sva_duc_mx0 = MUX1HOT_v_9_5_2({(div_mgc_div_1_z[8:0]) , (div_mgc_div_2_z[8:0])
      , (div_mgc_div_3_z[8:0]) , (div_mgc_div_4_z[8:0]) , ({reg_h_sg1_6_sva_duc_tmp
      , reg_h_sg1_6_sva_duc_tmp , reg_h_sg1_6_sva_duc_tmp , reg_h_sg1_6_sva_duc_tmp
      , reg_h_sg1_6_sva_duc_tmp , reg_h_sg1_6_sva_duc_tmp , reg_h_sg1_5_sva_duc_tmp_6})},
      {(and_dcpl_326 & and_dcpl_325) , (and_dcpl_326 & and_dcpl_328) , (and_dcpl_326
      & and_dcpl_331) , (and_dcpl_326 & and_dcpl_334) , (else_7_equal_svs_st_4 |
      else_7_else_1_equal_svs_st_4)});
  assign mux1h_6_nl = MUX1HOT_v_6_4_2({(div_mgc_div_1_z[8:3]) , (div_mgc_div_2_z[8:3])
      , (div_mgc_div_3_z[8:3]) , (div_mgc_div_4_z[8:3])}, {and_dcpl_325 , and_dcpl_328
      , and_dcpl_331 , and_dcpl_334});
  assign h_sg1_4_lpi_dfm_1_sg2_1 = MUX1HOT_v_6_3_2({((mux1h_6_nl) + 6'b1) , (h_sg1_4_sva_1_sg1[6:1])
      , (h_sg1_4_sva_duc_mx0[8:3])}, {else_7_nor_ssc , else_7_and_5_itm_4 , else_7_equal_svs_4});
  assign h_sg1_4_lpi_dfm_1_sg1_1 = MUX1HOT_s_1_3_2({(h_sg1_5_sva_duc_mx0[2]) , (h_sg1_4_sva_1_sg1[0])
      , (h_sg1_4_sva_duc_mx0[2])}, {else_7_nor_ssc , else_7_and_5_itm_4 , else_7_equal_svs_4});
  assign h_sg1_4_lpi_dfm_4 = MUX1HOT_v_2_7_2({(h_sg1_5_sva_duc_mx0[1:0]) , (div_mgc_div_5_z[1:0])
      , (div_mgc_div_6_z[1:0]) , (div_mgc_div_7_z[1:0]) , (div_mgc_div_8_z[1:0])
      , reg_h_sg1_6_sva_duc_tmp_7 , (h_sg1_4_sva_duc_mx0[1:0])}, {else_7_nor_ssc
      , (and_dcpl_281 & and_dcpl_280 & else_7_and_5_itm_4) , (and_dcpl_281 & and_dcpl_283
      & else_7_and_5_itm_4) , (and_dcpl_281 & and_dcpl_286 & else_7_and_5_itm_4)
      , (and_dcpl_281 & and_dcpl_289 & else_7_and_5_itm_4) , ((else_7_equal_svs_st_4
      | (~ else_7_else_1_equal_svs_st_4)) & else_7_and_5_itm_4) , else_7_equal_svs_4});
  assign else_7_nor_ssc = ~(else_7_else_1_equal_svs_4 | else_7_equal_svs_4);
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
  assign mux1h_32_tmp = MUX1HOT_v_10_3_2({r_rsc_mgc_in_wire_d , b_rsc_mgc_in_wire_d
      , g_rsc_mgc_in_wire_d}, {(~((if_if_acc_itm[11]) | (if_acc_1_itm[11]))) , (((if_if_acc_itm[11])
      & (~ (if_acc_1_itm[11]))) | ((else_1_if_acc_itm[11]) & (if_acc_1_itm[11])))
      , ((~ (else_1_if_acc_itm[11])) & (if_acc_1_itm[11]))});
  assign mux1h_33_nl = MUX1HOT_v_10_3_2({r_rsc_mgc_in_wire_d , b_rsc_mgc_in_wire_d
      , g_rsc_mgc_in_wire_d}, {(~((if_3_if_acc_itm[11]) | (if_3_acc_1_itm[11])))
      , (((if_3_if_acc_itm[11]) & (~ (if_3_acc_1_itm[11]))) | ((else_5_if_acc_itm[11])
      & (if_3_acc_1_itm[11]))) , ((~ (else_5_if_acc_itm[11])) & (if_3_acc_1_itm[11]))});
  assign nl_acc_itm = ({mux1h_32_tmp , 1'b1}) + ({(~ (mux1h_33_nl)) , 1'b1});
  assign acc_itm = nl_acc_itm[10:0];
  assign nl_else_7_if_1_acc_1_itm = ({g_1_lpi_dfm , 1'b1}) + ({(~ b_1_lpi_dfm) ,
      1'b1});
  assign else_7_if_1_acc_1_itm = nl_else_7_if_1_acc_1_itm[10:0];
  assign nl_else_7_if_1_acc_tmp = else_7_if_1_div_4cyc + 2'b1;
  assign else_7_if_1_acc_tmp = nl_else_7_if_1_acc_tmp[1:0];
  assign g_1_lpi_dfm = g_rsc_mgc_in_wire_d & ({{9{unequal_tmp_9}}, unequal_tmp_9});
  assign b_1_lpi_dfm = b_rsc_mgc_in_wire_d & ({{9{unequal_tmp_9}}, unequal_tmp_9});
  assign nl_else_7_else_1_if_acc_2_itm = ({b_1_lpi_dfm , 1'b1}) + ({(~ r_1_lpi_dfm)
      , 1'b1});
  assign else_7_else_1_if_acc_2_itm = nl_else_7_else_1_if_acc_2_itm[10:0];
  assign nl_else_7_else_1_if_acc_tmp = else_7_else_1_if_div_4cyc + 2'b1;
  assign else_7_else_1_if_acc_tmp = nl_else_7_else_1_if_acc_tmp[1:0];
  assign r_1_lpi_dfm = r_rsc_mgc_in_wire_d & ({{9{unequal_tmp_9}}, unequal_tmp_9});
  assign nl_else_7_else_1_else_acc_2_itm = ({r_1_lpi_dfm , 1'b1}) + ({(~ g_1_lpi_dfm)
      , 1'b1});
  assign else_7_else_1_else_acc_2_itm = nl_else_7_else_1_else_acc_2_itm[10:0];
  assign nl_else_7_else_1_else_acc_tmp = else_7_else_1_else_div_4cyc + 2'b1;
  assign else_7_else_1_else_acc_tmp = nl_else_7_else_1_else_acc_tmp[1:0];
  assign else_7_else_1_equal_tmp = g_1_lpi_dfm == mux1h_32_tmp;
  assign else_7_equal_tmp = r_1_lpi_dfm == mux1h_32_tmp;
  assign unequal_tmp_9 = (mux1h_32_tmp[9]) | (mux1h_32_tmp[8]) | (mux1h_32_tmp[7])
      | (mux1h_32_tmp[6]) | (mux1h_32_tmp[5]) | (mux1h_32_tmp[4]) | (mux1h_32_tmp[3])
      | (mux1h_32_tmp[2]) | (mux1h_32_tmp[1]) | (mux1h_32_tmp[0]);
  assign nl_if_3_acc_1_itm = ({1'b1 , g_rsc_mgc_in_wire_d , 1'b1}) + conv_u2u_11_12({(~
      r_rsc_mgc_in_wire_d) , 1'b1});
  assign if_3_acc_1_itm = nl_if_3_acc_1_itm[11:0];
  assign nl_if_acc_1_itm = ({1'b1 , r_rsc_mgc_in_wire_d , 1'b1}) + conv_u2u_11_12({(~
      g_rsc_mgc_in_wire_d) , 1'b1});
  assign if_acc_1_itm = nl_if_acc_1_itm[11:0];
  assign mux1h_34_nl = MUX1HOT_v_18_3_2({(div_mgc_div_13_z_oreg[17:0]) , (div_mgc_div_12_z_oreg[17:0])
      , s_sg1_1_sva_2_duc}, {(~((~(or_dcpl_656 | or_dcpl_654 | or_dcpl_652 | or_dcpl_650))
      | else_7_if_div_2cyc_st_3)) , ((or_dcpl_656 | or_dcpl_654 | or_dcpl_652 | or_dcpl_650)
      & else_7_if_div_2cyc_st_3) , ((~((max_sg1_lpi_dfm_3_st_3[9]) | (max_sg1_lpi_dfm_3_st_3[8])
      | (max_sg1_lpi_dfm_3_st_3[7]))) & (~((max_sg1_lpi_dfm_3_st_3[6]) | (max_sg1_lpi_dfm_3_st_3[5])))
      & (~((max_sg1_lpi_dfm_3_st_3[4]) | (max_sg1_lpi_dfm_3_st_3[3]) | (max_sg1_lpi_dfm_3_st_3[2])))
      & (~((max_sg1_lpi_dfm_3_st_3[1]) | (max_sg1_lpi_dfm_3_st_3[0]))))});
  assign nl_mul_1_itm = 18'b11001 * ((mux1h_34_nl) & ({{17{unequal_tmp_8}}, unequal_tmp_8})
      & ({{17{unequal_tmp_4}}, unequal_tmp_4}));
  assign mul_1_itm = nl_mul_1_itm[17:0];
  assign nl_mul_itm = 14'b11001 * conv_u2u_10_14(mux1h_32_tmp);
  assign mul_itm = nl_mul_itm[13:0];
  assign or_tmp_1 = (acc_2_psp_sva_st_2[0]) | (acc_2_psp_sva_st_2[1]) | (acc_2_psp_sva_st_2[2])
      | (acc_2_psp_sva_st_2[3]) | (acc_2_psp_sva_st_2[4]) | (acc_2_psp_sva_st_2[5])
      | (acc_2_psp_sva_st_2[6]) | (acc_2_psp_sva_st_2[7]) | (acc_2_psp_sva_st_2[8])
      | (acc_2_psp_sva_st_2[9]);
  assign and_dcpl_25 = main_stage_0_3 & else_7_equal_svs_st_2;
  assign and_dcpl_58 = main_stage_0_3 & (~ else_7_equal_svs_st_2);
  assign and_dcpl_144 = main_stage_0_2 & else_7_equal_svs_st_1;
  assign and_dcpl_169 = main_stage_0_2 & (~ else_7_equal_svs_st_1);
  assign or_tmp_3 = (else_7_if_1_acc_tmp[1]) | (else_7_if_1_acc_tmp[0]);
  assign or_tmp_59 = (else_7_else_1_else_acc_tmp[1]) | (else_7_else_1_else_acc_tmp[0])
      | else_7_else_1_equal_tmp | else_7_equal_tmp;
  assign and_dcpl_247 = else_7_equal_svs_st_4 & (~ (else_7_if_1_div_4cyc_st_4[1]));
  assign and_dcpl_251 = else_7_equal_svs_st_4 & (else_7_if_1_div_4cyc_st_4[1]);
  assign and_dcpl_256 = main_stage_0_5 & else_7_equal_svs_st_4;
  assign and_dcpl_280 = ~((else_7_else_1_if_div_4cyc_st_4[1]) | (else_7_else_1_if_div_4cyc_st_4[0]));
  assign and_dcpl_281 = (~ else_7_equal_svs_st_4) & else_7_else_1_equal_svs_st_4;
  assign and_dcpl_283 = (~ (else_7_else_1_if_div_4cyc_st_4[1])) & (else_7_else_1_if_div_4cyc_st_4[0]);
  assign and_dcpl_286 = (else_7_else_1_if_div_4cyc_st_4[1]) & (~ (else_7_else_1_if_div_4cyc_st_4[0]));
  assign and_dcpl_289 = (else_7_else_1_if_div_4cyc_st_4[1]) & (else_7_else_1_if_div_4cyc_st_4[0]);
  assign and_dcpl_297 = main_stage_0_5 & (~ else_7_equal_svs_st_4);
  assign and_dcpl_298 = and_dcpl_297 & else_7_else_1_equal_svs_st_4;
  assign or_dcpl_382 = (~ main_stage_0_5) | else_7_equal_svs_st_4;
  assign and_dcpl_325 = ~((else_7_else_1_else_div_4cyc_st_4[1]) | (else_7_else_1_else_div_4cyc_st_4[0]));
  assign and_dcpl_326 = ~(else_7_equal_svs_st_4 | else_7_else_1_equal_svs_st_4);
  assign and_dcpl_328 = (~ (else_7_else_1_else_div_4cyc_st_4[1])) & (else_7_else_1_else_div_4cyc_st_4[0]);
  assign and_dcpl_331 = (else_7_else_1_else_div_4cyc_st_4[1]) & (~ (else_7_else_1_else_div_4cyc_st_4[0]));
  assign and_dcpl_334 = (else_7_else_1_else_div_4cyc_st_4[1]) & (else_7_else_1_else_div_4cyc_st_4[0]);
  assign and_dcpl_343 = and_dcpl_297 & (~ else_7_else_1_equal_svs_st_4);
  assign and_dcpl_370 = else_7_equal_tmp & (~ (else_7_if_1_acc_tmp[0]));
  assign or_tmp_90 = (acc_2_psp_sva_st_1[0]) | (acc_2_psp_sva_st_1[1]) | (acc_2_psp_sva_st_1[2])
      | (acc_2_psp_sva_st_1[3]) | (acc_2_psp_sva_st_1[4]) | (acc_2_psp_sva_st_1[5])
      | (acc_2_psp_sva_st_1[6]) | (acc_2_psp_sva_st_1[7]) | (acc_2_psp_sva_st_1[8])
      | (acc_2_psp_sva_st_1[9]);
  assign or_tmp_92 = or_cse | (~ or_tmp_90);
  assign or_532_cse = (~ or_tmp_90) | (~ main_stage_0_2) | (~ else_7_equal_svs_st_1)
      | (else_7_if_1_div_4cyc_st_1[0]) | (else_7_if_1_div_4cyc_st_1[1]);
  assign and_tmp_1 = or_532_cse & or_tmp_1;
  assign and_tmp_2 = or_532_cse & ((~ or_tmp_1) | (~ main_stage_0_3) | (~ else_7_equal_svs_st_2)
      | (else_7_if_1_div_4cyc_st_2[0]) | (else_7_if_1_div_4cyc_st_2[1]));
  assign and_dcpl_392 = else_7_equal_tmp & (else_7_if_1_acc_tmp[0]);
  assign nor_tmp_10 = (else_7_if_1_acc_tmp[0]) & else_7_equal_tmp;
  assign nand_10_cse = ~(or_tmp_90 & main_stage_0_2 & else_7_equal_svs_st_1 & (else_7_if_1_div_4cyc_st_1[0])
      & (~ (else_7_if_1_div_4cyc_st_1[1])));
  assign and_tmp_5 = nand_10_cse & or_tmp_1;
  assign and_tmp_6 = nand_10_cse & (~(or_tmp_1 & main_stage_0_3 & else_7_equal_svs_st_2
      & (else_7_if_1_div_4cyc_st_2[0]) & (~ (else_7_if_1_div_4cyc_st_2[1]))));
  assign or_tmp_141 = (~ (else_7_if_1_acc_tmp[1])) | (else_7_if_1_acc_tmp[0]);
  assign nand_16_cse = ~(or_tmp_90 & main_stage_0_2 & else_7_equal_svs_st_1 & (~
      (else_7_if_1_div_4cyc_st_1[0])));
  assign mux_tmp_48 = MUX_s_1_2_2({(~((else_7_if_1_div_4cyc_st_1[1]) | (~ or_tmp_1)))
      , or_tmp_1}, nand_16_cse);
  assign or_tmp_154 = ~(or_tmp_1 & main_stage_0_3 & else_7_equal_svs_st_2 & (~ (else_7_if_1_div_4cyc_st_2[0]))
      & (else_7_if_1_div_4cyc_st_2[1]));
  assign mux_tmp_51 = MUX_s_1_2_2({(~((else_7_if_1_div_4cyc_st_1[1]) | (~ or_tmp_154)))
      , or_tmp_154}, nand_16_cse);
  assign or_tmp_177 = ~((~(or_tmp_90 & main_stage_0_2 & else_7_equal_svs_st_1 & (else_7_if_1_div_4cyc_st_1[0])
      & (else_7_if_1_div_4cyc_st_1[1]))) & or_tmp_1);
  assign or_tmp_182 = (or_tmp_90 & main_stage_0_2 & else_7_equal_svs_st_1 & (else_7_if_1_div_4cyc_st_1[0])
      & (else_7_if_1_div_4cyc_st_1[1])) | (or_tmp_1 & main_stage_0_3 & else_7_equal_svs_st_2
      & (else_7_if_1_div_4cyc_st_2[0]) & (else_7_if_1_div_4cyc_st_2[1]));
  assign and_dcpl_459 = (~ else_7_equal_tmp) & else_7_else_1_equal_tmp;
  assign or_tmp_194 = (else_7_else_1_if_acc_tmp[1]) | (else_7_else_1_if_acc_tmp[0])
      | (~ else_7_else_1_equal_tmp) | else_7_equal_tmp;
  assign or_706_cse = (~ or_tmp_90) | (~ main_stage_0_2) | else_7_equal_svs_st_1
      | (~ else_7_else_1_equal_svs_st_1) | (else_7_else_1_if_div_4cyc_st_1[0]) |
      (else_7_else_1_if_div_4cyc_st_1[1]);
  assign and_tmp_9 = or_706_cse & or_tmp_1;
  assign and_tmp_10 = or_706_cse & ((~ or_tmp_1) | (~ main_stage_0_3) | else_7_equal_svs_st_2
      | (~ else_7_else_1_equal_svs_st_2) | (else_7_else_1_if_div_4cyc_st_2[0]) |
      (else_7_else_1_if_div_4cyc_st_2[1]));
  assign or_tmp_221 = (else_7_else_1_if_acc_tmp[1]) | (~ (else_7_else_1_if_acc_tmp[0]))
      | (~ else_7_else_1_equal_tmp) | else_7_equal_tmp;
  assign or_751_cse = (~ or_tmp_90) | (~ main_stage_0_2) | else_7_equal_svs_st_1
      | (~ else_7_else_1_equal_svs_st_1) | (~ (else_7_else_1_if_div_4cyc_st_1[0]))
      | (else_7_else_1_if_div_4cyc_st_1[1]);
  assign and_tmp_13 = or_751_cse & or_tmp_1;
  assign and_tmp_14 = or_751_cse & ((~ or_tmp_1) | (~ main_stage_0_3) | else_7_equal_svs_st_2
      | (~ else_7_else_1_equal_svs_st_2) | (~ (else_7_else_1_if_div_4cyc_st_2[0]))
      | (else_7_else_1_if_div_4cyc_st_2[1]));
  assign or_tmp_248 = (~ (else_7_else_1_if_acc_tmp[1])) | (else_7_else_1_if_acc_tmp[0])
      | (~ else_7_else_1_equal_tmp) | else_7_equal_tmp;
  assign or_796_cse = (~ or_tmp_90) | (~ main_stage_0_2) | else_7_equal_svs_st_1
      | (~ else_7_else_1_equal_svs_st_1) | (else_7_else_1_if_div_4cyc_st_1[0]);
  assign mux_tmp_76 = MUX_s_1_2_2({(~((else_7_else_1_if_div_4cyc_st_1[1]) | (~ or_tmp_1)))
      , or_tmp_1}, or_796_cse);
  assign or_tmp_261 = (~ or_tmp_1) | (~ main_stage_0_3) | else_7_equal_svs_st_2 |
      (~ else_7_else_1_equal_svs_st_2) | (else_7_else_1_if_div_4cyc_st_2[0]) | (~
      (else_7_else_1_if_div_4cyc_st_2[1]));
  assign mux_tmp_78 = MUX_s_1_2_2({(~((else_7_else_1_if_div_4cyc_st_1[1]) | (~ or_tmp_261)))
      , or_tmp_261}, or_796_cse);
  assign or_tmp_281 = ~((else_7_else_1_if_acc_tmp[1]) & (else_7_else_1_if_acc_tmp[0])
      & else_7_else_1_equal_tmp & (~ else_7_equal_tmp));
  assign nor_tmp_26 = else_7_else_1_equal_svs_st_1 & (else_7_else_1_if_div_4cyc_st_1[0])
      & (else_7_else_1_if_div_4cyc_st_1[1]);
  assign or_847_cse = (~ or_tmp_90) | (~ main_stage_0_2) | else_7_equal_svs_st_1;
  assign mux_tmp_85 = MUX_s_1_2_2({(~(nor_tmp_26 | (~ or_tmp_1))) , or_tmp_1}, or_847_cse);
  assign or_tmp_294 = ~(or_tmp_1 & main_stage_0_3 & (~ else_7_equal_svs_st_2) & else_7_else_1_equal_svs_st_2
      & (else_7_else_1_if_div_4cyc_st_2[0]) & (else_7_else_1_if_div_4cyc_st_2[1]));
  assign mux_136_cse = MUX_s_1_2_2({(~(nor_tmp_26 | (~ or_tmp_294))) , or_tmp_294},
      or_847_cse);
  assign and_dcpl_571 = ~(else_7_equal_tmp | else_7_else_1_equal_tmp);
  assign or_898_cse = (~ or_tmp_90) | (~ main_stage_0_2) | else_7_equal_svs_st_1
      | else_7_else_1_equal_svs_st_1 | (else_7_else_1_else_div_4cyc_st_1[0]) | (else_7_else_1_else_div_4cyc_st_1[1]);
  assign and_tmp_17 = or_898_cse & or_tmp_1;
  assign and_tmp_18 = or_898_cse & ((~ or_tmp_1) | (~ main_stage_0_3) | else_7_equal_svs_st_2
      | else_7_else_1_equal_svs_st_2 | (else_7_else_1_else_div_4cyc_st_2[0]) | (else_7_else_1_else_div_4cyc_st_2[1]));
  assign or_tmp_341 = (else_7_else_1_else_acc_tmp[1]) | (~ (else_7_else_1_else_acc_tmp[0]))
      | else_7_else_1_equal_tmp | else_7_equal_tmp;
  assign or_943_cse = (~ or_tmp_90) | (~ main_stage_0_2) | else_7_equal_svs_st_1
      | else_7_else_1_equal_svs_st_1 | (~ (else_7_else_1_else_div_4cyc_st_1[0]))
      | (else_7_else_1_else_div_4cyc_st_1[1]);
  assign and_tmp_21 = or_943_cse & or_tmp_1;
  assign and_tmp_22 = or_943_cse & ((~ or_tmp_1) | (~ main_stage_0_3) | else_7_equal_svs_st_2
      | else_7_else_1_equal_svs_st_2 | (~ (else_7_else_1_else_div_4cyc_st_2[0]))
      | (else_7_else_1_else_div_4cyc_st_2[1]));
  assign or_tmp_368 = (~ (else_7_else_1_else_acc_tmp[1])) | (else_7_else_1_else_acc_tmp[0])
      | else_7_else_1_equal_tmp | else_7_equal_tmp;
  assign or_988_cse = (~ or_tmp_90) | (~ main_stage_0_2) | else_7_equal_svs_st_1
      | else_7_else_1_equal_svs_st_1 | (else_7_else_1_else_div_4cyc_st_1[0]);
  assign mux_tmp_104 = MUX_s_1_2_2({(~((else_7_else_1_else_div_4cyc_st_1[1]) | (~
      or_tmp_1))) , or_tmp_1}, or_988_cse);
  assign or_tmp_381 = (~ or_tmp_1) | (~ main_stage_0_3) | else_7_equal_svs_st_2 |
      else_7_else_1_equal_svs_st_2 | (else_7_else_1_else_div_4cyc_st_2[0]) | (~ (else_7_else_1_else_div_4cyc_st_2[1]));
  assign mux_tmp_106 = MUX_s_1_2_2({(~((else_7_else_1_else_div_4cyc_st_1[1]) | (~
      or_tmp_381))) , or_tmp_381}, or_988_cse);
  assign or_tmp_401 = (~ (else_7_else_1_else_acc_tmp[1])) | (~ (else_7_else_1_else_acc_tmp[0]))
      | else_7_else_1_equal_tmp | else_7_equal_tmp;
  assign nor_tmp_32 = (else_7_else_1_else_div_4cyc_st_1[0]) & (else_7_else_1_else_div_4cyc_st_1[1]);
  assign or_1039_cse = (~ or_tmp_90) | (~ main_stage_0_2) | else_7_equal_svs_st_1
      | else_7_else_1_equal_svs_st_1;
  assign mux_tmp_113 = MUX_s_1_2_2({(~(nor_tmp_32 | (~ or_tmp_1))) , or_tmp_1}, or_1039_cse);
  assign or_tmp_414 = (~ or_tmp_1) | (~ main_stage_0_3) | else_7_equal_svs_st_2 |
      else_7_else_1_equal_svs_st_2 | (~((else_7_else_1_else_div_4cyc_st_2[0]) & (else_7_else_1_else_div_4cyc_st_2[1])));
  assign mux_tmp_115 = MUX_s_1_2_2({(~(nor_tmp_32 | (~ or_tmp_414))) , or_tmp_414},
      or_1039_cse);
  assign not_tmp_263 = ~(((mux1h_32_tmp[9]) | (mux1h_32_tmp[8]) | (mux1h_32_tmp[7])
      | (mux1h_32_tmp[6]) | (mux1h_32_tmp[5]) | (mux1h_32_tmp[4]) | (mux1h_32_tmp[3])
      | (mux1h_32_tmp[2]) | (mux1h_32_tmp[1]) | (mux1h_32_tmp[0])) & or_cse);
  assign or_dcpl_641 = not_tmp_263 | (~ else_7_if_div_2cyc);
  assign or_dcpl_643 = not_tmp_263 | else_7_if_div_2cyc;
  assign and_dcpl_682 = ~((acc_itm[9]) | (acc_itm[10]));
  assign and_dcpl_684 = ~((acc_itm[6]) | (acc_itm[7]) | (acc_itm[8]));
  assign and_dcpl_686 = ~((acc_itm[4]) | (acc_itm[5]));
  assign and_dcpl_688 = ~((acc_itm[1]) | (acc_itm[2]) | (acc_itm[3]));
  assign or_dcpl_650 = (max_sg1_lpi_dfm_3_st_3[1]) | (max_sg1_lpi_dfm_3_st_3[0]);
  assign or_dcpl_652 = (max_sg1_lpi_dfm_3_st_3[4]) | (max_sg1_lpi_dfm_3_st_3[3])
      | (max_sg1_lpi_dfm_3_st_3[2]);
  assign or_dcpl_654 = (max_sg1_lpi_dfm_3_st_3[6]) | (max_sg1_lpi_dfm_3_st_3[5]);
  assign or_dcpl_656 = (max_sg1_lpi_dfm_3_st_3[9]) | (max_sg1_lpi_dfm_3_st_3[8])
      | (max_sg1_lpi_dfm_3_st_3[7]);
  assign and_tmp_26 = ((max_sg1_lpi_dfm_3_st_3[0]) | (max_sg1_lpi_dfm_3_st_3[1])
      | (max_sg1_lpi_dfm_3_st_3[2]) | (max_sg1_lpi_dfm_3_st_3[3]) | (max_sg1_lpi_dfm_3_st_3[4])
      | (max_sg1_lpi_dfm_3_st_3[5]) | (max_sg1_lpi_dfm_3_st_3[6]) | (max_sg1_lpi_dfm_3_st_3[7])
      | (max_sg1_lpi_dfm_3_st_3[8]) | (max_sg1_lpi_dfm_3_st_3[9])) & ((acc_2_psp_sva_st_3[0])
      | (acc_2_psp_sva_st_3[1]) | (acc_2_psp_sva_st_3[2]) | (acc_2_psp_sva_st_3[3])
      | (acc_2_psp_sva_st_3[4]) | (acc_2_psp_sva_st_3[5]) | (acc_2_psp_sva_st_3[6])
      | (acc_2_psp_sva_st_3[7]) | (acc_2_psp_sva_st_3[8]) | (acc_2_psp_sva_st_3[9]));
  assign mux_78_nl = MUX_s_1_2_2({and_tmp_1 , (~(or_cse | (~ and_tmp_1)))}, else_7_equal_tmp);
  assign mux_79_nl = MUX_s_1_2_2({(mux_78_nl) , and_tmp_1}, or_tmp_3);
  assign and_393_cse = (mux_79_nl) & and_dcpl_25 & (~((else_7_if_1_div_4cyc_st_2[1])
      | (else_7_if_1_div_4cyc_st_2[0])));
  assign mux_80_nl = MUX_s_1_2_2({and_tmp_2 , (~(or_cse | (~ and_tmp_2)))}, else_7_equal_tmp);
  assign mux_81_cse = MUX_s_1_2_2({(mux_80_nl) , and_tmp_2}, or_tmp_3);
  assign mux_88_nl = MUX_s_1_2_2({and_tmp_5 , (~(or_cse | (~ and_tmp_5)))}, nor_tmp_10);
  assign mux_89_nl = MUX_s_1_2_2({(mux_88_nl) , and_tmp_5}, else_7_if_1_acc_tmp[1]);
  assign and_419_cse = (mux_89_nl) & and_dcpl_25 & (~ (else_7_if_1_div_4cyc_st_2[1]))
      & (else_7_if_1_div_4cyc_st_2[0]);
  assign mux_90_nl = MUX_s_1_2_2({and_tmp_6 , (~(or_cse | (~ and_tmp_6)))}, nor_tmp_10);
  assign mux_91_cse = MUX_s_1_2_2({(mux_90_nl) , and_tmp_6}, else_7_if_1_acc_tmp[1]);
  assign mux_98_nl = MUX_s_1_2_2({mux_tmp_48 , (~(or_cse | (~ mux_tmp_48)))}, else_7_equal_tmp);
  assign mux_99_nl = MUX_s_1_2_2({(mux_98_nl) , mux_tmp_48}, or_tmp_141);
  assign and_444_cse = (mux_99_nl) & and_dcpl_25 & (else_7_if_1_div_4cyc_st_2[1])
      & (~ (else_7_if_1_div_4cyc_st_2[0]));
  assign mux_101_nl = MUX_s_1_2_2({mux_tmp_51 , (~(or_cse | (~ mux_tmp_51)))}, else_7_equal_tmp);
  assign mux_102_cse = MUX_s_1_2_2({(mux_101_nl) , mux_tmp_51}, or_tmp_141);
  assign mux_115_nl = MUX_s_1_2_2({(~(or_cse | (~ and_tmp_9))) , and_tmp_9}, or_tmp_194);
  assign and_492_cse = (mux_115_nl) & and_110_cse & (~((else_7_else_1_if_div_4cyc_st_2[1])
      | (else_7_else_1_if_div_4cyc_st_2[0])));
  assign mux_116_cse = MUX_s_1_2_2({(~(or_cse | (~ and_tmp_10))) , and_tmp_10}, or_tmp_194);
  assign mux_120_nl = MUX_s_1_2_2({(~(or_cse | (~ and_tmp_13))) , and_tmp_13}, or_tmp_221);
  assign and_524_cse = (mux_120_nl) & and_110_cse & (~ (else_7_else_1_if_div_4cyc_st_2[1]))
      & (else_7_else_1_if_div_4cyc_st_2[0]);
  assign mux_121_cse = MUX_s_1_2_2({(~(or_cse | (~ and_tmp_14))) , and_tmp_14}, or_tmp_221);
  assign mux_126_nl = MUX_s_1_2_2({(~(or_cse | (~ mux_tmp_76))) , mux_tmp_76}, or_tmp_248);
  assign and_555_cse = (mux_126_nl) & and_110_cse & (else_7_else_1_if_div_4cyc_st_2[1])
      & (~ (else_7_else_1_if_div_4cyc_st_2[0]));
  assign mux_128_cse = MUX_s_1_2_2({(~(or_cse | (~ mux_tmp_78))) , mux_tmp_78}, or_tmp_248);
  assign mux_135_nl = MUX_s_1_2_2({(~(or_cse | (~ mux_tmp_85))) , mux_tmp_85}, or_tmp_281);
  assign and_583_cse = (mux_135_nl) & and_110_cse & (else_7_else_1_if_div_4cyc_st_2[1])
      & (else_7_else_1_if_div_4cyc_st_2[0]);
  assign mux_137_cse = MUX_s_1_2_2({(~(or_cse | (~ mux_136_cse))) , mux_136_cse},
      or_tmp_281);
  assign mux_143_nl = MUX_s_1_2_2({(~(or_cse | (~ and_tmp_17))) , and_tmp_17}, or_tmp_59);
  assign and_612_cse = (mux_143_nl) & and_152_cse & (~((else_7_else_1_else_div_4cyc_st_2[1])
      | (else_7_else_1_else_div_4cyc_st_2[0])));
  assign mux_144_cse = MUX_s_1_2_2({(~(or_cse | (~ and_tmp_18))) , and_tmp_18}, or_tmp_59);
  assign mux_148_nl = MUX_s_1_2_2({(~(or_cse | (~ and_tmp_21))) , and_tmp_21}, or_tmp_341);
  assign and_644_cse = (mux_148_nl) & and_152_cse & (~ (else_7_else_1_else_div_4cyc_st_2[1]))
      & (else_7_else_1_else_div_4cyc_st_2[0]);
  assign mux_149_cse = MUX_s_1_2_2({(~(or_cse | (~ and_tmp_22))) , and_tmp_22}, or_tmp_341);
  assign mux_154_nl = MUX_s_1_2_2({(~(or_cse | (~ mux_tmp_104))) , mux_tmp_104},
      or_tmp_368);
  assign and_675_cse = (mux_154_nl) & and_152_cse & (else_7_else_1_else_div_4cyc_st_2[1])
      & (~ (else_7_else_1_else_div_4cyc_st_2[0]));
  assign mux_156_cse = MUX_s_1_2_2({(~(or_cse | (~ mux_tmp_106))) , mux_tmp_106},
      or_tmp_368);
  assign mux_163_nl = MUX_s_1_2_2({(~(or_cse | (~ mux_tmp_113))) , mux_tmp_113},
      or_tmp_401);
  assign and_703_cse = (mux_163_nl) & and_152_cse & (else_7_else_1_else_div_4cyc_st_2[1])
      & (else_7_else_1_else_div_4cyc_st_2[0]);
  assign mux_165_cse = MUX_s_1_2_2({(~(or_cse | (~ mux_tmp_115))) , mux_tmp_115},
      or_tmp_401);
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      V_OUT_rsc_mgc_out_stdreg_d <= 10'b0;
      S_OUT_rsc_mgc_out_stdreg_d <= 10'b0;
      H_OUT_rsc_mgc_out_stdreg_d <= 10'b0;
      else_7_acc_psp_sva <= 9'b0;
      h_sg1_4_sva_duc <= 9'b0;
      else_7_if_1_div_4cyc_st_4 <= 2'b0;
      else_7_else_1_if_div_4cyc_st_4 <= 2'b0;
      else_7_else_1_else_div_4cyc_st_4 <= 2'b0;
      else_7_else_1_equal_svs_st_4 <= 1'b0;
      else_7_and_5_itm_4 <= 1'b0;
      else_7_equal_svs_4 <= 1'b0;
      else_7_else_1_equal_svs_4 <= 1'b0;
      else_7_equal_svs_st_4 <= 1'b0;
      acc_5_itm_4 <= 9'b0;
      acc_4_itm_1 <= 10'b0;
      unequal_tmp_5 <= 1'b0;
      acc_2_psp_sva_st_4 <= 10'b0;
      else_7_if_div_2cyc_st_3 <= 1'b0;
      mut_41_sg1_1 <= 10'b0;
      else_7_if_1_conc_2_tmp_mut_9_sg1 <= 10'b0;
      mut_44_sg1_1 <= 10'b0;
      else_7_if_1_conc_2_tmp_mut_12_sg1 <= 10'b0;
      mut_47_sg1_1 <= 10'b0;
      else_7_if_1_conc_2_tmp_mut_15_sg1 <= 10'b0;
      mut_14_sg1_1 <= 10'b0;
      else_7_if_1_conc_2_tmp_mut_6_sg1 <= 10'b0;
      else_7_if_1_div_4cyc_st_3 <= 2'b0;
      mut_29_sg1_1 <= 10'b0;
      else_7_else_1_if_conc_2_tmp_mut_6_sg1 <= 10'b0;
      mut_32_sg1_1 <= 10'b0;
      else_7_else_1_if_conc_2_tmp_mut_9_sg1 <= 10'b0;
      mut_35_sg1_1 <= 10'b0;
      else_7_else_1_if_conc_2_tmp_mut_12_sg1 <= 10'b0;
      mut_38_sg1_1 <= 10'b0;
      else_7_else_1_if_conc_2_tmp_mut_15_sg1 <= 10'b0;
      else_7_else_1_if_div_4cyc_st_3 <= 2'b0;
      mut_17_sg1_1 <= 10'b0;
      else_7_else_1_else_conc_2_tmp_mut_6_sg1 <= 10'b0;
      mut_20_sg1_1 <= 10'b0;
      else_7_else_1_else_conc_2_tmp_mut_9_sg1 <= 10'b0;
      mut_23_sg1_1 <= 10'b0;
      else_7_else_1_else_conc_2_tmp_mut_12_sg1 <= 10'b0;
      mut_26_sg1_1 <= 10'b0;
      else_7_else_1_else_conc_2_tmp_mut_15_sg1 <= 10'b0;
      else_7_else_1_else_div_4cyc_st_3 <= 2'b0;
      else_7_else_1_equal_svs_st_3 <= 1'b0;
      else_7_equal_svs_st_3 <= 1'b0;
      max_sg1_lpi_dfm_3_st_3 <= 10'b0;
      acc_2_psp_sva_st_3 <= 10'b0;
      mut_40_sg1_1 <= 10'b0;
      else_7_if_1_conc_2_tmp_mut_8_sg1 <= 10'b0;
      mut_43_sg1_1 <= 10'b0;
      else_7_if_1_conc_2_tmp_mut_11_sg1 <= 10'b0;
      mut_46_sg1_1 <= 10'b0;
      else_7_if_1_conc_2_tmp_mut_14_sg1 <= 10'b0;
      mut_13_sg1_1 <= 10'b0;
      else_7_if_1_conc_2_tmp_mut_5_sg1 <= 10'b0;
      else_7_if_1_div_4cyc_st_2 <= 2'b0;
      mut_28_sg1_1 <= 10'b0;
      else_7_else_1_if_conc_2_tmp_mut_5_sg1 <= 10'b0;
      mut_31_sg1_1 <= 10'b0;
      else_7_else_1_if_conc_2_tmp_mut_8_sg1 <= 10'b0;
      mut_34_sg1_1 <= 10'b0;
      else_7_else_1_if_conc_2_tmp_mut_11_sg1 <= 10'b0;
      mut_37_sg1_1 <= 10'b0;
      else_7_else_1_if_conc_2_tmp_mut_14_sg1 <= 10'b0;
      else_7_else_1_if_div_4cyc_st_2 <= 2'b0;
      mut_16_sg1_1 <= 10'b0;
      else_7_else_1_else_conc_2_tmp_mut_5_sg1 <= 10'b0;
      mut_19_sg1_1 <= 10'b0;
      else_7_else_1_else_conc_2_tmp_mut_8_sg1 <= 10'b0;
      mut_22_sg1_1 <= 10'b0;
      else_7_else_1_else_conc_2_tmp_mut_11_sg1 <= 10'b0;
      mut_25_sg1_1 <= 10'b0;
      else_7_else_1_else_conc_2_tmp_mut_14_sg1 <= 10'b0;
      else_7_else_1_else_div_4cyc_st_2 <= 2'b0;
      else_7_else_1_equal_svs_st_2 <= 1'b0;
      else_7_equal_svs_st_2 <= 1'b0;
      acc_2_psp_sva_st_2 <= 10'b0;
      reg_div_mgc_div_13_b_cse <= 10'b0;
      reg_div_mgc_div_12_b_cse <= 10'b0;
      else_7_if_div_2cyc_st_1 <= 1'b0;
      mut_39_sg1_1 <= 10'b0;
      else_7_if_1_conc_2_tmp_mut_7_sg1 <= 10'b0;
      mut_42_sg1_1 <= 10'b0;
      else_7_if_1_conc_2_tmp_mut_10_sg1 <= 10'b0;
      mut_45_sg1_1 <= 10'b0;
      else_7_if_1_conc_2_tmp_mut_13_sg1 <= 10'b0;
      mut_12_sg1_1 <= 10'b0;
      else_7_if_1_conc_2_tmp_mut_4_sg1 <= 10'b0;
      else_7_if_1_div_4cyc_st_1 <= 2'b0;
      mut_27_sg1_1 <= 10'b0;
      else_7_else_1_if_conc_2_tmp_mut_4_sg1 <= 10'b0;
      mut_30_sg1_1 <= 10'b0;
      else_7_else_1_if_conc_2_tmp_mut_7_sg1 <= 10'b0;
      mut_33_sg1_1 <= 10'b0;
      else_7_else_1_if_conc_2_tmp_mut_10_sg1 <= 10'b0;
      mut_36_sg1_1 <= 10'b0;
      else_7_else_1_if_conc_2_tmp_mut_13_sg1 <= 10'b0;
      else_7_else_1_if_div_4cyc_st_1 <= 2'b0;
      mut_15_sg1_1 <= 10'b0;
      else_7_else_1_else_conc_2_tmp_mut_4_sg1 <= 10'b0;
      mut_18_sg1_1 <= 10'b0;
      else_7_else_1_else_conc_2_tmp_mut_7_sg1 <= 10'b0;
      mut_21_sg1_1 <= 10'b0;
      else_7_else_1_else_conc_2_tmp_mut_10_sg1 <= 10'b0;
      mut_24_sg1_1 <= 10'b0;
      else_7_else_1_else_conc_2_tmp_mut_13_sg1 <= 10'b0;
      else_7_else_1_else_div_4cyc_st_1 <= 2'b0;
      else_7_else_1_equal_svs_st_1 <= 1'b0;
      else_7_equal_svs_st_1 <= 1'b0;
      reg_max_sg1_lpi_dfm_3_st_1_cse <= 10'b0;
      acc_2_psp_sva_st_1 <= 10'b0;
      else_7_if_div_2cyc <= 1'b0;
      else_7_if_1_div_4cyc <= 2'b0;
      else_7_else_1_if_div_4cyc <= 2'b0;
      else_7_else_1_else_div_4cyc <= 2'b0;
      else_7_equal_svs <= 1'b0;
      unequal_tmp_1 <= 1'b0;
      main_stage_0_2 <= 1'b0;
      main_stage_0_3 <= 1'b0;
      main_stage_0_4 <= 1'b0;
      main_stage_0_5 <= 1'b0;
      s_sg1_1_sva_2_duc <= 18'b0;
      unequal_tmp_8 <= 1'b0;
      unequal_tmp_4 <= 1'b0;
      else_7_if_conc_1_tmp_mut_1_sg1 <= 10'b0;
      else_7_if_conc_1_tmp_mut_sg1 <= 10'b0;
      else_7_if_div_2cyc_st_2 <= 1'b0;
      max_sg1_lpi_dfm_3_st_2 <= 10'b0;
      acc_5_itm_3 <= 9'b0;
      else_7_and_5_itm_3 <= 1'b0;
      else_7_equal_svs_3 <= 1'b0;
      else_7_else_1_equal_svs_3 <= 1'b0;
      acc_5_itm_2 <= 9'b0;
      else_7_and_5_itm_2 <= 1'b0;
      else_7_equal_svs_2 <= 1'b0;
      unequal_tmp_7 <= 1'b0;
      unequal_tmp_3 <= 1'b0;
      else_7_else_1_equal_svs_2 <= 1'b0;
      acc_5_itm_1 <= 9'b0;
      else_7_and_5_itm_1 <= 1'b0;
      unequal_tmp_2 <= 1'b0;
      else_7_else_1_equal_svs_1 <= 1'b0;
      reg_h_sg1_6_sva_duc_tmp <= 1'b0;
      reg_h_sg1_6_sva_duc_tmp_7 <= 2'b0;
      reg_h_sg1_5_sva_duc_tmp_6 <= 3'b0;
      reg_div_mgc_div_9_b_tmp <= 10'b0;
      reg_div_mgc_div_9_a_tmp <= 10'b0;
      reg_div_mgc_div_10_b_tmp <= 10'b0;
      reg_div_mgc_div_10_a_tmp <= 10'b0;
      reg_div_mgc_div_11_b_tmp <= 10'b0;
      reg_div_mgc_div_11_a_tmp <= 10'b0;
      reg_div_mgc_div_b_tmp <= 10'b0;
      reg_div_mgc_div_a_tmp <= 10'b0;
      reg_div_mgc_div_5_b_tmp <= 10'b0;
      reg_div_mgc_div_5_a_tmp <= 10'b0;
      reg_div_mgc_div_6_b_tmp <= 10'b0;
      reg_div_mgc_div_6_a_tmp <= 10'b0;
      reg_div_mgc_div_7_b_tmp <= 10'b0;
      reg_div_mgc_div_7_a_tmp <= 10'b0;
      reg_div_mgc_div_8_b_tmp <= 10'b0;
      reg_div_mgc_div_8_a_tmp <= 10'b0;
      reg_div_mgc_div_1_b_tmp <= 10'b0;
      reg_div_mgc_div_1_a_tmp <= 10'b0;
      reg_div_mgc_div_2_b_tmp <= 10'b0;
      reg_div_mgc_div_2_a_tmp <= 10'b0;
      reg_div_mgc_div_3_b_tmp <= 10'b0;
      reg_div_mgc_div_3_a_tmp <= 10'b0;
      reg_div_mgc_div_4_b_tmp <= 10'b0;
      reg_div_mgc_div_4_a_tmp <= 10'b0;
    end
    else begin
      V_OUT_rsc_mgc_out_stdreg_d <= MUX_v_10_2_2({V_OUT_rsc_mgc_out_stdreg_d , ({1'b0
          , acc_5_itm_4})}, main_stage_0_5);
      S_OUT_rsc_mgc_out_stdreg_d <= MUX_v_10_2_2({S_OUT_rsc_mgc_out_stdreg_d , acc_4_itm_1},
          main_stage_0_5);
      H_OUT_rsc_mgc_out_stdreg_d <= MUX_v_10_2_2({H_OUT_rsc_mgc_out_stdreg_d , ({((MUX_v_7_2_2({(else_7_acc_psp_sva_1[8:2])
          , (({1'b1 , (else_7_acc_2_itm[8:3])}) + 7'b101101)}, else_7_acc_psp_sva_1[8]))
          & ({{6{unequal_tmp_5}}, unequal_tmp_5})) , ((else_7_acc_psp_sva_1[1:0])
          & ({{1{unequal_tmp_5}}, unequal_tmp_5})) , 1'b0})}, main_stage_0_5);
      else_7_acc_psp_sva <= MUX_v_9_2_2({else_7_acc_psp_sva , (else_7_acc_2_itm[9:1])},
          (~ and_1083_cse) & main_stage_0_5);
      h_sg1_4_sva_duc <= MUX1HOT_v_9_5_2({(div_mgc_div_9_z[8:0]) , (div_mgc_div_10_z[8:0])
          , (div_mgc_div_11_z[8:0]) , (div_mgc_div_z[8:0]) , h_sg1_4_sva_duc}, {(or_407_cse
          & and_dcpl_256 & (~((else_7_if_1_div_4cyc_st_4[1]) | (else_7_if_1_div_4cyc_st_4[0]))))
          , (or_407_cse & and_dcpl_256 & (~ (else_7_if_1_div_4cyc_st_4[1])) & (else_7_if_1_div_4cyc_st_4[0]))
          , (or_407_cse & and_dcpl_256 & (else_7_if_1_div_4cyc_st_4[1]) & (~ (else_7_if_1_div_4cyc_st_4[0])))
          , (or_407_cse & and_dcpl_256 & (else_7_if_1_div_4cyc_st_4[1]) & (else_7_if_1_div_4cyc_st_4[0]))
          , (and_1083_cse | (~(main_stage_0_5 & else_7_equal_svs_st_4)))});
      else_7_if_1_div_4cyc_st_4 <= else_7_if_1_div_4cyc_st_3;
      else_7_else_1_if_div_4cyc_st_4 <= else_7_else_1_if_div_4cyc_st_3;
      else_7_else_1_else_div_4cyc_st_4 <= else_7_else_1_else_div_4cyc_st_3;
      else_7_else_1_equal_svs_st_4 <= else_7_else_1_equal_svs_st_3;
      else_7_and_5_itm_4 <= else_7_and_5_itm_3;
      else_7_equal_svs_4 <= else_7_equal_svs_3;
      else_7_else_1_equal_svs_4 <= else_7_else_1_equal_svs_3;
      else_7_equal_svs_st_4 <= else_7_equal_svs_st_3;
      acc_5_itm_4 <= acc_5_itm_3;
      acc_4_itm_1 <= nl_acc_4_itm_1[9:0];
      unequal_tmp_5 <= unequal_tmp_4;
      acc_2_psp_sva_st_4 <= acc_2_psp_sva_st_3;
      else_7_if_div_2cyc_st_3 <= else_7_if_div_2cyc_st_2;
      mut_41_sg1_1 <= mut_40_sg1_1;
      else_7_if_1_conc_2_tmp_mut_9_sg1 <= else_7_if_1_conc_2_tmp_mut_8_sg1;
      mut_44_sg1_1 <= mut_43_sg1_1;
      else_7_if_1_conc_2_tmp_mut_12_sg1 <= else_7_if_1_conc_2_tmp_mut_11_sg1;
      mut_47_sg1_1 <= mut_46_sg1_1;
      else_7_if_1_conc_2_tmp_mut_15_sg1 <= else_7_if_1_conc_2_tmp_mut_14_sg1;
      mut_14_sg1_1 <= mut_13_sg1_1;
      else_7_if_1_conc_2_tmp_mut_6_sg1 <= else_7_if_1_conc_2_tmp_mut_5_sg1;
      else_7_if_1_div_4cyc_st_3 <= else_7_if_1_div_4cyc_st_2;
      mut_29_sg1_1 <= mut_28_sg1_1;
      else_7_else_1_if_conc_2_tmp_mut_6_sg1 <= else_7_else_1_if_conc_2_tmp_mut_5_sg1;
      mut_32_sg1_1 <= mut_31_sg1_1;
      else_7_else_1_if_conc_2_tmp_mut_9_sg1 <= else_7_else_1_if_conc_2_tmp_mut_8_sg1;
      mut_35_sg1_1 <= mut_34_sg1_1;
      else_7_else_1_if_conc_2_tmp_mut_12_sg1 <= else_7_else_1_if_conc_2_tmp_mut_11_sg1;
      mut_38_sg1_1 <= mut_37_sg1_1;
      else_7_else_1_if_conc_2_tmp_mut_15_sg1 <= else_7_else_1_if_conc_2_tmp_mut_14_sg1;
      else_7_else_1_if_div_4cyc_st_3 <= else_7_else_1_if_div_4cyc_st_2;
      mut_17_sg1_1 <= mut_16_sg1_1;
      else_7_else_1_else_conc_2_tmp_mut_6_sg1 <= else_7_else_1_else_conc_2_tmp_mut_5_sg1;
      mut_20_sg1_1 <= mut_19_sg1_1;
      else_7_else_1_else_conc_2_tmp_mut_9_sg1 <= else_7_else_1_else_conc_2_tmp_mut_8_sg1;
      mut_23_sg1_1 <= mut_22_sg1_1;
      else_7_else_1_else_conc_2_tmp_mut_12_sg1 <= else_7_else_1_else_conc_2_tmp_mut_11_sg1;
      mut_26_sg1_1 <= mut_25_sg1_1;
      else_7_else_1_else_conc_2_tmp_mut_15_sg1 <= else_7_else_1_else_conc_2_tmp_mut_14_sg1;
      else_7_else_1_else_div_4cyc_st_3 <= else_7_else_1_else_div_4cyc_st_2;
      else_7_else_1_equal_svs_st_3 <= else_7_else_1_equal_svs_st_2;
      else_7_equal_svs_st_3 <= else_7_equal_svs_st_2;
      max_sg1_lpi_dfm_3_st_3 <= max_sg1_lpi_dfm_3_st_2;
      acc_2_psp_sva_st_3 <= acc_2_psp_sva_st_2;
      mut_40_sg1_1 <= mut_39_sg1_1;
      else_7_if_1_conc_2_tmp_mut_8_sg1 <= else_7_if_1_conc_2_tmp_mut_7_sg1;
      mut_43_sg1_1 <= mut_42_sg1_1;
      else_7_if_1_conc_2_tmp_mut_11_sg1 <= else_7_if_1_conc_2_tmp_mut_10_sg1;
      mut_46_sg1_1 <= mut_45_sg1_1;
      else_7_if_1_conc_2_tmp_mut_14_sg1 <= else_7_if_1_conc_2_tmp_mut_13_sg1;
      mut_13_sg1_1 <= mut_12_sg1_1;
      else_7_if_1_conc_2_tmp_mut_5_sg1 <= else_7_if_1_conc_2_tmp_mut_4_sg1;
      else_7_if_1_div_4cyc_st_2 <= else_7_if_1_div_4cyc_st_1;
      mut_28_sg1_1 <= mut_27_sg1_1;
      else_7_else_1_if_conc_2_tmp_mut_5_sg1 <= else_7_else_1_if_conc_2_tmp_mut_4_sg1;
      mut_31_sg1_1 <= mut_30_sg1_1;
      else_7_else_1_if_conc_2_tmp_mut_8_sg1 <= else_7_else_1_if_conc_2_tmp_mut_7_sg1;
      mut_34_sg1_1 <= mut_33_sg1_1;
      else_7_else_1_if_conc_2_tmp_mut_11_sg1 <= else_7_else_1_if_conc_2_tmp_mut_10_sg1;
      mut_37_sg1_1 <= mut_36_sg1_1;
      else_7_else_1_if_conc_2_tmp_mut_14_sg1 <= else_7_else_1_if_conc_2_tmp_mut_13_sg1;
      else_7_else_1_if_div_4cyc_st_2 <= else_7_else_1_if_div_4cyc_st_1;
      mut_16_sg1_1 <= mut_15_sg1_1;
      else_7_else_1_else_conc_2_tmp_mut_5_sg1 <= else_7_else_1_else_conc_2_tmp_mut_4_sg1;
      mut_19_sg1_1 <= mut_18_sg1_1;
      else_7_else_1_else_conc_2_tmp_mut_8_sg1 <= else_7_else_1_else_conc_2_tmp_mut_7_sg1;
      mut_22_sg1_1 <= mut_21_sg1_1;
      else_7_else_1_else_conc_2_tmp_mut_11_sg1 <= else_7_else_1_else_conc_2_tmp_mut_10_sg1;
      mut_25_sg1_1 <= mut_24_sg1_1;
      else_7_else_1_else_conc_2_tmp_mut_14_sg1 <= else_7_else_1_else_conc_2_tmp_mut_13_sg1;
      else_7_else_1_else_div_4cyc_st_2 <= else_7_else_1_else_div_4cyc_st_1;
      else_7_else_1_equal_svs_st_2 <= else_7_else_1_equal_svs_st_1;
      else_7_equal_svs_st_2 <= else_7_equal_svs_st_1;
      acc_2_psp_sva_st_2 <= acc_2_psp_sva_st_1;
      reg_div_mgc_div_13_b_cse <= MUX_v_10_2_2({mux1h_32_tmp , reg_div_mgc_div_13_b_cse},
          or_dcpl_641);
      reg_div_mgc_div_12_b_cse <= MUX_v_10_2_2({mux1h_32_tmp , reg_div_mgc_div_12_b_cse},
          or_dcpl_643);
      else_7_if_div_2cyc_st_1 <= MUX_s_1_2_2({(~ else_7_if_div_2cyc) , else_7_if_div_2cyc_st_1},
          not_tmp_263);
      mut_39_sg1_1 <= MUX_v_10_2_2({(acc_itm[10:1]) , mut_39_sg1_1}, and_727_cse);
      else_7_if_1_conc_2_tmp_mut_7_sg1 <= MUX_v_10_2_2({(else_7_if_1_acc_1_itm[10:1])
          , else_7_if_1_conc_2_tmp_mut_7_sg1}, and_727_cse);
      mut_42_sg1_1 <= MUX_v_10_2_2({(acc_itm[10:1]) , mut_42_sg1_1}, and_727_cse);
      else_7_if_1_conc_2_tmp_mut_10_sg1 <= MUX_v_10_2_2({(else_7_if_1_acc_1_itm[10:1])
          , else_7_if_1_conc_2_tmp_mut_10_sg1}, and_727_cse);
      mut_45_sg1_1 <= MUX_v_10_2_2({(acc_itm[10:1]) , mut_45_sg1_1}, and_727_cse);
      else_7_if_1_conc_2_tmp_mut_13_sg1 <= MUX_v_10_2_2({(else_7_if_1_acc_1_itm[10:1])
          , else_7_if_1_conc_2_tmp_mut_13_sg1}, and_727_cse);
      mut_12_sg1_1 <= MUX_v_10_2_2({(acc_itm[10:1]) , mut_12_sg1_1}, and_727_cse);
      else_7_if_1_conc_2_tmp_mut_4_sg1 <= MUX_v_10_2_2({(else_7_if_1_acc_1_itm[10:1])
          , else_7_if_1_conc_2_tmp_mut_4_sg1}, and_727_cse);
      else_7_if_1_div_4cyc_st_1 <= MUX_v_2_2_2({else_7_if_1_acc_tmp , else_7_if_1_div_4cyc_st_1},
          and_727_cse);
      mut_27_sg1_1 <= MUX_v_10_2_2({(acc_itm[10:1]) , mut_27_sg1_1}, and_727_cse);
      else_7_else_1_if_conc_2_tmp_mut_4_sg1 <= MUX_v_10_2_2({(else_7_else_1_if_acc_2_itm[10:1])
          , else_7_else_1_if_conc_2_tmp_mut_4_sg1}, and_727_cse);
      mut_30_sg1_1 <= MUX_v_10_2_2({(acc_itm[10:1]) , mut_30_sg1_1}, and_727_cse);
      else_7_else_1_if_conc_2_tmp_mut_7_sg1 <= MUX_v_10_2_2({(else_7_else_1_if_acc_2_itm[10:1])
          , else_7_else_1_if_conc_2_tmp_mut_7_sg1}, and_727_cse);
      mut_33_sg1_1 <= MUX_v_10_2_2({(acc_itm[10:1]) , mut_33_sg1_1}, and_727_cse);
      else_7_else_1_if_conc_2_tmp_mut_10_sg1 <= MUX_v_10_2_2({(else_7_else_1_if_acc_2_itm[10:1])
          , else_7_else_1_if_conc_2_tmp_mut_10_sg1}, and_727_cse);
      mut_36_sg1_1 <= MUX_v_10_2_2({(acc_itm[10:1]) , mut_36_sg1_1}, and_727_cse);
      else_7_else_1_if_conc_2_tmp_mut_13_sg1 <= MUX_v_10_2_2({(else_7_else_1_if_acc_2_itm[10:1])
          , else_7_else_1_if_conc_2_tmp_mut_13_sg1}, and_727_cse);
      else_7_else_1_if_div_4cyc_st_1 <= MUX_v_2_2_2({else_7_else_1_if_acc_tmp , else_7_else_1_if_div_4cyc_st_1},
          and_727_cse);
      mut_15_sg1_1 <= MUX_v_10_2_2({(acc_itm[10:1]) , mut_15_sg1_1}, and_727_cse);
      else_7_else_1_else_conc_2_tmp_mut_4_sg1 <= MUX_v_10_2_2({(else_7_else_1_else_acc_2_itm[10:1])
          , else_7_else_1_else_conc_2_tmp_mut_4_sg1}, and_727_cse);
      mut_18_sg1_1 <= MUX_v_10_2_2({(acc_itm[10:1]) , mut_18_sg1_1}, and_727_cse);
      else_7_else_1_else_conc_2_tmp_mut_7_sg1 <= MUX_v_10_2_2({(else_7_else_1_else_acc_2_itm[10:1])
          , else_7_else_1_else_conc_2_tmp_mut_7_sg1}, and_727_cse);
      mut_21_sg1_1 <= MUX_v_10_2_2({(acc_itm[10:1]) , mut_21_sg1_1}, and_727_cse);
      else_7_else_1_else_conc_2_tmp_mut_10_sg1 <= MUX_v_10_2_2({(else_7_else_1_else_acc_2_itm[10:1])
          , else_7_else_1_else_conc_2_tmp_mut_10_sg1}, and_727_cse);
      mut_24_sg1_1 <= MUX_v_10_2_2({(acc_itm[10:1]) , mut_24_sg1_1}, and_727_cse);
      else_7_else_1_else_conc_2_tmp_mut_13_sg1 <= MUX_v_10_2_2({(else_7_else_1_else_acc_2_itm[10:1])
          , else_7_else_1_else_conc_2_tmp_mut_13_sg1}, and_727_cse);
      else_7_else_1_else_div_4cyc_st_1 <= MUX_v_2_2_2({else_7_else_1_else_acc_tmp
          , else_7_else_1_else_div_4cyc_st_1}, and_727_cse);
      else_7_else_1_equal_svs_st_1 <= MUX_s_1_2_2({else_7_else_1_equal_tmp , else_7_else_1_equal_svs_st_1},
          and_727_cse);
      else_7_equal_svs_st_1 <= MUX_s_1_2_2({else_7_equal_tmp , else_7_equal_svs_st_1},
          and_727_cse);
      reg_max_sg1_lpi_dfm_3_st_1_cse <= MUX_v_10_2_2({mux1h_32_tmp , reg_max_sg1_lpi_dfm_3_st_1_cse},
          and_727_cse);
      acc_2_psp_sva_st_1 <= acc_itm[10:1];
      else_7_if_div_2cyc <= MUX_s_1_2_2({(~ else_7_if_div_2cyc) , else_7_if_div_2cyc},
          not_tmp_263);
      else_7_if_1_div_4cyc <= MUX_v_2_2_2({else_7_if_1_acc_tmp , else_7_if_1_div_4cyc},
          ~((~(and_dcpl_688 & and_dcpl_686 & and_dcpl_684 & and_dcpl_682)) & else_7_equal_tmp));
      else_7_else_1_if_div_4cyc <= MUX_v_2_2_2({else_7_else_1_if_acc_tmp , else_7_else_1_if_div_4cyc},
          and_727_cse | else_7_equal_tmp | (~ else_7_else_1_equal_tmp));
      else_7_else_1_else_div_4cyc <= MUX_v_2_2_2({else_7_else_1_else_acc_tmp , else_7_else_1_else_div_4cyc},
          and_727_cse | else_7_equal_tmp | else_7_else_1_equal_tmp);
      else_7_equal_svs <= MUX_s_1_2_2({else_7_equal_tmp , else_7_equal_svs}, and_727_cse);
      unequal_tmp_1 <= MUX_s_1_2_2({unequal_tmp_9 , unequal_tmp_1}, and_727_cse);
      main_stage_0_2 <= 1'b1;
      main_stage_0_3 <= main_stage_0_2;
      main_stage_0_4 <= main_stage_0_3;
      main_stage_0_5 <= main_stage_0_4;
      s_sg1_1_sva_2_duc <= MUX1HOT_v_18_3_2({(div_mgc_div_13_z_oreg[17:0]) , (div_mgc_div_12_z_oreg[17:0])
          , s_sg1_1_sva_2_duc}, {(and_tmp_26 & main_stage_0_4 & (~ else_7_if_div_2cyc_st_3))
          , (and_tmp_26 & main_stage_0_4 & else_7_if_div_2cyc_st_3) , (~(and_tmp_26
          & main_stage_0_4))});
      unequal_tmp_8 <= unequal_tmp_7;
      unequal_tmp_4 <= unequal_tmp_3;
      else_7_if_conc_1_tmp_mut_1_sg1 <= MUX_v_10_2_2({(acc_itm[10:1]) , else_7_if_conc_1_tmp_mut_1_sg1},
          or_dcpl_641);
      else_7_if_conc_1_tmp_mut_sg1 <= MUX_v_10_2_2({(acc_itm[10:1]) , else_7_if_conc_1_tmp_mut_sg1},
          or_dcpl_643);
      else_7_if_div_2cyc_st_2 <= else_7_if_div_2cyc_st_1;
      max_sg1_lpi_dfm_3_st_2 <= reg_max_sg1_lpi_dfm_3_st_1_cse;
      acc_5_itm_3 <= acc_5_itm_2;
      else_7_and_5_itm_3 <= else_7_and_5_itm_2;
      else_7_equal_svs_3 <= else_7_equal_svs_2;
      else_7_else_1_equal_svs_3 <= else_7_else_1_equal_svs_2;
      acc_5_itm_2 <= acc_5_itm_1;
      else_7_and_5_itm_2 <= else_7_and_5_itm_1;
      else_7_equal_svs_2 <= else_7_equal_svs;
      unequal_tmp_7 <= unequal_tmp_1;
      unequal_tmp_3 <= unequal_tmp_2;
      else_7_else_1_equal_svs_2 <= else_7_else_1_equal_svs_1;
      acc_5_itm_1 <= nl_acc_5_itm_1[8:0];
      else_7_and_5_itm_1 <= MUX_s_1_2_2({(else_7_else_1_equal_tmp & (~ else_7_equal_tmp))
          , else_7_and_5_itm_1}, and_727_cse);
      unequal_tmp_2 <= or_cse;
      else_7_else_1_equal_svs_1 <= else_7_else_1_equal_tmp;
      reg_h_sg1_6_sva_duc_tmp <= 1'b0;
      reg_h_sg1_6_sva_duc_tmp_7 <= MUX1HOT_v_2_5_2({(div_mgc_div_5_z[1:0]) , (div_mgc_div_6_z[1:0])
          , (div_mgc_div_7_z[1:0]) , (div_mgc_div_8_z[1:0]) , reg_h_sg1_6_sva_duc_tmp_7},
          {(or_407_cse & and_dcpl_298 & and_dcpl_280) , (or_407_cse & and_dcpl_298
          & and_dcpl_283) , (or_407_cse & and_dcpl_298 & and_dcpl_286) , (or_407_cse
          & and_dcpl_298 & and_dcpl_289) , (and_1083_cse | or_dcpl_382 | (~ else_7_else_1_equal_svs_st_4))});
      reg_h_sg1_5_sva_duc_tmp_6 <= MUX1HOT_v_3_5_2({(div_mgc_div_1_z[2:0]) , (div_mgc_div_2_z[2:0])
          , (div_mgc_div_3_z[2:0]) , (div_mgc_div_4_z[2:0]) , reg_h_sg1_5_sva_duc_tmp_6},
          {(or_407_cse & and_dcpl_343 & and_dcpl_325) , (or_407_cse & and_dcpl_343
          & and_dcpl_328) , (or_407_cse & and_dcpl_343 & and_dcpl_331) , (or_407_cse
          & and_dcpl_343 & and_dcpl_334) , (and_1083_cse | or_dcpl_382 | else_7_else_1_equal_svs_st_4)});
      reg_div_mgc_div_9_b_tmp <= MUX1HOT_v_10_4_2({(acc_itm[10:1]) , mut_39_sg1_1
          , mut_40_sg1_1 , mut_41_sg1_1}, {and_384_cse , and_388_cse , and_393_cse
          , mux_81_cse});
      reg_div_mgc_div_9_a_tmp <= MUX1HOT_v_10_4_2({(else_7_if_1_acc_1_itm[10:1])
          , else_7_if_1_conc_2_tmp_mut_7_sg1 , else_7_if_1_conc_2_tmp_mut_8_sg1 ,
          else_7_if_1_conc_2_tmp_mut_9_sg1}, {and_384_cse , and_388_cse , and_393_cse
          , mux_81_cse});
      reg_div_mgc_div_10_b_tmp <= MUX1HOT_v_10_4_2({(acc_itm[10:1]) , mut_42_sg1_1
          , mut_43_sg1_1 , mut_44_sg1_1}, {and_410_cse , and_414_cse , and_419_cse
          , mux_91_cse});
      reg_div_mgc_div_10_a_tmp <= MUX1HOT_v_10_4_2({(else_7_if_1_acc_1_itm[10:1])
          , else_7_if_1_conc_2_tmp_mut_10_sg1 , else_7_if_1_conc_2_tmp_mut_11_sg1
          , else_7_if_1_conc_2_tmp_mut_12_sg1}, {and_410_cse , and_414_cse , and_419_cse
          , mux_91_cse});
      reg_div_mgc_div_11_b_tmp <= MUX1HOT_v_10_4_2({(acc_itm[10:1]) , mut_45_sg1_1
          , mut_46_sg1_1 , mut_47_sg1_1}, {and_436_cse , and_440_cse , and_444_cse
          , mux_102_cse});
      reg_div_mgc_div_11_a_tmp <= MUX1HOT_v_10_4_2({(else_7_if_1_acc_1_itm[10:1])
          , else_7_if_1_conc_2_tmp_mut_13_sg1 , else_7_if_1_conc_2_tmp_mut_14_sg1
          , else_7_if_1_conc_2_tmp_mut_15_sg1}, {and_436_cse , and_440_cse , and_444_cse
          , mux_102_cse});
      reg_div_mgc_div_b_tmp <= MUX1HOT_v_10_4_2({(acc_itm[10:1]) , mut_12_sg1_1 ,
          mut_13_sg1_1 , mut_14_sg1_1}, {and_458_cse , and_462_cse , and_466_cse
          , (~ mux_111_cse)});
      reg_div_mgc_div_a_tmp <= MUX1HOT_v_10_4_2({(else_7_if_1_acc_1_itm[10:1]) ,
          else_7_if_1_conc_2_tmp_mut_4_sg1 , else_7_if_1_conc_2_tmp_mut_5_sg1 , else_7_if_1_conc_2_tmp_mut_6_sg1},
          {and_458_cse , and_462_cse , and_466_cse , (~ mux_111_cse)});
      reg_div_mgc_div_5_b_tmp <= MUX1HOT_v_10_4_2({(acc_itm[10:1]) , mut_27_sg1_1
          , mut_28_sg1_1 , mut_29_sg1_1}, {and_481_cse , and_486_cse , and_492_cse
          , mux_116_cse});
      reg_div_mgc_div_5_a_tmp <= MUX1HOT_v_10_4_2({(else_7_else_1_if_acc_2_itm[10:1])
          , else_7_else_1_if_conc_2_tmp_mut_4_sg1 , else_7_else_1_if_conc_2_tmp_mut_5_sg1
          , else_7_else_1_if_conc_2_tmp_mut_6_sg1}, {and_481_cse , and_486_cse ,
          and_492_cse , mux_116_cse});
      reg_div_mgc_div_6_b_tmp <= MUX1HOT_v_10_4_2({(acc_itm[10:1]) , mut_30_sg1_1
          , mut_31_sg1_1 , mut_32_sg1_1}, {and_513_cse , and_518_cse , and_524_cse
          , mux_121_cse});
      reg_div_mgc_div_6_a_tmp <= MUX1HOT_v_10_4_2({(else_7_else_1_if_acc_2_itm[10:1])
          , else_7_else_1_if_conc_2_tmp_mut_7_sg1 , else_7_else_1_if_conc_2_tmp_mut_8_sg1
          , else_7_else_1_if_conc_2_tmp_mut_9_sg1}, {and_513_cse , and_518_cse ,
          and_524_cse , mux_121_cse});
      reg_div_mgc_div_7_b_tmp <= MUX1HOT_v_10_4_2({(acc_itm[10:1]) , mut_33_sg1_1
          , mut_34_sg1_1 , mut_35_sg1_1}, {and_545_cse , and_550_cse , and_555_cse
          , mux_128_cse});
      reg_div_mgc_div_7_a_tmp <= MUX1HOT_v_10_4_2({(else_7_else_1_if_acc_2_itm[10:1])
          , else_7_else_1_if_conc_2_tmp_mut_10_sg1 , else_7_else_1_if_conc_2_tmp_mut_11_sg1
          , else_7_else_1_if_conc_2_tmp_mut_12_sg1}, {and_545_cse , and_550_cse ,
          and_555_cse , mux_128_cse});
      reg_div_mgc_div_8_b_tmp <= MUX1HOT_v_10_4_2({(acc_itm[10:1]) , mut_36_sg1_1
          , mut_37_sg1_1 , mut_38_sg1_1}, {and_573_cse , and_578_cse , and_583_cse
          , mux_137_cse});
      reg_div_mgc_div_8_a_tmp <= MUX1HOT_v_10_4_2({(else_7_else_1_if_acc_2_itm[10:1])
          , else_7_else_1_if_conc_2_tmp_mut_13_sg1 , else_7_else_1_if_conc_2_tmp_mut_14_sg1
          , else_7_else_1_if_conc_2_tmp_mut_15_sg1}, {and_573_cse , and_578_cse ,
          and_583_cse , mux_137_cse});
      reg_div_mgc_div_1_b_tmp <= MUX1HOT_v_10_4_2({(acc_itm[10:1]) , mut_15_sg1_1
          , mut_16_sg1_1 , mut_17_sg1_1}, {and_601_cse , and_606_cse , and_612_cse
          , mux_144_cse});
      reg_div_mgc_div_1_a_tmp <= MUX1HOT_v_10_4_2({(else_7_else_1_else_acc_2_itm[10:1])
          , else_7_else_1_else_conc_2_tmp_mut_4_sg1 , else_7_else_1_else_conc_2_tmp_mut_5_sg1
          , else_7_else_1_else_conc_2_tmp_mut_6_sg1}, {and_601_cse , and_606_cse
          , and_612_cse , mux_144_cse});
      reg_div_mgc_div_2_b_tmp <= MUX1HOT_v_10_4_2({(acc_itm[10:1]) , mut_18_sg1_1
          , mut_19_sg1_1 , mut_20_sg1_1}, {and_633_cse , and_638_cse , and_644_cse
          , mux_149_cse});
      reg_div_mgc_div_2_a_tmp <= MUX1HOT_v_10_4_2({(else_7_else_1_else_acc_2_itm[10:1])
          , else_7_else_1_else_conc_2_tmp_mut_7_sg1 , else_7_else_1_else_conc_2_tmp_mut_8_sg1
          , else_7_else_1_else_conc_2_tmp_mut_9_sg1}, {and_633_cse , and_638_cse
          , and_644_cse , mux_149_cse});
      reg_div_mgc_div_3_b_tmp <= MUX1HOT_v_10_4_2({(acc_itm[10:1]) , mut_21_sg1_1
          , mut_22_sg1_1 , mut_23_sg1_1}, {and_665_cse , and_670_cse , and_675_cse
          , mux_156_cse});
      reg_div_mgc_div_3_a_tmp <= MUX1HOT_v_10_4_2({(else_7_else_1_else_acc_2_itm[10:1])
          , else_7_else_1_else_conc_2_tmp_mut_10_sg1 , else_7_else_1_else_conc_2_tmp_mut_11_sg1
          , else_7_else_1_else_conc_2_tmp_mut_12_sg1}, {and_665_cse , and_670_cse
          , and_675_cse , mux_156_cse});
      reg_div_mgc_div_4_b_tmp <= MUX1HOT_v_10_4_2({(acc_itm[10:1]) , mut_24_sg1_1
          , mut_25_sg1_1 , mut_26_sg1_1}, {and_693_cse , and_698_cse , and_703_cse
          , mux_165_cse});
      reg_div_mgc_div_4_a_tmp <= MUX1HOT_v_10_4_2({(else_7_else_1_else_acc_2_itm[10:1])
          , else_7_else_1_else_conc_2_tmp_mut_13_sg1 , else_7_else_1_else_conc_2_tmp_mut_14_sg1
          , else_7_else_1_else_conc_2_tmp_mut_15_sg1}, {and_693_cse , and_698_cse
          , and_703_cse , mux_165_cse});
    end
  end
  assign nl_acc_4_itm_1  = (mul_1_itm[17:8]) + conv_u2u_1_10(mul_1_itm[7]);
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


  function [5:0] MUX1HOT_v_6_4_2;
    input [23:0] inputs;
    input [3:0] sel;
    reg [5:0] result;
    integer i;
  begin
    result = inputs[0+:6] & {6{sel[0]}};
    for( i = 1; i < 4; i = i + 1 )
      result = result | (inputs[i*6+:6] & {6{sel[i]}});
    MUX1HOT_v_6_4_2 = result;
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


  function [0:0] MUX1HOT_s_1_3_2;
    input [2:0] inputs;
    input [2:0] sel;
    reg [0:0] result;
    integer i;
  begin
    result = inputs[0+:1] & {1{sel[0]}};
    for( i = 1; i < 3; i = i + 1 )
      result = result | (inputs[i*1+:1] & {1{sel[i]}});
    MUX1HOT_s_1_3_2 = result;
  end
  endfunction


  function [1:0] MUX1HOT_v_2_7_2;
    input [13:0] inputs;
    input [6:0] sel;
    reg [1:0] result;
    integer i;
  begin
    result = inputs[0+:2] & {2{sel[0]}};
    for( i = 1; i < 7; i = i + 1 )
      result = result | (inputs[i*2+:2] & {2{sel[i]}});
    MUX1HOT_v_2_7_2 = result;
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


  function [17:0] MUX1HOT_v_18_3_2;
    input [53:0] inputs;
    input [2:0] sel;
    reg [17:0] result;
    integer i;
  begin
    result = inputs[0+:18] & {18{sel[0]}};
    for( i = 1; i < 3; i = i + 1 )
      result = result | (inputs[i*18+:18] & {18{sel[i]}});
    MUX1HOT_v_18_3_2 = result;
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


  function [2:0] MUX1HOT_v_3_5_2;
    input [14:0] inputs;
    input [4:0] sel;
    reg [2:0] result;
    integer i;
  begin
    result = inputs[0+:3] & {3{sel[0]}};
    for( i = 1; i < 5; i = i + 1 )
      result = result | (inputs[i*3+:3] & {3{sel[i]}});
    MUX1HOT_v_3_5_2 = result;
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


  function  [11:0] conv_u2u_11_12 ;
    input [10:0]  vector ;
  begin
    conv_u2u_11_12 = {1'b0, vector};
  end
  endfunction


  function  [13:0] conv_u2u_10_14 ;
    input [9:0]  vector ;
  begin
    conv_u2u_10_14 = {{4{1'b0}}, vector};
  end
  endfunction


  function  [9:0] conv_u2u_1_10 ;
    input [0:0]  vector ;
  begin
    conv_u2u_1_10 = {{9{1'b0}}, vector};
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
  wire [9:0] S_OUT_rsc_mgc_out_stdreg_d;
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
  wire [19:0] div_mgc_div_12_a;
  wire [9:0] div_mgc_div_12_b;
  wire [19:0] div_mgc_div_12_z;
  reg [19:0] div_mgc_div_12_z_oreg;
  wire [19:0] div_mgc_div_13_a;
  wire [9:0] div_mgc_div_13_b;
  wire [19:0] div_mgc_div_13_z;
  reg [19:0] div_mgc_div_13_z_oreg;


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
  mgc_div #(.width_a(20),
  .width_b(10),
  .signd(0)) div_mgc_div_12 (
      .a(div_mgc_div_12_a),
      .b(div_mgc_div_12_b),
      .z(div_mgc_div_12_z)
    );
  mgc_div #(.width_a(20),
  .width_b(10),
  .signd(0)) div_mgc_div_13 (
      .a(div_mgc_div_13_a),
      .b(div_mgc_div_13_b),
      .z(div_mgc_div_13_z)
    );
  HSVRGB_core HSVRGB_core_inst (
      .clk(clk),
      .arst_n(arst_n),
      .r_rsc_mgc_in_wire_d(r_rsc_mgc_in_wire_d),
      .g_rsc_mgc_in_wire_d(g_rsc_mgc_in_wire_d),
      .b_rsc_mgc_in_wire_d(b_rsc_mgc_in_wire_d),
      .H_OUT_rsc_mgc_out_stdreg_d(H_OUT_rsc_mgc_out_stdreg_d),
      .S_OUT_rsc_mgc_out_stdreg_d(S_OUT_rsc_mgc_out_stdreg_d),
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
      .div_mgc_div_11_z(div_mgc_div_11_z),
      .div_mgc_div_12_a(div_mgc_div_12_a),
      .div_mgc_div_12_b(div_mgc_div_12_b),
      .div_mgc_div_12_z_oreg(div_mgc_div_12_z_oreg),
      .div_mgc_div_13_a(div_mgc_div_13_a),
      .div_mgc_div_13_b(div_mgc_div_13_b),
      .div_mgc_div_13_z_oreg(div_mgc_div_13_z_oreg)
    );
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      div_mgc_div_12_z_oreg <= 20'b0;
      div_mgc_div_13_z_oreg <= 20'b0;
    end
    else begin
      div_mgc_div_12_z_oreg <= div_mgc_div_12_z;
      div_mgc_div_13_z_oreg <= div_mgc_div_13_z;
    end
  end
endmodule



