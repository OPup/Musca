
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
//  Generated date: Thu Apr 28 16:01:11 2016
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
      div_mgc_div_10_z
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
  output [15:0] div_mgc_div_a;
  output [15:0] div_mgc_div_b;
  input [15:0] div_mgc_div_z;
  output [15:0] div_mgc_div_1_a;
  output [15:0] div_mgc_div_1_b;
  input [15:0] div_mgc_div_1_z;
  output [15:0] div_mgc_div_2_a;
  output [15:0] div_mgc_div_2_b;
  input [15:0] div_mgc_div_2_z;
  output [15:0] div_mgc_div_3_a;
  output [15:0] div_mgc_div_3_b;
  input [15:0] div_mgc_div_3_z;
  output [15:0] div_mgc_div_4_a;
  output [15:0] div_mgc_div_4_b;
  input [15:0] div_mgc_div_4_z;
  output [15:0] div_mgc_div_5_a;
  output [15:0] div_mgc_div_5_b;
  input [15:0] div_mgc_div_5_z;
  output [15:0] div_mgc_div_6_a;
  output [15:0] div_mgc_div_6_b;
  input [15:0] div_mgc_div_6_z;
  output [15:0] div_mgc_div_7_a;
  output [15:0] div_mgc_div_7_b;
  input [15:0] div_mgc_div_7_z;
  output [15:0] div_mgc_div_8_a;
  output [15:0] div_mgc_div_8_b;
  input [15:0] div_mgc_div_8_z;
  output [14:0] div_mgc_div_9_a;
  output [9:0] div_mgc_div_9_b;
  input [14:0] div_mgc_div_9_z;
  output [14:0] div_mgc_div_10_a;
  output [9:0] div_mgc_div_10_b;
  input [14:0] div_mgc_div_10_z;


  // Interconnect Declarations
  wire [1:0] else_7_if_1_acc_tmp;
  wire [2:0] nl_else_7_if_1_acc_tmp;
  wire [1:0] else_7_else_1_if_acc_tmp;
  wire [2:0] nl_else_7_else_1_if_acc_tmp;
  wire [1:0] else_7_else_1_else_acc_tmp;
  wire [2:0] nl_else_7_else_1_else_acc_tmp;
  wire else_7_else_1_equal_tmp;
  wire else_7_equal_tmp;
  wire [9:0] mux1h_26_tmp;
  wire or_tmp_1;
  wire and_dcpl_25;
  wire and_dcpl_50;
  wire and_dcpl_116;
  wire and_dcpl_118;
  wire and_dcpl_120;
  wire and_dcpl_122;
  wire and_dcpl_134;
  wire and_dcpl_140;
  wire and_dcpl_142;
  wire and_dcpl_163;
  wire and_dcpl_164;
  wire and_dcpl_166;
  wire and_dcpl_169;
  wire and_dcpl_172;
  wire and_dcpl_178;
  wire and_dcpl_179;
  wire or_dcpl_314;
  wire and_dcpl_202;
  wire and_dcpl_203;
  wire and_dcpl_205;
  wire and_dcpl_208;
  wire and_dcpl_211;
  wire and_dcpl_218;
  wire and_dcpl_241;
  wire or_tmp_76;
  wire or_tmp_80;
  wire or_tmp_91;
  wire or_tmp_102;
  wire and_dcpl_284;
  wire and_dcpl_338;
  wire or_tmp_142;
  wire or_tmp_153;
  wire or_tmp_165;
  wire not_tmp_125;
  wire or_dcpl_513;
  wire or_dcpl_515;
  wire and_dcpl_391;
  wire and_dcpl_393;
  wire and_dcpl_395;
  wire and_dcpl_397;
  wire or_dcpl_522;
  wire or_dcpl_524;
  wire or_dcpl_526;
  wire or_dcpl_528;
  wire and_tmp_9;
  reg unequal_tmp_1;
  reg else_7_equal_svs;
  reg [7:0] else_7_acc_psp_sva;
  reg else_7_if_div_2cyc;
  reg [9:0] s_sg1_1_sva_2_duc;
  reg [1:0] else_7_if_1_div_3cyc;
  reg [7:0] h_sg1_4_sva_duc;
  reg [1:0] else_7_else_1_if_div_3cyc;
  reg [7:0] h_sg1_6_sva_duc;
  reg [1:0] else_7_else_1_else_div_3cyc;
  reg [7:0] h_sg1_5_sva_duc;
  reg else_7_else_1_equal_svs_1;
  reg else_7_else_1_equal_svs_2;
  reg else_7_else_1_equal_svs_3;
  reg unequal_tmp_2;
  reg unequal_tmp_3;
  reg unequal_tmp_4;
  reg unequal_tmp_6;
  reg else_7_equal_svs_2;
  reg else_7_equal_svs_3;
  reg else_7_and_5_itm_1;
  reg else_7_and_5_itm_2;
  reg else_7_and_5_itm_3;
  reg [7:0] acc_4_itm_1;
  wire [8:0] nl_acc_4_itm_1;
  reg [7:0] acc_5_itm_1;
  wire [8:0] nl_acc_5_itm_1;
  reg [7:0] acc_5_itm_2;
  reg [7:0] acc_5_itm_3;
  reg [9:0] acc_2_psp_sva_st_1;
  reg [9:0] max_sg1_lpi_dfm_3_st_1;
  reg else_7_if_div_2cyc_st_1;
  reg [9:0] acc_2_psp_sva_st_2;
  reg [9:0] max_sg1_lpi_dfm_3_st_2;
  reg else_7_if_div_2cyc_st_2;
  reg else_7_equal_svs_st_1;
  reg else_7_equal_svs_st_2;
  reg [1:0] else_7_if_1_div_3cyc_st_1;
  reg [1:0] else_7_if_1_div_3cyc_st_2;
  reg [9:0] acc_2_psp_sva_st_3;
  reg else_7_equal_svs_st_3;
  reg [1:0] else_7_if_1_div_3cyc_st_3;
  reg else_7_else_1_equal_svs_st_1;
  reg else_7_else_1_equal_svs_st_2;
  reg [1:0] else_7_else_1_if_div_3cyc_st_1;
  reg [1:0] else_7_else_1_if_div_3cyc_st_2;
  reg else_7_else_1_equal_svs_st_3;
  reg [1:0] else_7_else_1_if_div_3cyc_st_3;
  reg [1:0] else_7_else_1_else_div_3cyc_st_1;
  reg [1:0] else_7_else_1_else_div_3cyc_st_2;
  reg [1:0] else_7_else_1_else_div_3cyc_st_3;
  reg main_stage_0_2;
  reg main_stage_0_3;
  reg main_stage_0_4;
  reg [9:0] else_7_if_conc_1_tmp_mut_sg1;
  reg [9:0] else_7_if_conc_1_tmp_mut_1_sg1;
  reg [7:0] mut_18_sg1_1;
  reg [7:0] mut_19_sg1_1;
  reg [9:0] mut_20_sg1_1;
  reg [9:0] mut_21_sg1_1;
  reg [7:0] mut_22_sg1_1;
  reg [7:0] mut_23_sg1_1;
  reg [9:0] mut_24_sg1_1;
  reg [9:0] mut_25_sg1_1;
  reg [7:0] mut_26_sg1_1;
  reg [7:0] mut_27_sg1_1;
  reg [9:0] mut_28_sg1_1;
  reg [9:0] mut_29_sg1_1;
  reg [7:0] mut_30_sg1_1;
  reg [7:0] mut_31_sg1_1;
  reg [9:0] mut_32_sg1_1;
  reg [9:0] mut_33_sg1_1;
  reg [7:0] mut_34_sg1_1;
  reg [7:0] mut_35_sg1_1;
  reg [9:0] mut_36_sg1_1;
  reg [9:0] mut_37_sg1_1;
  reg [7:0] mut_38_sg1_1;
  reg [7:0] mut_39_sg1_1;
  reg [9:0] mut_40_sg1_1;
  reg [9:0] mut_41_sg1_1;
  reg [7:0] mut_42_sg1_1;
  reg [7:0] mut_43_sg1_1;
  reg [9:0] mut_44_sg1_1;
  reg [9:0] mut_45_sg1_1;
  reg [7:0] mut_46_sg1_1;
  reg [7:0] mut_47_sg1_1;
  reg [9:0] mut_48_sg1_1;
  reg [9:0] mut_49_sg1_1;
  reg [7:0] mut_50_sg1_1;
  reg [7:0] mut_51_sg1_1;
  reg [9:0] mut_52_sg1_1;
  reg [9:0] mut_53_sg1_1;
  wire [4:0] h_sg1_4_lpi_dfm_1_sg2_1;
  wire h_sg1_4_lpi_dfm_1_sg1_1;
  wire [1:0] h_sg1_4_lpi_dfm_4;
  wire or_339_cse;
  wire and_175_cse;
  wire and_256_cse;
  wire and_260_cse;
  wire or_435_cse;
  wire and_274_cse;
  wire and_288_cse;
  wire and_304_cse;
  wire and_305_cse;
  wire and_324_cse;
  wire and_325_cse;
  wire and_344_cse;
  wire and_345_cse;
  wire and_364_cse;
  wire and_382_cse;
  wire and_400_cse;
  wire and_419_cse;
  reg [9:0] reg_div_mgc_div_10_b_cse;
  reg [9:0] reg_div_mgc_div_9_b_cse;
  reg [9:0] reg_div_mgc_div_7_b_tmp;
  reg [9:0] reg_div_mgc_div_8_b_tmp;
  reg [9:0] reg_div_mgc_div_b_tmp;
  reg [9:0] reg_div_mgc_div_4_b_tmp;
  reg [9:0] reg_div_mgc_div_5_b_tmp;
  reg [9:0] reg_div_mgc_div_6_b_tmp;
  reg [9:0] reg_div_mgc_div_1_b_tmp;
  reg [9:0] reg_div_mgc_div_2_b_tmp;
  reg [9:0] reg_div_mgc_div_3_b_tmp;
  wire mux_68_cse;
  wire and_270_cse;
  wire and_284_cse;
  wire mux_75_cse;
  wire and_299_cse;
  wire and_319_cse;
  wire and_339_cse;
  wire and_359_cse;
  wire mux_81_cse;
  wire and_377_cse;
  wire mux_84_cse;
  wire and_395_cse;
  wire mux_87_cse;
  wire and_92_cse;
  wire and_124_cse;
  reg [7:0] reg_div_mgc_div_7_a_reg;
  reg [7:0] reg_div_mgc_div_8_a_reg;
  reg [7:0] reg_div_mgc_div_a_reg;
  reg [7:0] reg_div_mgc_div_4_a_reg;
  reg [7:0] reg_div_mgc_div_5_a_reg;
  reg [7:0] reg_div_mgc_div_6_a_reg;
  reg [7:0] reg_div_mgc_div_1_a_reg;
  reg [7:0] reg_div_mgc_div_2_a_reg;
  reg [7:0] reg_div_mgc_div_3_a_reg;
  wire mux_72_cse;
  wire [10:0] acc_itm;
  wire [11:0] nl_acc_itm;
  wire [7:0] else_7_acc_psp_sva_mx0;
  wire [7:0] h_sg1_4_sva_duc_mx0;
  wire [5:0] h_sg1_4_sva_1_sg1;
  wire [6:0] nl_h_sg1_4_sva_1_sg1;
  wire [7:0] h_sg1_5_sva_duc_mx0;
  wire else_7_nor_ssc;
  wire [1:0] acc_imod;
  wire [2:0] nl_acc_imod;
  wire [1:0] else_7_if_1_acc_idiv;
  wire [2:0] nl_else_7_if_1_acc_idiv;
  wire [9:0] g_1_lpi_dfm;
  wire [7:0] b_1_lpi_dfm_2;
  wire [1:0] acc_imod_1;
  wire [2:0] nl_acc_imod_1;
  wire [1:0] else_7_else_1_if_acc_idiv;
  wire [2:0] nl_else_7_else_1_if_acc_idiv;
  wire [9:0] r_1_lpi_dfm;
  wire [1:0] acc_imod_2;
  wire [2:0] nl_acc_imod_2;
  wire [1:0] else_7_else_1_else_acc_idiv;
  wire [2:0] nl_else_7_else_1_else_acc_idiv;
  wire unequal_tmp_7;
  wire or_cse;
  wire [8:0] else_7_acc_2_itm;
  wire [9:0] nl_else_7_acc_2_itm;
  wire [11:0] if_if_acc_itm;
  wire [12:0] nl_if_if_acc_itm;
  wire [11:0] else_1_if_acc_itm;
  wire [12:0] nl_else_1_if_acc_itm;
  wire [11:0] if_3_if_acc_itm;
  wire [12:0] nl_if_3_if_acc_itm;
  wire [11:0] else_5_if_acc_itm;
  wire [12:0] nl_else_5_if_acc_itm;
  wire [8:0] else_7_if_1_acc_1_itm;
  wire [9:0] nl_else_7_if_1_acc_1_itm;
  wire [8:0] else_7_else_1_if_acc_2_itm;
  wire [9:0] nl_else_7_else_1_if_acc_2_itm;
  wire [8:0] else_7_else_1_else_acc_2_itm;
  wire [9:0] nl_else_7_else_1_else_acc_2_itm;
  wire [11:0] if_3_acc_1_itm;
  wire [12:0] nl_if_3_acc_1_itm;
  wire [11:0] if_acc_1_itm;
  wire [12:0] nl_if_acc_1_itm;
  wire [9:0] mul_1_itm;
  wire [19:0] nl_mul_1_itm;
  wire [12:0] mul_itm;
  wire [25:0] nl_mul_itm;

  wire[0:0] mux_67_nl;
  wire[0:0] mux_89_nl;
  wire[0:0] mux_70_nl;
  wire[0:0] mux_66_nl;
  wire[0:0] mux_74_nl;
  wire[0:0] mux_73_nl;
  wire[0:0] mux_77_nl;
  wire[0:0] mux_78_nl;
  wire[0:0] mux_79_nl;
  wire[0:0] mux_80_nl;
  wire[0:0] mux_83_nl;
  wire[0:0] mux_86_nl;
  wire[5:0] mux1h_3_nl;
  wire[4:0] mux1h_6_nl;
  wire[9:0] mux1h_27_nl;
  wire[9:0] mux1h_28_nl;

  // Interconnect Declarations for Component Instantiations 
  assign or_339_cse = (acc_2_psp_sva_st_3[9]) | (acc_2_psp_sva_st_3[8]) | (acc_2_psp_sva_st_3[7])
      | (acc_2_psp_sva_st_3[6]) | (acc_2_psp_sva_st_3[5]) | (acc_2_psp_sva_st_3[4])
      | (acc_2_psp_sva_st_3[3]) | (acc_2_psp_sva_st_3[2]) | (acc_2_psp_sva_st_3[1])
      | (acc_2_psp_sva_st_3[0]);
  assign and_175_cse = and_dcpl_122 & and_dcpl_120 & and_dcpl_118 & and_dcpl_116;
  assign or_435_cse = (acc_itm[1]) | (acc_itm[2]) | (acc_itm[3]) | (acc_itm[4]) |
      (acc_itm[5]) | (acc_itm[6]) | (acc_itm[7]) | (acc_itm[8]) | (acc_itm[9]) |
      (acc_itm[10]);
  assign and_256_cse = or_435_cse & and_dcpl_241 & (~ (else_7_if_1_acc_tmp[0]));
  assign mux_89_nl = MUX_s_1_2_2({or_tmp_1 , (~ or_tmp_76)}, else_7_equal_tmp);
  assign mux_67_nl = MUX_s_1_2_2({(mux_89_nl) , or_tmp_1}, (else_7_if_1_acc_tmp[0])
      | (else_7_if_1_acc_tmp[1]));
  assign and_260_cse = (mux_67_nl) & and_dcpl_25 & (~((else_7_if_1_div_3cyc_st_1[1])
      | (else_7_if_1_div_3cyc_st_1[0])));
  assign mux_68_cse = MUX_s_1_2_2({(~(else_7_equal_tmp | (~ or_tmp_80))) , or_tmp_80},
      (~ or_cse) | (else_7_if_1_acc_tmp[1]) | (else_7_if_1_acc_tmp[0]));
  assign div_mgc_div_7_b = {1'b0, {reg_div_mgc_div_7_b_tmp , 5'b0}};
  assign div_mgc_div_7_a = {({{2{reg_div_mgc_div_7_a_reg[7]}}, reg_div_mgc_div_7_a_reg})
      , 6'b0};
  assign mux_66_nl = MUX_s_1_2_2({or_tmp_1 , (~ or_tmp_76)}, else_7_equal_tmp);
  assign mux_70_nl = MUX_s_1_2_2({(mux_66_nl) , or_tmp_1}, (~ (else_7_if_1_acc_tmp[0]))
      | (else_7_if_1_acc_tmp[1]));
  assign and_274_cse = (mux_70_nl) & and_dcpl_25 & (~ (else_7_if_1_div_3cyc_st_1[1]))
      & (else_7_if_1_div_3cyc_st_1[0]);
  assign and_270_cse = or_435_cse & and_dcpl_241 & (else_7_if_1_acc_tmp[0]);
  assign div_mgc_div_8_b = {1'b0, {reg_div_mgc_div_8_b_tmp , 5'b0}};
  assign mux_72_cse = MUX_s_1_2_2({((~((else_7_if_1_acc_tmp[0]) & else_7_equal_tmp))
      & or_tmp_91) , or_tmp_91}, (~ or_cse) | (else_7_if_1_acc_tmp[1]));
  assign div_mgc_div_8_a = {({{2{reg_div_mgc_div_8_a_reg[7]}}, reg_div_mgc_div_8_a_reg})
      , 6'b0};
  assign mux_73_nl = MUX_s_1_2_2({or_tmp_1 , (~ or_tmp_76)}, (else_7_if_1_acc_tmp[1])
      & else_7_equal_tmp);
  assign mux_74_nl = MUX_s_1_2_2({(mux_73_nl) , or_tmp_1}, else_7_if_1_acc_tmp[0]);
  assign and_288_cse = (mux_74_nl) & and_dcpl_25 & (else_7_if_1_div_3cyc_st_1[1])
      & (~ (else_7_if_1_div_3cyc_st_1[0]));
  assign and_284_cse = or_435_cse & else_7_equal_tmp & (else_7_if_1_acc_tmp[1]) &
      (~ (else_7_if_1_acc_tmp[0]));
  assign mux_75_cse = MUX_s_1_2_2({(~(else_7_equal_tmp | (~ or_tmp_102))) , or_tmp_102},
      (~ or_cse) | (~ (else_7_if_1_acc_tmp[1])) | (else_7_if_1_acc_tmp[0]));
  assign div_mgc_div_b = {1'b0, {reg_div_mgc_div_b_tmp , 5'b0}};
  assign div_mgc_div_a = {({{2{reg_div_mgc_div_a_reg[7]}}, reg_div_mgc_div_a_reg})
      , 6'b0};
  assign mux_77_nl = MUX_s_1_2_2({(~ or_tmp_76) , or_tmp_1}, (else_7_else_1_if_acc_tmp[0])
      | (else_7_else_1_if_acc_tmp[1]) | (~ else_7_else_1_equal_tmp) | else_7_equal_tmp);
  assign and_304_cse = (mux_77_nl) & and_92_cse & (~((else_7_else_1_if_div_3cyc_st_1[1])
      | (else_7_else_1_if_div_3cyc_st_1[0])));
  assign and_305_cse = ((~ or_cse) | (else_7_else_1_if_acc_tmp[1]) | (else_7_else_1_if_acc_tmp[0])
      | (~ else_7_else_1_equal_tmp) | else_7_equal_tmp) & ((~ or_tmp_1) | (~ main_stage_0_2)
      | else_7_equal_svs_st_1 | (~ else_7_else_1_equal_svs_st_1) | (else_7_else_1_if_div_3cyc_st_1[0])
      | (else_7_else_1_if_div_3cyc_st_1[1]));
  assign and_299_cse = or_435_cse & and_dcpl_284 & (~((else_7_else_1_if_acc_tmp[1])
      | (else_7_else_1_if_acc_tmp[0])));
  assign div_mgc_div_4_b = {1'b0, {reg_div_mgc_div_4_b_tmp , 5'b0}};
  assign div_mgc_div_4_a = {({{2{reg_div_mgc_div_4_a_reg[7]}}, reg_div_mgc_div_4_a_reg})
      , 6'b0};
  assign mux_78_nl = MUX_s_1_2_2({(~ or_tmp_76) , or_tmp_1}, (~ (else_7_else_1_if_acc_tmp[0]))
      | (else_7_else_1_if_acc_tmp[1]) | (~ else_7_else_1_equal_tmp) | else_7_equal_tmp);
  assign and_324_cse = (mux_78_nl) & and_92_cse & (~ (else_7_else_1_if_div_3cyc_st_1[1]))
      & (else_7_else_1_if_div_3cyc_st_1[0]);
  assign and_325_cse = ((~ or_cse) | (else_7_else_1_if_acc_tmp[1]) | (~ (else_7_else_1_if_acc_tmp[0]))
      | (~ else_7_else_1_equal_tmp) | else_7_equal_tmp) & ((~ or_tmp_1) | (~ main_stage_0_2)
      | else_7_equal_svs_st_1 | (~ else_7_else_1_equal_svs_st_1) | (~ (else_7_else_1_if_div_3cyc_st_1[0]))
      | (else_7_else_1_if_div_3cyc_st_1[1]));
  assign and_319_cse = or_435_cse & and_dcpl_284 & (~ (else_7_else_1_if_acc_tmp[1]))
      & (else_7_else_1_if_acc_tmp[0]);
  assign div_mgc_div_5_b = {1'b0, {reg_div_mgc_div_5_b_tmp , 5'b0}};
  assign div_mgc_div_5_a = {({{2{reg_div_mgc_div_5_a_reg[7]}}, reg_div_mgc_div_5_a_reg})
      , 6'b0};
  assign mux_79_nl = MUX_s_1_2_2({(~ or_tmp_76) , or_tmp_1}, (else_7_else_1_if_acc_tmp[0])
      | (~ (else_7_else_1_if_acc_tmp[1])) | (~ else_7_else_1_equal_tmp) | else_7_equal_tmp);
  assign and_344_cse = (mux_79_nl) & and_92_cse & (else_7_else_1_if_div_3cyc_st_1[1])
      & (~ (else_7_else_1_if_div_3cyc_st_1[0]));
  assign and_345_cse = ((~ or_cse) | (~ (else_7_else_1_if_acc_tmp[1])) | (else_7_else_1_if_acc_tmp[0])
      | (~ else_7_else_1_equal_tmp) | else_7_equal_tmp) & ((~ or_tmp_1) | (~ main_stage_0_2)
      | else_7_equal_svs_st_1 | (~ else_7_else_1_equal_svs_st_1) | (else_7_else_1_if_div_3cyc_st_1[0])
      | (~ (else_7_else_1_if_div_3cyc_st_1[1])));
  assign and_339_cse = or_435_cse & and_dcpl_284 & (else_7_else_1_if_acc_tmp[1])
      & (~ (else_7_else_1_if_acc_tmp[0]));
  assign div_mgc_div_6_b = {1'b0, {reg_div_mgc_div_6_b_tmp , 5'b0}};
  assign div_mgc_div_6_a = {({{2{reg_div_mgc_div_6_a_reg[7]}}, reg_div_mgc_div_6_a_reg})
      , 6'b0};
  assign mux_80_nl = MUX_s_1_2_2({(~ or_tmp_76) , or_tmp_1}, (else_7_else_1_else_acc_tmp[0])
      | (else_7_else_1_else_acc_tmp[1]) | else_7_else_1_equal_tmp | else_7_equal_tmp);
  assign and_364_cse = (mux_80_nl) & and_124_cse & (~((else_7_else_1_else_div_3cyc_st_1[1])
      | (else_7_else_1_else_div_3cyc_st_1[0])));
  assign and_359_cse = or_435_cse & and_dcpl_338 & (~((else_7_else_1_else_acc_tmp[1])
      | (else_7_else_1_else_acc_tmp[0])));
  assign mux_81_cse = MUX_s_1_2_2({(~(or_cse | (~ or_tmp_142))) , or_tmp_142}, (else_7_else_1_else_acc_tmp[1])
      | (else_7_else_1_else_acc_tmp[0]) | else_7_else_1_equal_tmp | else_7_equal_tmp);
  assign div_mgc_div_1_b = {1'b0, {reg_div_mgc_div_1_b_tmp , 5'b0}};
  assign div_mgc_div_1_a = {({{2{reg_div_mgc_div_1_a_reg[7]}}, reg_div_mgc_div_1_a_reg})
      , 6'b0};
  assign mux_83_nl = MUX_s_1_2_2({(~ or_tmp_76) , or_tmp_1}, (~ (else_7_else_1_else_acc_tmp[0]))
      | (else_7_else_1_else_acc_tmp[1]) | else_7_else_1_equal_tmp | else_7_equal_tmp);
  assign and_382_cse = (mux_83_nl) & and_124_cse & (~ (else_7_else_1_else_div_3cyc_st_1[1]))
      & (else_7_else_1_else_div_3cyc_st_1[0]);
  assign and_377_cse = or_435_cse & and_dcpl_338 & (~ (else_7_else_1_else_acc_tmp[1]))
      & (else_7_else_1_else_acc_tmp[0]);
  assign mux_84_cse = MUX_s_1_2_2({(~(or_cse | (~ or_tmp_153))) , or_tmp_153}, (else_7_else_1_else_acc_tmp[1])
      | (~ (else_7_else_1_else_acc_tmp[0])) | else_7_else_1_equal_tmp | else_7_equal_tmp);
  assign div_mgc_div_2_b = {1'b0, {reg_div_mgc_div_2_b_tmp , 5'b0}};
  assign div_mgc_div_2_a = {({{2{reg_div_mgc_div_2_a_reg[7]}}, reg_div_mgc_div_2_a_reg})
      , 6'b0};
  assign mux_86_nl = MUX_s_1_2_2({(~ or_tmp_76) , or_tmp_1}, (else_7_else_1_else_acc_tmp[0])
      | (~ (else_7_else_1_else_acc_tmp[1])) | else_7_else_1_equal_tmp | else_7_equal_tmp);
  assign and_400_cse = (mux_86_nl) & and_124_cse & (else_7_else_1_else_div_3cyc_st_1[1])
      & (~ (else_7_else_1_else_div_3cyc_st_1[0]));
  assign and_395_cse = or_435_cse & and_dcpl_338 & (else_7_else_1_else_acc_tmp[1])
      & (~ (else_7_else_1_else_acc_tmp[0]));
  assign mux_87_cse = MUX_s_1_2_2({(~(or_cse | (~ or_tmp_165))) , or_tmp_165}, (~
      (else_7_else_1_else_acc_tmp[1])) | (else_7_else_1_else_acc_tmp[0]) | else_7_else_1_equal_tmp
      | else_7_equal_tmp);
  assign div_mgc_div_3_b = {1'b0, {reg_div_mgc_div_3_b_tmp , 5'b0}};
  assign div_mgc_div_3_a = {({{2{reg_div_mgc_div_3_a_reg[7]}}, reg_div_mgc_div_3_a_reg})
      , 6'b0};
  assign and_92_cse = and_dcpl_50 & else_7_else_1_equal_svs_st_1;
  assign and_124_cse = and_dcpl_50 & (~ else_7_else_1_equal_svs_st_1);
  assign div_mgc_div_10_b = reg_div_mgc_div_10_b_cse;
  assign div_mgc_div_10_a = {else_7_if_conc_1_tmp_mut_1_sg1 , 5'b0};
  assign div_mgc_div_9_b = reg_div_mgc_div_9_b_cse;
  assign div_mgc_div_9_a = {else_7_if_conc_1_tmp_mut_sg1 , 5'b0};
  assign and_419_cse = and_dcpl_397 & and_dcpl_395 & and_dcpl_393 & and_dcpl_391;
  assign or_cse = (acc_itm[10]) | (acc_itm[9]) | (acc_itm[8]) | (acc_itm[7]) | (acc_itm[6])
      | (acc_itm[5]) | (acc_itm[4]) | (acc_itm[3]) | (acc_itm[2]) | (acc_itm[1]);
  assign nl_else_7_acc_2_itm = ({(~ h_sg1_4_lpi_dfm_1_sg2_1) , (~ h_sg1_4_lpi_dfm_1_sg1_1)
      , (~ h_sg1_4_lpi_dfm_4) , 1'b1}) + ({(h_sg1_4_lpi_dfm_1_sg2_1[0]) , h_sg1_4_lpi_dfm_1_sg1_1
      , h_sg1_4_lpi_dfm_4 , 5'b1});
  assign else_7_acc_2_itm = nl_else_7_acc_2_itm[8:0];
  assign else_7_acc_psp_sva_mx0 = MUX_v_8_2_2({(else_7_acc_2_itm[8:1]) , else_7_acc_psp_sva},
      and_175_cse);
  assign h_sg1_4_sva_duc_mx0 = MUX1HOT_v_8_4_2({(div_mgc_div_7_z[7:0]) , (div_mgc_div_8_z[7:0])
      , (div_mgc_div_z[7:0]) , h_sg1_4_sva_duc}, {(and_dcpl_134 & (~ (else_7_if_1_div_3cyc_st_3[1])))
      , (else_7_equal_svs_st_3 & (else_7_if_1_div_3cyc_st_3[0]) & (~ (else_7_if_1_div_3cyc_st_3[1])))
      , (and_dcpl_134 & (else_7_if_1_div_3cyc_st_3[1])) , (and_dcpl_140 | (~ else_7_equal_svs_st_3))});
  assign mux1h_3_nl = MUX1HOT_v_6_4_2({(div_mgc_div_4_z[7:2]) , (div_mgc_div_5_z[7:2])
      , (div_mgc_div_6_z[7:2]) , (h_sg1_6_sva_duc[7:2])}, {and_dcpl_163 , and_dcpl_166
      , and_dcpl_169 , and_dcpl_172});
  assign nl_h_sg1_4_sva_1_sg1 = (mux1h_3_nl) + 6'b1;
  assign h_sg1_4_sva_1_sg1 = nl_h_sg1_4_sva_1_sg1[5:0];
  assign h_sg1_5_sva_duc_mx0 = MUX1HOT_v_8_4_2({(div_mgc_div_1_z[7:0]) , (div_mgc_div_2_z[7:0])
      , (div_mgc_div_3_z[7:0]) , h_sg1_5_sva_duc}, {(and_dcpl_203 & and_dcpl_202)
      , (and_dcpl_203 & and_dcpl_205) , (and_dcpl_203 & and_dcpl_208) , (else_7_equal_svs_st_3
      | else_7_else_1_equal_svs_st_3 | and_dcpl_211)});
  assign mux1h_6_nl = MUX1HOT_v_5_4_2({(div_mgc_div_1_z[7:3]) , (div_mgc_div_2_z[7:3])
      , (div_mgc_div_3_z[7:3]) , (h_sg1_5_sva_duc[7:3])}, {and_dcpl_202 , and_dcpl_205
      , and_dcpl_208 , and_dcpl_211});
  assign h_sg1_4_lpi_dfm_1_sg2_1 = MUX1HOT_v_5_3_2({((mux1h_6_nl) + 5'b1) , (h_sg1_4_sva_1_sg1[5:1])
      , (h_sg1_4_sva_duc_mx0[7:3])}, {else_7_nor_ssc , else_7_and_5_itm_3 , else_7_equal_svs_3});
  assign h_sg1_4_lpi_dfm_1_sg1_1 = MUX1HOT_s_1_3_2({(h_sg1_5_sva_duc_mx0[2]) , (h_sg1_4_sva_1_sg1[0])
      , (h_sg1_4_sva_duc_mx0[2])}, {else_7_nor_ssc , else_7_and_5_itm_3 , else_7_equal_svs_3});
  assign h_sg1_4_lpi_dfm_4 = MUX1HOT_v_2_6_2({(h_sg1_5_sva_duc_mx0[1:0]) , (div_mgc_div_4_z[1:0])
      , (div_mgc_div_5_z[1:0]) , (div_mgc_div_6_z[1:0]) , (h_sg1_6_sva_duc[1:0])
      , (h_sg1_4_sva_duc_mx0[1:0])}, {else_7_nor_ssc , (and_dcpl_164 & and_dcpl_163
      & else_7_and_5_itm_3) , (and_dcpl_164 & and_dcpl_166 & else_7_and_5_itm_3)
      , (and_dcpl_164 & and_dcpl_169 & else_7_and_5_itm_3) , ((else_7_equal_svs_st_3
      | (~ else_7_else_1_equal_svs_st_3) | and_dcpl_172) & else_7_and_5_itm_3) ,
      else_7_equal_svs_3});
  assign else_7_nor_ssc = ~(else_7_else_1_equal_svs_3 | else_7_equal_svs_3);
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
  assign mux1h_26_tmp = MUX1HOT_v_10_3_2({r_rsc_mgc_in_wire_d , b_rsc_mgc_in_wire_d
      , g_rsc_mgc_in_wire_d}, {(~((if_if_acc_itm[11]) | (if_acc_1_itm[11]))) , (((if_if_acc_itm[11])
      & (~ (if_acc_1_itm[11]))) | ((else_1_if_acc_itm[11]) & (if_acc_1_itm[11])))
      , ((~ (else_1_if_acc_itm[11])) & (if_acc_1_itm[11]))});
  assign mux1h_27_nl = MUX1HOT_v_10_3_2({r_rsc_mgc_in_wire_d , b_rsc_mgc_in_wire_d
      , g_rsc_mgc_in_wire_d}, {(~((if_3_if_acc_itm[11]) | (if_3_acc_1_itm[11])))
      , (((if_3_if_acc_itm[11]) & (~ (if_3_acc_1_itm[11]))) | ((else_5_if_acc_itm[11])
      & (if_3_acc_1_itm[11]))) , ((~ (else_5_if_acc_itm[11])) & (if_3_acc_1_itm[11]))});
  assign nl_acc_itm = ({mux1h_26_tmp , 1'b1}) + ({(~ (mux1h_27_nl)) , 1'b1});
  assign acc_itm = nl_acc_itm[10:0];
  assign nl_else_7_if_1_acc_1_itm = ({(g_1_lpi_dfm[7:0]) , 1'b1}) + ({(~ b_1_lpi_dfm_2)
      , 1'b1});
  assign else_7_if_1_acc_1_itm = nl_else_7_if_1_acc_1_itm[8:0];
  assign nl_else_7_if_1_acc_tmp = conv_u2u_1_2(acc_imod[0]) + conv_u2u_1_2(acc_imod[1]);
  assign else_7_if_1_acc_tmp = nl_else_7_if_1_acc_tmp[1:0];
  assign nl_acc_imod = conv_s2s_1_2(else_7_if_1_acc_idiv[1]) + conv_u2s_1_2(else_7_if_1_acc_idiv[0]);
  assign acc_imod = nl_acc_imod[1:0];
  assign nl_else_7_if_1_acc_idiv = else_7_if_1_div_3cyc + 2'b1;
  assign else_7_if_1_acc_idiv = nl_else_7_if_1_acc_idiv[1:0];
  assign g_1_lpi_dfm = g_rsc_mgc_in_wire_d & ({{9{unequal_tmp_7}}, unequal_tmp_7});
  assign b_1_lpi_dfm_2 = (b_rsc_mgc_in_wire_d[7:0]) & ({{7{unequal_tmp_7}}, unequal_tmp_7});
  assign nl_else_7_else_1_if_acc_2_itm = ({b_1_lpi_dfm_2 , 1'b1}) + ({(~ (r_1_lpi_dfm[7:0]))
      , 1'b1});
  assign else_7_else_1_if_acc_2_itm = nl_else_7_else_1_if_acc_2_itm[8:0];
  assign nl_else_7_else_1_if_acc_tmp = conv_u2u_1_2(acc_imod_1[0]) + conv_u2u_1_2(acc_imod_1[1]);
  assign else_7_else_1_if_acc_tmp = nl_else_7_else_1_if_acc_tmp[1:0];
  assign nl_acc_imod_1 = conv_s2s_1_2(else_7_else_1_if_acc_idiv[1]) + conv_u2s_1_2(else_7_else_1_if_acc_idiv[0]);
  assign acc_imod_1 = nl_acc_imod_1[1:0];
  assign nl_else_7_else_1_if_acc_idiv = else_7_else_1_if_div_3cyc + 2'b1;
  assign else_7_else_1_if_acc_idiv = nl_else_7_else_1_if_acc_idiv[1:0];
  assign r_1_lpi_dfm = r_rsc_mgc_in_wire_d & ({{9{unequal_tmp_7}}, unequal_tmp_7});
  assign nl_else_7_else_1_else_acc_2_itm = ({(r_1_lpi_dfm[7:0]) , 1'b1}) + ({(~ (g_1_lpi_dfm[7:0]))
      , 1'b1});
  assign else_7_else_1_else_acc_2_itm = nl_else_7_else_1_else_acc_2_itm[8:0];
  assign nl_else_7_else_1_else_acc_tmp = conv_u2u_1_2(acc_imod_2[0]) + conv_u2u_1_2(acc_imod_2[1]);
  assign else_7_else_1_else_acc_tmp = nl_else_7_else_1_else_acc_tmp[1:0];
  assign nl_acc_imod_2 = conv_s2s_1_2(else_7_else_1_else_acc_idiv[1]) + conv_u2s_1_2(else_7_else_1_else_acc_idiv[0]);
  assign acc_imod_2 = nl_acc_imod_2[1:0];
  assign nl_else_7_else_1_else_acc_idiv = else_7_else_1_else_div_3cyc + 2'b1;
  assign else_7_else_1_else_acc_idiv = nl_else_7_else_1_else_acc_idiv[1:0];
  assign else_7_else_1_equal_tmp = g_1_lpi_dfm == mux1h_26_tmp;
  assign else_7_equal_tmp = r_1_lpi_dfm == mux1h_26_tmp;
  assign unequal_tmp_7 = (mux1h_26_tmp[9]) | (mux1h_26_tmp[8]) | (mux1h_26_tmp[7])
      | (mux1h_26_tmp[6]) | (mux1h_26_tmp[5]) | (mux1h_26_tmp[4]) | (mux1h_26_tmp[3])
      | (mux1h_26_tmp[2]) | (mux1h_26_tmp[1]) | (mux1h_26_tmp[0]);
  assign nl_if_3_acc_1_itm = ({1'b1 , g_rsc_mgc_in_wire_d , 1'b1}) + conv_u2u_11_12({(~
      r_rsc_mgc_in_wire_d) , 1'b1});
  assign if_3_acc_1_itm = nl_if_3_acc_1_itm[11:0];
  assign nl_if_acc_1_itm = ({1'b1 , r_rsc_mgc_in_wire_d , 1'b1}) + conv_u2u_11_12({(~
      g_rsc_mgc_in_wire_d) , 1'b1});
  assign if_acc_1_itm = nl_if_acc_1_itm[11:0];
  assign mux1h_28_nl = MUX1HOT_v_10_3_2({(div_mgc_div_10_z[9:0]) , (div_mgc_div_9_z[9:0])
      , s_sg1_1_sva_2_duc}, {(~((~(or_dcpl_528 | or_dcpl_526 | or_dcpl_524 | or_dcpl_522))
      | else_7_if_div_2cyc_st_2)) , ((or_dcpl_528 | or_dcpl_526 | or_dcpl_524 | or_dcpl_522)
      & else_7_if_div_2cyc_st_2) , ((~((max_sg1_lpi_dfm_3_st_2[9]) | (max_sg1_lpi_dfm_3_st_2[8])
      | (max_sg1_lpi_dfm_3_st_2[7]))) & (~((max_sg1_lpi_dfm_3_st_2[6]) | (max_sg1_lpi_dfm_3_st_2[5])))
      & (~((max_sg1_lpi_dfm_3_st_2[4]) | (max_sg1_lpi_dfm_3_st_2[3]) | (max_sg1_lpi_dfm_3_st_2[2])))
      & (~((max_sg1_lpi_dfm_3_st_2[1]) | (max_sg1_lpi_dfm_3_st_2[0]))))});
  assign nl_mul_1_itm = 10'b11001 * ((mux1h_28_nl) & ({{9{unequal_tmp_6}}, unequal_tmp_6})
      & ({{9{unequal_tmp_3}}, unequal_tmp_3}));
  assign mul_1_itm = nl_mul_1_itm[9:0];
  assign nl_mul_itm = 13'b11001 * conv_u2u_10_13(mux1h_26_tmp);
  assign mul_itm = nl_mul_itm[12:0];
  assign or_tmp_1 = (acc_2_psp_sva_st_1[0]) | (acc_2_psp_sva_st_1[1]) | (acc_2_psp_sva_st_1[2])
      | (acc_2_psp_sva_st_1[3]) | (acc_2_psp_sva_st_1[4]) | (acc_2_psp_sva_st_1[5])
      | (acc_2_psp_sva_st_1[6]) | (acc_2_psp_sva_st_1[7]) | (acc_2_psp_sva_st_1[8])
      | (acc_2_psp_sva_st_1[9]);
  assign and_dcpl_25 = main_stage_0_2 & else_7_equal_svs_st_1;
  assign and_dcpl_50 = main_stage_0_2 & (~ else_7_equal_svs_st_1);
  assign and_dcpl_116 = ~((acc_2_psp_sva_st_3[1]) | (acc_2_psp_sva_st_3[0]));
  assign and_dcpl_118 = ~((acc_2_psp_sva_st_3[4]) | (acc_2_psp_sva_st_3[3]) | (acc_2_psp_sva_st_3[2]));
  assign and_dcpl_120 = ~((acc_2_psp_sva_st_3[6]) | (acc_2_psp_sva_st_3[5]));
  assign and_dcpl_122 = ~((acc_2_psp_sva_st_3[9]) | (acc_2_psp_sva_st_3[8]) | (acc_2_psp_sva_st_3[7]));
  assign and_dcpl_134 = else_7_equal_svs_st_3 & (~ (else_7_if_1_div_3cyc_st_3[0]));
  assign and_dcpl_140 = (else_7_if_1_div_3cyc_st_3[0]) & (else_7_if_1_div_3cyc_st_3[1]);
  assign and_dcpl_142 = main_stage_0_4 & else_7_equal_svs_st_3;
  assign and_dcpl_163 = ~((else_7_else_1_if_div_3cyc_st_3[0]) | (else_7_else_1_if_div_3cyc_st_3[1]));
  assign and_dcpl_164 = (~ else_7_equal_svs_st_3) & else_7_else_1_equal_svs_st_3;
  assign and_dcpl_166 = (else_7_else_1_if_div_3cyc_st_3[0]) & (~ (else_7_else_1_if_div_3cyc_st_3[1]));
  assign and_dcpl_169 = (~ (else_7_else_1_if_div_3cyc_st_3[0])) & (else_7_else_1_if_div_3cyc_st_3[1]);
  assign and_dcpl_172 = (else_7_else_1_if_div_3cyc_st_3[0]) & (else_7_else_1_if_div_3cyc_st_3[1]);
  assign and_dcpl_178 = main_stage_0_4 & (~ else_7_equal_svs_st_3);
  assign and_dcpl_179 = and_dcpl_178 & else_7_else_1_equal_svs_st_3;
  assign or_dcpl_314 = (~ main_stage_0_4) | else_7_equal_svs_st_3;
  assign and_dcpl_202 = ~((else_7_else_1_else_div_3cyc_st_3[0]) | (else_7_else_1_else_div_3cyc_st_3[1]));
  assign and_dcpl_203 = ~(else_7_equal_svs_st_3 | else_7_else_1_equal_svs_st_3);
  assign and_dcpl_205 = (else_7_else_1_else_div_3cyc_st_3[0]) & (~ (else_7_else_1_else_div_3cyc_st_3[1]));
  assign and_dcpl_208 = (~ (else_7_else_1_else_div_3cyc_st_3[0])) & (else_7_else_1_else_div_3cyc_st_3[1]);
  assign and_dcpl_211 = (else_7_else_1_else_div_3cyc_st_3[0]) & (else_7_else_1_else_div_3cyc_st_3[1]);
  assign and_dcpl_218 = and_dcpl_178 & (~ else_7_else_1_equal_svs_st_3);
  assign and_dcpl_241 = else_7_equal_tmp & (~ (else_7_if_1_acc_tmp[1]));
  assign or_tmp_76 = or_cse | (~ or_tmp_1);
  assign or_tmp_80 = (~ or_tmp_1) | (~ main_stage_0_2) | (~ else_7_equal_svs_st_1)
      | (else_7_if_1_div_3cyc_st_1[0]) | (else_7_if_1_div_3cyc_st_1[1]);
  assign or_tmp_91 = ~(or_tmp_1 & main_stage_0_2 & else_7_equal_svs_st_1 & (else_7_if_1_div_3cyc_st_1[0])
      & (~ (else_7_if_1_div_3cyc_st_1[1])));
  assign or_tmp_102 = ~(or_tmp_1 & main_stage_0_2 & else_7_equal_svs_st_1 & (~ (else_7_if_1_div_3cyc_st_1[0]))
      & (else_7_if_1_div_3cyc_st_1[1]));
  assign and_dcpl_284 = (~ else_7_equal_tmp) & else_7_else_1_equal_tmp;
  assign and_dcpl_338 = ~(else_7_equal_tmp | else_7_else_1_equal_tmp);
  assign or_tmp_142 = (~ or_tmp_1) | (~ main_stage_0_2) | else_7_equal_svs_st_1 |
      else_7_else_1_equal_svs_st_1 | (else_7_else_1_else_div_3cyc_st_1[0]) | (else_7_else_1_else_div_3cyc_st_1[1]);
  assign or_tmp_153 = (~ or_tmp_1) | (~ main_stage_0_2) | else_7_equal_svs_st_1 |
      else_7_else_1_equal_svs_st_1 | (~ (else_7_else_1_else_div_3cyc_st_1[0])) |
      (else_7_else_1_else_div_3cyc_st_1[1]);
  assign or_tmp_165 = (~ or_tmp_1) | (~ main_stage_0_2) | else_7_equal_svs_st_1 |
      else_7_else_1_equal_svs_st_1 | (else_7_else_1_else_div_3cyc_st_1[0]) | (~ (else_7_else_1_else_div_3cyc_st_1[1]));
  assign not_tmp_125 = ~(((mux1h_26_tmp[9]) | (mux1h_26_tmp[8]) | (mux1h_26_tmp[7])
      | (mux1h_26_tmp[6]) | (mux1h_26_tmp[5]) | (mux1h_26_tmp[4]) | (mux1h_26_tmp[3])
      | (mux1h_26_tmp[2]) | (mux1h_26_tmp[1]) | (mux1h_26_tmp[0])) & or_cse);
  assign or_dcpl_513 = not_tmp_125 | (~ else_7_if_div_2cyc);
  assign or_dcpl_515 = not_tmp_125 | else_7_if_div_2cyc;
  assign and_dcpl_391 = ~((acc_itm[9]) | (acc_itm[10]));
  assign and_dcpl_393 = ~((acc_itm[6]) | (acc_itm[7]) | (acc_itm[8]));
  assign and_dcpl_395 = ~((acc_itm[4]) | (acc_itm[5]));
  assign and_dcpl_397 = ~((acc_itm[1]) | (acc_itm[2]) | (acc_itm[3]));
  assign or_dcpl_522 = (max_sg1_lpi_dfm_3_st_2[1]) | (max_sg1_lpi_dfm_3_st_2[0]);
  assign or_dcpl_524 = (max_sg1_lpi_dfm_3_st_2[4]) | (max_sg1_lpi_dfm_3_st_2[3])
      | (max_sg1_lpi_dfm_3_st_2[2]);
  assign or_dcpl_526 = (max_sg1_lpi_dfm_3_st_2[6]) | (max_sg1_lpi_dfm_3_st_2[5]);
  assign or_dcpl_528 = (max_sg1_lpi_dfm_3_st_2[9]) | (max_sg1_lpi_dfm_3_st_2[8])
      | (max_sg1_lpi_dfm_3_st_2[7]);
  assign and_tmp_9 = ((max_sg1_lpi_dfm_3_st_2[0]) | (max_sg1_lpi_dfm_3_st_2[1]) |
      (max_sg1_lpi_dfm_3_st_2[2]) | (max_sg1_lpi_dfm_3_st_2[3]) | (max_sg1_lpi_dfm_3_st_2[4])
      | (max_sg1_lpi_dfm_3_st_2[5]) | (max_sg1_lpi_dfm_3_st_2[6]) | (max_sg1_lpi_dfm_3_st_2[7])
      | (max_sg1_lpi_dfm_3_st_2[8]) | (max_sg1_lpi_dfm_3_st_2[9])) & ((acc_2_psp_sva_st_2[0])
      | (acc_2_psp_sva_st_2[1]) | (acc_2_psp_sva_st_2[2]) | (acc_2_psp_sva_st_2[3])
      | (acc_2_psp_sva_st_2[4]) | (acc_2_psp_sva_st_2[5]) | (acc_2_psp_sva_st_2[6])
      | (acc_2_psp_sva_st_2[7]) | (acc_2_psp_sva_st_2[8]) | (acc_2_psp_sva_st_2[9]));
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      V_OUT_rsc_mgc_out_stdreg_d <= 10'b0;
      S_OUT_rsc_mgc_out_stdreg_d <= 10'b0;
      H_OUT_rsc_mgc_out_stdreg_d <= 10'b0;
      else_7_acc_psp_sva <= 8'b0;
      h_sg1_4_sva_duc <= 8'b0;
      else_7_if_1_div_3cyc_st_3 <= 2'b0;
      h_sg1_6_sva_duc <= 8'b0;
      h_sg1_5_sva_duc <= 8'b0;
      else_7_else_1_if_div_3cyc_st_3 <= 2'b0;
      else_7_else_1_else_div_3cyc_st_3 <= 2'b0;
      else_7_else_1_equal_svs_st_3 <= 1'b0;
      else_7_and_5_itm_3 <= 1'b0;
      else_7_equal_svs_3 <= 1'b0;
      else_7_else_1_equal_svs_3 <= 1'b0;
      else_7_equal_svs_st_3 <= 1'b0;
      acc_5_itm_3 <= 8'b0;
      acc_4_itm_1 <= 8'b0;
      unequal_tmp_4 <= 1'b0;
      acc_2_psp_sva_st_3 <= 10'b0;
      reg_div_mgc_div_7_a_reg <= 8'b0;
      reg_div_mgc_div_8_a_reg <= 8'b0;
      reg_div_mgc_div_a_reg <= 8'b0;
      reg_div_mgc_div_4_a_reg <= 8'b0;
      reg_div_mgc_div_5_a_reg <= 8'b0;
      reg_div_mgc_div_6_a_reg <= 8'b0;
      reg_div_mgc_div_1_a_reg <= 8'b0;
      reg_div_mgc_div_2_a_reg <= 8'b0;
      reg_div_mgc_div_3_a_reg <= 8'b0;
      else_7_if_div_2cyc_st_2 <= 1'b0;
      mut_49_sg1_1 <= 10'b0;
      mut_47_sg1_1 <= 8'b0;
      mut_53_sg1_1 <= 10'b0;
      mut_51_sg1_1 <= 8'b0;
      mut_21_sg1_1 <= 10'b0;
      mut_19_sg1_1 <= 8'b0;
      else_7_if_1_div_3cyc_st_2 <= 2'b0;
      mut_37_sg1_1 <= 10'b0;
      mut_35_sg1_1 <= 8'b0;
      mut_41_sg1_1 <= 10'b0;
      mut_39_sg1_1 <= 8'b0;
      mut_45_sg1_1 <= 10'b0;
      mut_43_sg1_1 <= 8'b0;
      else_7_else_1_if_div_3cyc_st_2 <= 2'b0;
      mut_25_sg1_1 <= 10'b0;
      mut_23_sg1_1 <= 8'b0;
      mut_29_sg1_1 <= 10'b0;
      mut_27_sg1_1 <= 8'b0;
      mut_33_sg1_1 <= 10'b0;
      mut_31_sg1_1 <= 8'b0;
      else_7_else_1_else_div_3cyc_st_2 <= 2'b0;
      else_7_else_1_equal_svs_st_2 <= 1'b0;
      else_7_equal_svs_st_2 <= 1'b0;
      max_sg1_lpi_dfm_3_st_2 <= 10'b0;
      acc_2_psp_sva_st_2 <= 10'b0;
      reg_div_mgc_div_10_b_cse <= 10'b0;
      reg_div_mgc_div_9_b_cse <= 10'b0;
      else_7_if_div_2cyc_st_1 <= 1'b0;
      mut_48_sg1_1 <= 10'b0;
      mut_46_sg1_1 <= 8'b0;
      mut_52_sg1_1 <= 10'b0;
      mut_50_sg1_1 <= 8'b0;
      mut_20_sg1_1 <= 10'b0;
      mut_18_sg1_1 <= 8'b0;
      else_7_if_1_div_3cyc_st_1 <= 2'b0;
      mut_36_sg1_1 <= 10'b0;
      mut_34_sg1_1 <= 8'b0;
      mut_40_sg1_1 <= 10'b0;
      mut_38_sg1_1 <= 8'b0;
      mut_44_sg1_1 <= 10'b0;
      mut_42_sg1_1 <= 8'b0;
      else_7_else_1_if_div_3cyc_st_1 <= 2'b0;
      mut_24_sg1_1 <= 10'b0;
      mut_22_sg1_1 <= 8'b0;
      mut_28_sg1_1 <= 10'b0;
      mut_26_sg1_1 <= 8'b0;
      mut_32_sg1_1 <= 10'b0;
      mut_30_sg1_1 <= 8'b0;
      else_7_else_1_else_div_3cyc_st_1 <= 2'b0;
      else_7_else_1_equal_svs_st_1 <= 1'b0;
      else_7_equal_svs_st_1 <= 1'b0;
      max_sg1_lpi_dfm_3_st_1 <= 10'b0;
      acc_2_psp_sva_st_1 <= 10'b0;
      else_7_if_div_2cyc <= 1'b0;
      else_7_if_1_div_3cyc <= 2'b0;
      else_7_else_1_if_div_3cyc <= 2'b0;
      else_7_else_1_else_div_3cyc <= 2'b0;
      else_7_equal_svs <= 1'b0;
      unequal_tmp_1 <= 1'b0;
      main_stage_0_2 <= 1'b0;
      main_stage_0_3 <= 1'b0;
      main_stage_0_4 <= 1'b0;
      s_sg1_1_sva_2_duc <= 10'b0;
      unequal_tmp_6 <= 1'b0;
      unequal_tmp_3 <= 1'b0;
      else_7_if_conc_1_tmp_mut_1_sg1 <= 10'b0;
      else_7_if_conc_1_tmp_mut_sg1 <= 10'b0;
      acc_5_itm_2 <= 8'b0;
      else_7_and_5_itm_2 <= 1'b0;
      else_7_equal_svs_2 <= 1'b0;
      else_7_else_1_equal_svs_2 <= 1'b0;
      acc_5_itm_1 <= 8'b0;
      else_7_and_5_itm_1 <= 1'b0;
      unequal_tmp_2 <= 1'b0;
      else_7_else_1_equal_svs_1 <= 1'b0;
      reg_div_mgc_div_7_b_tmp <= 10'b0;
      reg_div_mgc_div_8_b_tmp <= 10'b0;
      reg_div_mgc_div_b_tmp <= 10'b0;
      reg_div_mgc_div_4_b_tmp <= 10'b0;
      reg_div_mgc_div_5_b_tmp <= 10'b0;
      reg_div_mgc_div_6_b_tmp <= 10'b0;
      reg_div_mgc_div_1_b_tmp <= 10'b0;
      reg_div_mgc_div_2_b_tmp <= 10'b0;
      reg_div_mgc_div_3_b_tmp <= 10'b0;
    end
    else begin
      V_OUT_rsc_mgc_out_stdreg_d <= MUX_v_10_2_2({V_OUT_rsc_mgc_out_stdreg_d , ({2'b0
          , acc_5_itm_3})}, main_stage_0_4);
      S_OUT_rsc_mgc_out_stdreg_d <= MUX_v_10_2_2({S_OUT_rsc_mgc_out_stdreg_d , ({2'b0
          , acc_4_itm_1})}, main_stage_0_4);
      H_OUT_rsc_mgc_out_stdreg_d <= MUX_v_10_2_2({H_OUT_rsc_mgc_out_stdreg_d , ({(signext_9_8({((MUX_v_6_2_2({(else_7_acc_psp_sva_mx0[7:2])
          , (({1'b1 , (else_7_acc_2_itm[7:3])}) + 6'b101101)}, else_7_acc_psp_sva_mx0[7]))
          & ({{5{unequal_tmp_4}}, unequal_tmp_4})) , ((else_7_acc_psp_sva_mx0[1:0])
          & ({{1{unequal_tmp_4}}, unequal_tmp_4}))})) , 1'b0})}, main_stage_0_4);
      else_7_acc_psp_sva <= MUX_v_8_2_2({(else_7_acc_2_itm[8:1]) , else_7_acc_psp_sva},
          ~((~(and_dcpl_122 & and_dcpl_120 & and_dcpl_118 & and_dcpl_116)) & main_stage_0_4));
      h_sg1_4_sva_duc <= MUX1HOT_v_8_4_2({(div_mgc_div_7_z[7:0]) , (div_mgc_div_8_z[7:0])
          , (div_mgc_div_z[7:0]) , h_sg1_4_sva_duc}, {(or_339_cse & and_dcpl_142
          & (~((else_7_if_1_div_3cyc_st_3[0]) | (else_7_if_1_div_3cyc_st_3[1]))))
          , (or_339_cse & and_dcpl_142 & (else_7_if_1_div_3cyc_st_3[0]) & (~ (else_7_if_1_div_3cyc_st_3[1])))
          , (or_339_cse & and_dcpl_142 & (~ (else_7_if_1_div_3cyc_st_3[0])) & (else_7_if_1_div_3cyc_st_3[1]))
          , (and_175_cse | (~(main_stage_0_4 & else_7_equal_svs_st_3)) | and_dcpl_140)});
      else_7_if_1_div_3cyc_st_3 <= else_7_if_1_div_3cyc_st_2;
      h_sg1_6_sva_duc <= MUX1HOT_v_8_4_2({(div_mgc_div_4_z[7:0]) , (div_mgc_div_5_z[7:0])
          , (div_mgc_div_6_z[7:0]) , h_sg1_6_sva_duc}, {(or_339_cse & and_dcpl_179
          & and_dcpl_163) , (or_339_cse & and_dcpl_179 & and_dcpl_166) , (or_339_cse
          & and_dcpl_179 & and_dcpl_169) , (and_175_cse | or_dcpl_314 | (~ else_7_else_1_equal_svs_st_3)
          | and_dcpl_172)});
      h_sg1_5_sva_duc <= MUX1HOT_v_8_4_2({(div_mgc_div_1_z[7:0]) , (div_mgc_div_2_z[7:0])
          , (div_mgc_div_3_z[7:0]) , h_sg1_5_sva_duc}, {(or_339_cse & and_dcpl_218
          & and_dcpl_202) , (or_339_cse & and_dcpl_218 & and_dcpl_205) , (or_339_cse
          & and_dcpl_218 & and_dcpl_208) , (and_175_cse | or_dcpl_314 | else_7_else_1_equal_svs_st_3
          | and_dcpl_211)});
      else_7_else_1_if_div_3cyc_st_3 <= else_7_else_1_if_div_3cyc_st_2;
      else_7_else_1_else_div_3cyc_st_3 <= else_7_else_1_else_div_3cyc_st_2;
      else_7_else_1_equal_svs_st_3 <= else_7_else_1_equal_svs_st_2;
      else_7_and_5_itm_3 <= else_7_and_5_itm_2;
      else_7_equal_svs_3 <= else_7_equal_svs_2;
      else_7_else_1_equal_svs_3 <= else_7_else_1_equal_svs_2;
      else_7_equal_svs_st_3 <= else_7_equal_svs_st_2;
      acc_5_itm_3 <= acc_5_itm_2;
      acc_4_itm_1 <= nl_acc_4_itm_1[7:0];
      unequal_tmp_4 <= unequal_tmp_3;
      acc_2_psp_sva_st_3 <= acc_2_psp_sva_st_2;
      reg_div_mgc_div_7_a_reg <= MUX1HOT_v_8_3_2({(else_7_if_1_acc_1_itm[8:1]) ,
          mut_46_sg1_1 , mut_47_sg1_1}, {and_256_cse , and_260_cse , mux_68_cse});
      reg_div_mgc_div_8_a_reg <= MUX1HOT_v_8_3_2({(else_7_if_1_acc_1_itm[8:1]) ,
          mut_50_sg1_1 , mut_51_sg1_1}, {and_270_cse , and_274_cse , mux_72_cse});
      reg_div_mgc_div_a_reg <= MUX1HOT_v_8_3_2({(else_7_if_1_acc_1_itm[8:1]) , mut_18_sg1_1
          , mut_19_sg1_1}, {and_284_cse , and_288_cse , mux_75_cse});
      reg_div_mgc_div_4_a_reg <= MUX1HOT_v_8_3_2({(else_7_else_1_if_acc_2_itm[8:1])
          , mut_34_sg1_1 , mut_35_sg1_1}, {and_299_cse , and_304_cse , and_305_cse});
      reg_div_mgc_div_5_a_reg <= MUX1HOT_v_8_3_2({(else_7_else_1_if_acc_2_itm[8:1])
          , mut_38_sg1_1 , mut_39_sg1_1}, {and_319_cse , and_324_cse , and_325_cse});
      reg_div_mgc_div_6_a_reg <= MUX1HOT_v_8_3_2({(else_7_else_1_if_acc_2_itm[8:1])
          , mut_42_sg1_1 , mut_43_sg1_1}, {and_339_cse , and_344_cse , and_345_cse});
      reg_div_mgc_div_1_a_reg <= MUX1HOT_v_8_3_2({(else_7_else_1_else_acc_2_itm[8:1])
          , mut_22_sg1_1 , mut_23_sg1_1}, {and_359_cse , and_364_cse , mux_81_cse});
      reg_div_mgc_div_2_a_reg <= MUX1HOT_v_8_3_2({(else_7_else_1_else_acc_2_itm[8:1])
          , mut_26_sg1_1 , mut_27_sg1_1}, {and_377_cse , and_382_cse , mux_84_cse});
      reg_div_mgc_div_3_a_reg <= MUX1HOT_v_8_3_2({(else_7_else_1_else_acc_2_itm[8:1])
          , mut_30_sg1_1 , mut_31_sg1_1}, {and_395_cse , and_400_cse , mux_87_cse});
      else_7_if_div_2cyc_st_2 <= else_7_if_div_2cyc_st_1;
      mut_49_sg1_1 <= mut_48_sg1_1;
      mut_47_sg1_1 <= mut_46_sg1_1;
      mut_53_sg1_1 <= mut_52_sg1_1;
      mut_51_sg1_1 <= mut_50_sg1_1;
      mut_21_sg1_1 <= mut_20_sg1_1;
      mut_19_sg1_1 <= mut_18_sg1_1;
      else_7_if_1_div_3cyc_st_2 <= else_7_if_1_div_3cyc_st_1;
      mut_37_sg1_1 <= mut_36_sg1_1;
      mut_35_sg1_1 <= mut_34_sg1_1;
      mut_41_sg1_1 <= mut_40_sg1_1;
      mut_39_sg1_1 <= mut_38_sg1_1;
      mut_45_sg1_1 <= mut_44_sg1_1;
      mut_43_sg1_1 <= mut_42_sg1_1;
      else_7_else_1_if_div_3cyc_st_2 <= else_7_else_1_if_div_3cyc_st_1;
      mut_25_sg1_1 <= mut_24_sg1_1;
      mut_23_sg1_1 <= mut_22_sg1_1;
      mut_29_sg1_1 <= mut_28_sg1_1;
      mut_27_sg1_1 <= mut_26_sg1_1;
      mut_33_sg1_1 <= mut_32_sg1_1;
      mut_31_sg1_1 <= mut_30_sg1_1;
      else_7_else_1_else_div_3cyc_st_2 <= else_7_else_1_else_div_3cyc_st_1;
      else_7_else_1_equal_svs_st_2 <= else_7_else_1_equal_svs_st_1;
      else_7_equal_svs_st_2 <= else_7_equal_svs_st_1;
      max_sg1_lpi_dfm_3_st_2 <= max_sg1_lpi_dfm_3_st_1;
      acc_2_psp_sva_st_2 <= acc_2_psp_sva_st_1;
      reg_div_mgc_div_10_b_cse <= MUX_v_10_2_2({mux1h_26_tmp , reg_div_mgc_div_10_b_cse},
          or_dcpl_513);
      reg_div_mgc_div_9_b_cse <= MUX_v_10_2_2({mux1h_26_tmp , reg_div_mgc_div_9_b_cse},
          or_dcpl_515);
      else_7_if_div_2cyc_st_1 <= MUX_s_1_2_2({(~ else_7_if_div_2cyc) , else_7_if_div_2cyc_st_1},
          not_tmp_125);
      mut_48_sg1_1 <= MUX_v_10_2_2({(acc_itm[10:1]) , mut_48_sg1_1}, and_419_cse);
      mut_46_sg1_1 <= MUX_v_8_2_2({(else_7_if_1_acc_1_itm[8:1]) , mut_46_sg1_1},
          and_419_cse);
      mut_52_sg1_1 <= MUX_v_10_2_2({(acc_itm[10:1]) , mut_52_sg1_1}, and_419_cse);
      mut_50_sg1_1 <= MUX_v_8_2_2({(else_7_if_1_acc_1_itm[8:1]) , mut_50_sg1_1},
          and_419_cse);
      mut_20_sg1_1 <= MUX_v_10_2_2({(acc_itm[10:1]) , mut_20_sg1_1}, and_419_cse);
      mut_18_sg1_1 <= MUX_v_8_2_2({(else_7_if_1_acc_1_itm[8:1]) , mut_18_sg1_1},
          and_419_cse);
      else_7_if_1_div_3cyc_st_1 <= MUX_v_2_2_2({else_7_if_1_acc_tmp , else_7_if_1_div_3cyc_st_1},
          and_419_cse);
      mut_36_sg1_1 <= MUX_v_10_2_2({(acc_itm[10:1]) , mut_36_sg1_1}, and_419_cse);
      mut_34_sg1_1 <= MUX_v_8_2_2({(else_7_else_1_if_acc_2_itm[8:1]) , mut_34_sg1_1},
          and_419_cse);
      mut_40_sg1_1 <= MUX_v_10_2_2({(acc_itm[10:1]) , mut_40_sg1_1}, and_419_cse);
      mut_38_sg1_1 <= MUX_v_8_2_2({(else_7_else_1_if_acc_2_itm[8:1]) , mut_38_sg1_1},
          and_419_cse);
      mut_44_sg1_1 <= MUX_v_10_2_2({(acc_itm[10:1]) , mut_44_sg1_1}, and_419_cse);
      mut_42_sg1_1 <= MUX_v_8_2_2({(else_7_else_1_if_acc_2_itm[8:1]) , mut_42_sg1_1},
          and_419_cse);
      else_7_else_1_if_div_3cyc_st_1 <= MUX_v_2_2_2({else_7_else_1_if_acc_tmp , else_7_else_1_if_div_3cyc_st_1},
          and_419_cse);
      mut_24_sg1_1 <= MUX_v_10_2_2({(acc_itm[10:1]) , mut_24_sg1_1}, and_419_cse);
      mut_22_sg1_1 <= MUX_v_8_2_2({(else_7_else_1_else_acc_2_itm[8:1]) , mut_22_sg1_1},
          and_419_cse);
      mut_28_sg1_1 <= MUX_v_10_2_2({(acc_itm[10:1]) , mut_28_sg1_1}, and_419_cse);
      mut_26_sg1_1 <= MUX_v_8_2_2({(else_7_else_1_else_acc_2_itm[8:1]) , mut_26_sg1_1},
          and_419_cse);
      mut_32_sg1_1 <= MUX_v_10_2_2({(acc_itm[10:1]) , mut_32_sg1_1}, and_419_cse);
      mut_30_sg1_1 <= MUX_v_8_2_2({(else_7_else_1_else_acc_2_itm[8:1]) , mut_30_sg1_1},
          and_419_cse);
      else_7_else_1_else_div_3cyc_st_1 <= MUX_v_2_2_2({else_7_else_1_else_acc_tmp
          , else_7_else_1_else_div_3cyc_st_1}, and_419_cse);
      else_7_else_1_equal_svs_st_1 <= MUX_s_1_2_2({else_7_else_1_equal_tmp , else_7_else_1_equal_svs_st_1},
          and_419_cse);
      else_7_equal_svs_st_1 <= MUX_s_1_2_2({else_7_equal_tmp , else_7_equal_svs_st_1},
          and_419_cse);
      max_sg1_lpi_dfm_3_st_1 <= MUX_v_10_2_2({mux1h_26_tmp , max_sg1_lpi_dfm_3_st_1},
          and_419_cse);
      acc_2_psp_sva_st_1 <= acc_itm[10:1];
      else_7_if_div_2cyc <= MUX_s_1_2_2({(~ else_7_if_div_2cyc) , else_7_if_div_2cyc},
          not_tmp_125);
      else_7_if_1_div_3cyc <= MUX_v_2_2_2({else_7_if_1_acc_tmp , else_7_if_1_div_3cyc},
          ~((~(and_dcpl_397 & and_dcpl_395 & and_dcpl_393 & and_dcpl_391)) & else_7_equal_tmp));
      else_7_else_1_if_div_3cyc <= MUX_v_2_2_2({else_7_else_1_if_acc_tmp , else_7_else_1_if_div_3cyc},
          and_419_cse | else_7_equal_tmp | (~ else_7_else_1_equal_tmp));
      else_7_else_1_else_div_3cyc <= MUX_v_2_2_2({else_7_else_1_else_acc_tmp , else_7_else_1_else_div_3cyc},
          and_419_cse | else_7_equal_tmp | else_7_else_1_equal_tmp);
      else_7_equal_svs <= MUX_s_1_2_2({else_7_equal_tmp , else_7_equal_svs}, and_419_cse);
      unequal_tmp_1 <= MUX_s_1_2_2({unequal_tmp_7 , unequal_tmp_1}, and_419_cse);
      main_stage_0_2 <= 1'b1;
      main_stage_0_3 <= main_stage_0_2;
      main_stage_0_4 <= main_stage_0_3;
      s_sg1_1_sva_2_duc <= MUX1HOT_v_10_3_2({(div_mgc_div_10_z[9:0]) , (div_mgc_div_9_z[9:0])
          , s_sg1_1_sva_2_duc}, {(and_tmp_9 & main_stage_0_3 & (~ else_7_if_div_2cyc_st_2))
          , (and_tmp_9 & main_stage_0_3 & else_7_if_div_2cyc_st_2) , (~(and_tmp_9
          & main_stage_0_3))});
      unequal_tmp_6 <= unequal_tmp_1;
      unequal_tmp_3 <= unequal_tmp_2;
      else_7_if_conc_1_tmp_mut_1_sg1 <= MUX_v_10_2_2({(acc_itm[10:1]) , else_7_if_conc_1_tmp_mut_1_sg1},
          or_dcpl_513);
      else_7_if_conc_1_tmp_mut_sg1 <= MUX_v_10_2_2({(acc_itm[10:1]) , else_7_if_conc_1_tmp_mut_sg1},
          or_dcpl_515);
      acc_5_itm_2 <= acc_5_itm_1;
      else_7_and_5_itm_2 <= else_7_and_5_itm_1;
      else_7_equal_svs_2 <= else_7_equal_svs;
      else_7_else_1_equal_svs_2 <= else_7_else_1_equal_svs_1;
      acc_5_itm_1 <= nl_acc_5_itm_1[7:0];
      else_7_and_5_itm_1 <= MUX_s_1_2_2({(else_7_else_1_equal_tmp & (~ else_7_equal_tmp))
          , else_7_and_5_itm_1}, and_419_cse);
      unequal_tmp_2 <= or_cse;
      else_7_else_1_equal_svs_1 <= else_7_else_1_equal_tmp;
      reg_div_mgc_div_7_b_tmp <= MUX1HOT_v_10_3_2({(acc_itm[10:1]) , mut_48_sg1_1
          , mut_49_sg1_1}, {and_256_cse , and_260_cse , mux_68_cse});
      reg_div_mgc_div_8_b_tmp <= MUX1HOT_v_10_3_2({(acc_itm[10:1]) , mut_52_sg1_1
          , mut_53_sg1_1}, {and_270_cse , and_274_cse , mux_72_cse});
      reg_div_mgc_div_b_tmp <= MUX1HOT_v_10_3_2({(acc_itm[10:1]) , mut_20_sg1_1 ,
          mut_21_sg1_1}, {and_284_cse , and_288_cse , mux_75_cse});
      reg_div_mgc_div_4_b_tmp <= MUX1HOT_v_10_3_2({(acc_itm[10:1]) , mut_36_sg1_1
          , mut_37_sg1_1}, {and_299_cse , and_304_cse , and_305_cse});
      reg_div_mgc_div_5_b_tmp <= MUX1HOT_v_10_3_2({(acc_itm[10:1]) , mut_40_sg1_1
          , mut_41_sg1_1}, {and_319_cse , and_324_cse , and_325_cse});
      reg_div_mgc_div_6_b_tmp <= MUX1HOT_v_10_3_2({(acc_itm[10:1]) , mut_44_sg1_1
          , mut_45_sg1_1}, {and_339_cse , and_344_cse , and_345_cse});
      reg_div_mgc_div_1_b_tmp <= MUX1HOT_v_10_3_2({(acc_itm[10:1]) , mut_24_sg1_1
          , mut_25_sg1_1}, {and_359_cse , and_364_cse , mux_81_cse});
      reg_div_mgc_div_2_b_tmp <= MUX1HOT_v_10_3_2({(acc_itm[10:1]) , mut_28_sg1_1
          , mut_29_sg1_1}, {and_377_cse , and_382_cse , mux_84_cse});
      reg_div_mgc_div_3_b_tmp <= MUX1HOT_v_10_3_2({(acc_itm[10:1]) , mut_32_sg1_1
          , mut_33_sg1_1}, {and_395_cse , and_400_cse , mux_87_cse});
    end
  end
  assign nl_acc_4_itm_1  = conv_u2u_7_8(mul_1_itm[9:3]) + conv_u2u_1_8(mul_1_itm[2]);
  assign nl_acc_5_itm_1  = conv_u2u_7_8(mul_itm[12:6]) + conv_u2u_1_8(mul_itm[5]);

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


  function [7:0] MUX_v_8_2_2;
    input [15:0] inputs;
    input [0:0] sel;
    reg [7:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[15:8];
      end
      1'b1 : begin
        result = inputs[7:0];
      end
      default : begin
        result = inputs[15:8];
      end
    endcase
    MUX_v_8_2_2 = result;
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


  function [4:0] MUX1HOT_v_5_3_2;
    input [14:0] inputs;
    input [2:0] sel;
    reg [4:0] result;
    integer i;
  begin
    result = inputs[0+:5] & {5{sel[0]}};
    for( i = 1; i < 3; i = i + 1 )
      result = result | (inputs[i*5+:5] & {5{sel[i]}});
    MUX1HOT_v_5_3_2 = result;
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


  function [1:0] MUX1HOT_v_2_6_2;
    input [11:0] inputs;
    input [5:0] sel;
    reg [1:0] result;
    integer i;
  begin
    result = inputs[0+:2] & {2{sel[0]}};
    for( i = 1; i < 6; i = i + 1 )
      result = result | (inputs[i*2+:2] & {2{sel[i]}});
    MUX1HOT_v_2_6_2 = result;
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


  function [5:0] MUX_v_6_2_2;
    input [11:0] inputs;
    input [0:0] sel;
    reg [5:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[11:6];
      end
      1'b1 : begin
        result = inputs[5:0];
      end
      default : begin
        result = inputs[11:6];
      end
    endcase
    MUX_v_6_2_2 = result;
  end
  endfunction


  function [8:0] signext_9_8;
    input [7:0] vector;
  begin
    signext_9_8= {{1{vector[7]}}, vector};
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


  function  [12:0] conv_u2u_10_13 ;
    input [9:0]  vector ;
  begin
    conv_u2u_10_13 = {{3{1'b0}}, vector};
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
  wire [15:0] div_mgc_div_a;
  wire [15:0] div_mgc_div_b;
  wire [15:0] div_mgc_div_z;
  wire [15:0] div_mgc_div_1_a;
  wire [15:0] div_mgc_div_1_b;
  wire [15:0] div_mgc_div_1_z;
  wire [15:0] div_mgc_div_2_a;
  wire [15:0] div_mgc_div_2_b;
  wire [15:0] div_mgc_div_2_z;
  wire [15:0] div_mgc_div_3_a;
  wire [15:0] div_mgc_div_3_b;
  wire [15:0] div_mgc_div_3_z;
  wire [15:0] div_mgc_div_4_a;
  wire [15:0] div_mgc_div_4_b;
  wire [15:0] div_mgc_div_4_z;
  wire [15:0] div_mgc_div_5_a;
  wire [15:0] div_mgc_div_5_b;
  wire [15:0] div_mgc_div_5_z;
  wire [15:0] div_mgc_div_6_a;
  wire [15:0] div_mgc_div_6_b;
  wire [15:0] div_mgc_div_6_z;
  wire [15:0] div_mgc_div_7_a;
  wire [15:0] div_mgc_div_7_b;
  wire [15:0] div_mgc_div_7_z;
  wire [15:0] div_mgc_div_8_a;
  wire [15:0] div_mgc_div_8_b;
  wire [15:0] div_mgc_div_8_z;
  wire [14:0] div_mgc_div_9_a;
  wire [9:0] div_mgc_div_9_b;
  wire [14:0] div_mgc_div_9_z;
  wire [14:0] div_mgc_div_10_a;
  wire [9:0] div_mgc_div_10_b;
  wire [14:0] div_mgc_div_10_z;


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
  mgc_div #(.width_a(16),
  .width_b(16),
  .signd(1)) div_mgc_div (
      .a(div_mgc_div_a),
      .b(div_mgc_div_b),
      .z(div_mgc_div_z)
    );
  mgc_div #(.width_a(16),
  .width_b(16),
  .signd(1)) div_mgc_div_1 (
      .a(div_mgc_div_1_a),
      .b(div_mgc_div_1_b),
      .z(div_mgc_div_1_z)
    );
  mgc_div #(.width_a(16),
  .width_b(16),
  .signd(1)) div_mgc_div_2 (
      .a(div_mgc_div_2_a),
      .b(div_mgc_div_2_b),
      .z(div_mgc_div_2_z)
    );
  mgc_div #(.width_a(16),
  .width_b(16),
  .signd(1)) div_mgc_div_3 (
      .a(div_mgc_div_3_a),
      .b(div_mgc_div_3_b),
      .z(div_mgc_div_3_z)
    );
  mgc_div #(.width_a(16),
  .width_b(16),
  .signd(1)) div_mgc_div_4 (
      .a(div_mgc_div_4_a),
      .b(div_mgc_div_4_b),
      .z(div_mgc_div_4_z)
    );
  mgc_div #(.width_a(16),
  .width_b(16),
  .signd(1)) div_mgc_div_5 (
      .a(div_mgc_div_5_a),
      .b(div_mgc_div_5_b),
      .z(div_mgc_div_5_z)
    );
  mgc_div #(.width_a(16),
  .width_b(16),
  .signd(1)) div_mgc_div_6 (
      .a(div_mgc_div_6_a),
      .b(div_mgc_div_6_b),
      .z(div_mgc_div_6_z)
    );
  mgc_div #(.width_a(16),
  .width_b(16),
  .signd(1)) div_mgc_div_7 (
      .a(div_mgc_div_7_a),
      .b(div_mgc_div_7_b),
      .z(div_mgc_div_7_z)
    );
  mgc_div #(.width_a(16),
  .width_b(16),
  .signd(1)) div_mgc_div_8 (
      .a(div_mgc_div_8_a),
      .b(div_mgc_div_8_b),
      .z(div_mgc_div_8_z)
    );
  mgc_div #(.width_a(15),
  .width_b(10),
  .signd(0)) div_mgc_div_9 (
      .a(div_mgc_div_9_a),
      .b(div_mgc_div_9_b),
      .z(div_mgc_div_9_z)
    );
  mgc_div #(.width_a(15),
  .width_b(10),
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
      .div_mgc_div_10_z(div_mgc_div_10_z)
    );
endmodule



