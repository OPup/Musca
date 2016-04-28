
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
//  Generated date: Wed Apr 27 18:34:21 2016
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
      div_mgc_div_7_b, div_mgc_div_7_z
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
  output [10:0] div_mgc_div_a;
  reg [10:0] div_mgc_div_a;
  output [10:0] div_mgc_div_b;
  input [10:0] div_mgc_div_z;
  output [10:0] div_mgc_div_1_a;
  reg [10:0] div_mgc_div_1_a;
  output [10:0] div_mgc_div_1_b;
  input [10:0] div_mgc_div_1_z;
  output [10:0] div_mgc_div_2_a;
  reg [10:0] div_mgc_div_2_a;
  output [10:0] div_mgc_div_2_b;
  input [10:0] div_mgc_div_2_z;
  output [10:0] div_mgc_div_3_a;
  reg [10:0] div_mgc_div_3_a;
  output [10:0] div_mgc_div_3_b;
  input [10:0] div_mgc_div_3_z;
  output [10:0] div_mgc_div_4_a;
  reg [10:0] div_mgc_div_4_a;
  output [10:0] div_mgc_div_4_b;
  input [10:0] div_mgc_div_4_z;
  output [10:0] div_mgc_div_5_a;
  reg [10:0] div_mgc_div_5_a;
  output [10:0] div_mgc_div_5_b;
  input [10:0] div_mgc_div_5_z;
  output [9:0] div_mgc_div_6_a;
  reg [9:0] div_mgc_div_6_a;
  output [9:0] div_mgc_div_6_b;
  reg [9:0] div_mgc_div_6_b;
  input [9:0] div_mgc_div_6_z;
  output [9:0] div_mgc_div_7_a;
  reg [9:0] div_mgc_div_7_a;
  output [9:0] div_mgc_div_7_b;
  reg [9:0] div_mgc_div_7_b;
  input [9:0] div_mgc_div_7_z;


  // Interconnect Declarations
  wire else_7_else_1_equal_tmp;
  wire else_7_equal_tmp;
  wire equal_tmp;
  wire [9:0] mux1h_2_tmp;
  wire or_dcpl_11;
  wire or_dcpl_13;
  wire or_dcpl_15;
  wire or_dcpl_17;
  wire and_dcpl_39;
  wire or_dcpl_59;
  reg else_7_if_div_2cyc;
  reg [7:0] s_sg1_sva_2_duc;
  reg else_7_if_1_div_2cyc;
  reg else_7_else_1_if_div_2cyc;
  reg else_7_else_1_else_div_2cyc;
  reg [9:0] delta_sva_mut;
  reg [9:0] max_lpi_dfm_3_mut;
  reg [9:0] delta_sva_mut_1;
  reg [9:0] max_lpi_dfm_3_mut_1;
  reg else_7_else_1_equal_svs_1;
  reg equal_svs_2;
  reg unequal_tmp_1;
  reg unequal_tmp_2;
  reg else_7_equal_svs_2;
  reg [10:0] else_7_else_1_else_slc_tmp_mut_2;
  reg [10:0] else_7_else_1_if_slc_tmp_mut_2;
  reg [10:0] else_7_if_1_slc_tmp_mut_3;
  reg else_7_if_div_2cyc_st;
  reg [8:0] acc_4_itm_1;
  wire [9:0] nl_acc_4_itm_1;
  reg [8:0] acc_4_itm_2;
  reg equal_svs_st_1;
  reg [9:0] max_lpi_dfm_3_st_1;
  reg else_7_if_div_2cyc_st_1;
  reg [9:0] max_lpi_dfm_3_st_2;
  reg else_7_if_div_2cyc_st_2;
  reg else_7_equal_svs_st_1;
  reg else_7_if_1_div_2cyc_st_2;
  reg else_7_else_1_equal_svs_st_2;
  reg else_7_else_1_if_div_2cyc_st_2;
  reg else_7_else_1_else_div_2cyc_st_2;
  reg main_stage_0_2;
  reg main_stage_0_3;
  reg [9:0] mut_23;
  wire or_35_cse;
  wire and_49_cse;
  wire or_57_cse;
  wire and_73_cse;
  wire or_61_cse;
  wire or_64_cse;
  reg [9:0] reg_div_mgc_div_5_b_reg;
  reg [9:0] reg_div_mgc_div_b_reg;
  reg [9:0] reg_div_mgc_div_3_b_reg;
  reg [9:0] reg_div_mgc_div_4_b_reg;
  reg [9:0] reg_div_mgc_div_1_b_reg;
  reg [9:0] reg_div_mgc_div_2_b_reg;
  wire [5:0] else_7_if_1_ac_fixed_cctor_sg1_1_sva_duc_mx0;
  wire [5:0] div_sdt_2_sva_duc_mx0;
  wire [4:0] else_7_else_1_if_ac_fixed_cctor_sg2_1_sva;
  wire [5:0] nl_else_7_else_1_if_ac_fixed_cctor_sg2_1_sva;
  wire [5:0] div_sdt_3_sva_duc_mx0;
  wire [3:0] else_7_else_1_else_ac_fixed_cctor_sg2_1_sva;
  wire [4:0] nl_else_7_else_1_else_ac_fixed_cctor_sg2_1_sva;
  wire h_sg3_lpi_dfm_1_mx0;
  wire h_sg2_lpi_dfm_1_mx0;
  wire [9:0] g_1_lpi_dfm;
  wire [9:0] b_1_lpi_dfm;
  wire [9:0] r_1_lpi_dfm;
  wire unequal_tmp;
  wire [9:0] min_lpi_dfm_3;
  wire [6:0] else_7_acc_itm;
  wire [7:0] nl_else_7_acc_itm;
  wire [10:0] else_7_acc_4_itm;
  wire [11:0] nl_else_7_acc_4_itm;
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
  wire [9:0] acc_5_itm;
  wire [10:0] nl_acc_5_itm;

  wire[2:0] else_7_mux1h_nl;
  wire[0:0] else_7_mux_4_nl;
  wire[0:0] else_7_else_1_mux_nl;
  wire[0:0] else_7_else_1_mux_3_nl;
  wire[0:0] else_7_else_1_mux_4_nl;

  // Interconnect Declarations for Component Instantiations 
  assign or_35_cse = or_dcpl_17 | or_dcpl_15 | or_dcpl_13 | or_dcpl_11;
  assign and_49_cse = (~((max_lpi_dfm_3_st_2[9]) | (max_lpi_dfm_3_st_2[8]) | (max_lpi_dfm_3_st_2[7])))
      & (~((max_lpi_dfm_3_st_2[6]) | (max_lpi_dfm_3_st_2[5]))) & (~((max_lpi_dfm_3_st_2[4])
      | (max_lpi_dfm_3_st_2[3]) | (max_lpi_dfm_3_st_2[2]))) & (~((max_lpi_dfm_3_st_2[1])
      | (max_lpi_dfm_3_st_2[0])));
  assign and_73_cse = (~((mux1h_2_tmp[0]) | (mux1h_2_tmp[1]) | (mux1h_2_tmp[2])))
      & (~((mux1h_2_tmp[3]) | (mux1h_2_tmp[4]))) & (~((mux1h_2_tmp[5]) | (mux1h_2_tmp[6])
      | (mux1h_2_tmp[7]))) & (~((mux1h_2_tmp[8]) | (mux1h_2_tmp[9])));
  assign or_57_cse = and_73_cse | equal_tmp | (~ else_7_if_div_2cyc);
  assign or_61_cse = and_73_cse | equal_tmp | else_7_if_div_2cyc;
  assign div_mgc_div_5_b = {1'b0, reg_div_mgc_div_5_b_reg};
  assign div_mgc_div_b = {1'b0, reg_div_mgc_div_b_reg};
  assign div_mgc_div_3_b = {1'b0, reg_div_mgc_div_3_b_reg};
  assign div_mgc_div_4_b = {1'b0, reg_div_mgc_div_4_b_reg};
  assign div_mgc_div_1_b = {1'b0, reg_div_mgc_div_1_b_reg};
  assign div_mgc_div_2_b = {1'b0, reg_div_mgc_div_2_b_reg};
  assign or_64_cse = and_73_cse | equal_tmp;
  assign else_7_mux1h_nl = MUX1HOT_v_3_3_2({(else_7_else_1_else_ac_fixed_cctor_sg2_1_sva[3:1])
      , (else_7_else_1_if_ac_fixed_cctor_sg2_1_sva[4:2]) , (else_7_if_1_ac_fixed_cctor_sg1_1_sva_duc_mx0[5:3])},
      {(~(else_7_else_1_equal_svs_st_2 | else_7_equal_svs_2)) , (else_7_else_1_equal_svs_st_2
      & (~ else_7_equal_svs_2)) , else_7_equal_svs_2});
  assign else_7_else_1_mux_nl = MUX_s_1_2_2({(else_7_else_1_else_ac_fixed_cctor_sg2_1_sva[0])
      , (else_7_else_1_if_ac_fixed_cctor_sg2_1_sva[1])}, else_7_else_1_equal_svs_st_2);
  assign else_7_mux_4_nl = MUX_s_1_2_2({(else_7_else_1_mux_nl) , (else_7_if_1_ac_fixed_cctor_sg1_1_sva_duc_mx0[2])},
      else_7_equal_svs_2);
  assign nl_else_7_acc_itm = ({(~ (else_7_mux1h_nl)) , (~ (else_7_mux_4_nl)) , (~
      h_sg3_lpi_dfm_1_mx0) , (~ h_sg2_lpi_dfm_1_mx0) , 1'b1}) + ({h_sg3_lpi_dfm_1_mx0
      , h_sg2_lpi_dfm_1_mx0 , 5'b1});
  assign else_7_acc_itm = nl_else_7_acc_itm[6:0];
  assign else_7_if_1_ac_fixed_cctor_sg1_1_sva_duc_mx0 = MUX_v_6_2_2({(div_mgc_div_5_z[5:0])
      , (div_mgc_div_z[5:0])}, else_7_if_1_div_2cyc_st_2);
  assign div_sdt_2_sva_duc_mx0 = MUX_v_6_2_2({(div_mgc_div_3_z[5:0]) , (div_mgc_div_4_z[5:0])},
      else_7_else_1_if_div_2cyc_st_2);
  assign nl_else_7_else_1_if_ac_fixed_cctor_sg2_1_sva = (div_sdt_2_sva_duc_mx0[5:1])
      + 5'b1;
  assign else_7_else_1_if_ac_fixed_cctor_sg2_1_sva = nl_else_7_else_1_if_ac_fixed_cctor_sg2_1_sva[4:0];
  assign div_sdt_3_sva_duc_mx0 = MUX_v_6_2_2({(div_mgc_div_1_z[5:0]) , (div_mgc_div_2_z[5:0])},
      else_7_else_1_else_div_2cyc_st_2);
  assign nl_else_7_else_1_else_ac_fixed_cctor_sg2_1_sva = (div_sdt_3_sva_duc_mx0[5:2])
      + 4'b1;
  assign else_7_else_1_else_ac_fixed_cctor_sg2_1_sva = nl_else_7_else_1_else_ac_fixed_cctor_sg2_1_sva[3:0];
  assign else_7_else_1_mux_3_nl = MUX_s_1_2_2({(div_sdt_3_sva_duc_mx0[1]) , (else_7_else_1_if_ac_fixed_cctor_sg2_1_sva[0])},
      else_7_else_1_equal_svs_st_2);
  assign h_sg3_lpi_dfm_1_mx0 = MUX_s_1_2_2({(else_7_else_1_mux_3_nl) , (else_7_if_1_ac_fixed_cctor_sg1_1_sva_duc_mx0[1])},
      else_7_equal_svs_2);
  assign else_7_else_1_mux_4_nl = MUX_s_1_2_2({(div_sdt_3_sva_duc_mx0[0]) , (div_sdt_2_sva_duc_mx0[0])},
      else_7_else_1_equal_svs_st_2);
  assign h_sg2_lpi_dfm_1_mx0 = MUX_s_1_2_2({(else_7_else_1_mux_4_nl) , (else_7_if_1_ac_fixed_cctor_sg1_1_sva_duc_mx0[0])},
      else_7_equal_svs_2);
  assign nl_else_7_acc_4_itm = ({mux1h_2_tmp , 1'b1}) + ({(~ min_lpi_dfm_3) , 1'b1});
  assign else_7_acc_4_itm = nl_else_7_acc_4_itm[10:0];
  assign nl_else_7_if_1_acc_1_itm = ({1'b1 , g_1_lpi_dfm , 1'b1}) + conv_u2s_11_12({(~
      b_1_lpi_dfm) , 1'b1});
  assign else_7_if_1_acc_1_itm = nl_else_7_if_1_acc_1_itm[11:0];
  assign nl_else_7_else_1_if_acc_2_itm = ({1'b1 , b_1_lpi_dfm , 1'b1}) + conv_u2s_11_12({(~
      r_1_lpi_dfm) , 1'b1});
  assign else_7_else_1_if_acc_2_itm = nl_else_7_else_1_if_acc_2_itm[11:0];
  assign nl_else_7_else_1_else_acc_2_itm = ({1'b1 , r_1_lpi_dfm , 1'b1}) + conv_u2s_11_12({(~
      g_1_lpi_dfm) , 1'b1});
  assign else_7_else_1_else_acc_2_itm = nl_else_7_else_1_else_acc_2_itm[11:0];
  assign else_7_equal_tmp = r_1_lpi_dfm == mux1h_2_tmp;
  assign equal_tmp = mux1h_2_tmp == min_lpi_dfm_3;
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
  assign mux1h_2_tmp = MUX1HOT_v_10_3_2({r_rsc_mgc_in_wire_d , b_rsc_mgc_in_wire_d
      , g_rsc_mgc_in_wire_d}, {(~((if_if_acc_itm[11]) | (if_acc_1_itm[11]))) , (((if_if_acc_itm[11])
      & (~ (if_acc_1_itm[11]))) | ((else_1_if_acc_itm[11]) & (if_acc_1_itm[11])))
      , ((~ (else_1_if_acc_itm[11])) & (if_acc_1_itm[11]))});
  assign g_1_lpi_dfm = g_rsc_mgc_in_wire_d & ({{9{unequal_tmp}}, unequal_tmp});
  assign b_1_lpi_dfm = b_rsc_mgc_in_wire_d & ({{9{unequal_tmp}}, unequal_tmp});
  assign r_1_lpi_dfm = r_rsc_mgc_in_wire_d & ({{9{unequal_tmp}}, unequal_tmp});
  assign unequal_tmp = (mux1h_2_tmp[9]) | (mux1h_2_tmp[8]) | (mux1h_2_tmp[7]) | (mux1h_2_tmp[6])
      | (mux1h_2_tmp[5]) | (mux1h_2_tmp[4]) | (mux1h_2_tmp[3]) | (mux1h_2_tmp[2])
      | (mux1h_2_tmp[1]) | (mux1h_2_tmp[0]);
  assign min_lpi_dfm_3 = MUX1HOT_v_10_3_2({r_rsc_mgc_in_wire_d , b_rsc_mgc_in_wire_d
      , g_rsc_mgc_in_wire_d}, {(~((if_3_if_acc_itm[11]) | (if_3_acc_1_itm[11])))
      , (((if_3_if_acc_itm[11]) & (~ (if_3_acc_1_itm[11]))) | ((else_5_if_acc_itm[11])
      & (if_3_acc_1_itm[11]))) , ((~ (else_5_if_acc_itm[11])) & (if_3_acc_1_itm[11]))});
  assign nl_if_3_acc_1_itm = ({1'b1 , g_rsc_mgc_in_wire_d , 1'b1}) + conv_u2u_11_12({(~
      r_rsc_mgc_in_wire_d) , 1'b1});
  assign if_3_acc_1_itm = nl_if_3_acc_1_itm[11:0];
  assign nl_if_acc_1_itm = ({1'b1 , r_rsc_mgc_in_wire_d , 1'b1}) + conv_u2u_11_12({(~
      g_rsc_mgc_in_wire_d) , 1'b1});
  assign if_acc_1_itm = nl_if_acc_1_itm[11:0];
  assign else_7_else_1_equal_tmp = g_1_lpi_dfm == mux1h_2_tmp;
  assign nl_acc_5_itm = conv_u2u_9_10(mux1h_2_tmp[9:1]) + mux1h_2_tmp;
  assign acc_5_itm = nl_acc_5_itm[9:0];
  assign or_dcpl_11 = (max_lpi_dfm_3_st_2[1]) | (max_lpi_dfm_3_st_2[0]);
  assign or_dcpl_13 = (max_lpi_dfm_3_st_2[4]) | (max_lpi_dfm_3_st_2[3]) | (max_lpi_dfm_3_st_2[2]);
  assign or_dcpl_15 = (max_lpi_dfm_3_st_2[6]) | (max_lpi_dfm_3_st_2[5]);
  assign or_dcpl_17 = (max_lpi_dfm_3_st_2[9]) | (max_lpi_dfm_3_st_2[8]) | (max_lpi_dfm_3_st_2[7]);
  assign and_dcpl_39 = main_stage_0_3 & (~ equal_svs_2);
  assign or_dcpl_59 = equal_tmp | else_7_equal_tmp;
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      V_OUT_rsc_mgc_out_stdreg_d <= 10'b0;
      S_OUT_rsc_mgc_out_stdreg_d <= 10'b0;
      H_OUT_rsc_mgc_out_stdreg_d <= 10'b0;
      s_sg1_sva_2_duc <= 8'b0;
      else_7_if_div_2cyc_st_2 <= 1'b0;
      else_7_if_1_div_2cyc_st_2 <= 1'b0;
      else_7_else_1_if_div_2cyc_st_2 <= 1'b0;
      else_7_else_1_else_div_2cyc_st_2 <= 1'b0;
      else_7_else_1_equal_svs_st_2 <= 1'b0;
      else_7_equal_svs_2 <= 1'b0;
      unequal_tmp_2 <= 1'b0;
      max_lpi_dfm_3_st_2 <= 10'b0;
      acc_4_itm_2 <= 9'b0;
      equal_svs_2 <= 1'b0;
      div_mgc_div_7_b <= 10'b0;
      div_mgc_div_7_a <= 10'b0;
      div_mgc_div_6_b <= 10'b0;
      div_mgc_div_6_a <= 10'b0;
      reg_div_mgc_div_5_b_reg <= 10'b0;
      div_mgc_div_5_a <= 11'b0;
      reg_div_mgc_div_b_reg <= 10'b0;
      div_mgc_div_a <= 11'b0;
      reg_div_mgc_div_3_b_reg <= 10'b0;
      div_mgc_div_3_a <= 11'b0;
      reg_div_mgc_div_4_b_reg <= 10'b0;
      div_mgc_div_4_a <= 11'b0;
      reg_div_mgc_div_1_b_reg <= 10'b0;
      div_mgc_div_1_a <= 11'b0;
      reg_div_mgc_div_2_b_reg <= 10'b0;
      div_mgc_div_2_a <= 11'b0;
      else_7_if_div_2cyc_st_1 <= 1'b0;
      mut_23 <= 10'b0;
      else_7_if_1_slc_tmp_mut_3 <= 11'b0;
      else_7_else_1_if_slc_tmp_mut_2 <= 11'b0;
      else_7_else_1_else_slc_tmp_mut_2 <= 11'b0;
      else_7_equal_svs_st_1 <= 1'b0;
      max_lpi_dfm_3_st_1 <= 10'b0;
      equal_svs_st_1 <= 1'b0;
      else_7_if_div_2cyc <= 1'b0;
      else_7_if_1_div_2cyc <= 1'b0;
      else_7_else_1_if_div_2cyc <= 1'b0;
      else_7_else_1_else_div_2cyc <= 1'b0;
      main_stage_0_2 <= 1'b0;
      main_stage_0_3 <= 1'b0;
      max_lpi_dfm_3_mut_1 <= 10'b0;
      delta_sva_mut_1 <= 10'b0;
      max_lpi_dfm_3_mut <= 10'b0;
      delta_sva_mut <= 10'b0;
      else_7_if_div_2cyc_st <= 1'b0;
      acc_4_itm_1 <= 9'b0;
      unequal_tmp_1 <= 1'b0;
      else_7_else_1_equal_svs_1 <= 1'b0;
    end
    else begin
      V_OUT_rsc_mgc_out_stdreg_d <= MUX_v_10_2_2({V_OUT_rsc_mgc_out_stdreg_d , ({1'b0
          , acc_4_itm_2})}, main_stage_0_3);
      S_OUT_rsc_mgc_out_stdreg_d <= MUX_v_10_2_2({S_OUT_rsc_mgc_out_stdreg_d , ({conv_s2u_16_8(8'b11001
          * ((MUX1HOT_v_8_3_2({(div_mgc_div_7_z[7:0]) , (div_mgc_div_6_z[7:0]) ,
          s_sg1_sva_2_duc}, {(~((~(or_dcpl_17 | or_dcpl_15 | or_dcpl_13 | or_dcpl_11))
          | else_7_if_div_2cyc_st_2)) , (or_35_cse & else_7_if_div_2cyc_st_2) , and_49_cse}))
          & ({{7{unequal_tmp_2}}, unequal_tmp_2}) & (signext_8_1(~ equal_svs_2))))
          , 2'b0})}, main_stage_0_3);
      H_OUT_rsc_mgc_out_stdreg_d <= MUX_v_10_2_2({H_OUT_rsc_mgc_out_stdreg_d , ({2'b0
          , ((else_7_acc_itm[6:2]) & (signext_5_1(~ equal_svs_2))) , ((else_7_acc_itm[1])
          & (~ equal_svs_2)) , 2'b0})}, main_stage_0_3);
      s_sg1_sva_2_duc <= MUX1HOT_v_8_3_2({(div_mgc_div_7_z[7:0]) , (div_mgc_div_6_z[7:0])
          , s_sg1_sva_2_duc}, {(or_35_cse & and_dcpl_39 & (~ else_7_if_div_2cyc_st_2))
          , (or_35_cse & and_dcpl_39 & else_7_if_div_2cyc_st_2) , (and_49_cse | (~
          main_stage_0_3) | equal_svs_2)});
      else_7_if_div_2cyc_st_2 <= else_7_if_div_2cyc_st_1;
      else_7_if_1_div_2cyc_st_2 <= else_7_if_1_div_2cyc;
      else_7_else_1_if_div_2cyc_st_2 <= else_7_else_1_if_div_2cyc;
      else_7_else_1_else_div_2cyc_st_2 <= else_7_else_1_else_div_2cyc;
      else_7_else_1_equal_svs_st_2 <= else_7_else_1_equal_svs_1;
      else_7_equal_svs_2 <= else_7_equal_svs_st_1;
      unequal_tmp_2 <= unequal_tmp_1;
      max_lpi_dfm_3_st_2 <= max_lpi_dfm_3_st_1;
      acc_4_itm_2 <= acc_4_itm_1;
      equal_svs_2 <= equal_svs_st_1;
      div_mgc_div_7_b <= MUX_v_10_2_2({mux1h_2_tmp , max_lpi_dfm_3_mut_1}, or_57_cse);
      div_mgc_div_7_a <= MUX_v_10_2_2({(else_7_acc_4_itm[10:1]) , delta_sva_mut_1},
          or_57_cse);
      div_mgc_div_6_b <= MUX_v_10_2_2({mux1h_2_tmp , max_lpi_dfm_3_mut}, or_61_cse);
      div_mgc_div_6_a <= MUX_v_10_2_2({(else_7_acc_4_itm[10:1]) , delta_sva_mut},
          or_61_cse);
      reg_div_mgc_div_5_b_reg <= MUX_v_10_2_2({mut_23 , (else_7_acc_4_itm[10:1])},
          else_7_if_1_div_2cyc);
      div_mgc_div_5_a <= MUX_v_11_2_2({else_7_if_1_slc_tmp_mut_3 , (else_7_if_1_acc_1_itm[11:1])},
          else_7_if_1_div_2cyc);
      reg_div_mgc_div_b_reg <= MUX_v_10_2_2({(else_7_acc_4_itm[10:1]) , mut_23},
          else_7_if_1_div_2cyc);
      div_mgc_div_a <= MUX_v_11_2_2({(else_7_if_1_acc_1_itm[11:1]) , else_7_if_1_slc_tmp_mut_3},
          else_7_if_1_div_2cyc);
      reg_div_mgc_div_3_b_reg <= MUX_v_10_2_2({mut_23 , (else_7_acc_4_itm[10:1])},
          else_7_else_1_if_div_2cyc);
      div_mgc_div_3_a <= MUX_v_11_2_2({else_7_else_1_if_slc_tmp_mut_2 , (else_7_else_1_if_acc_2_itm[11:1])},
          else_7_else_1_if_div_2cyc);
      reg_div_mgc_div_4_b_reg <= MUX_v_10_2_2({(else_7_acc_4_itm[10:1]) , mut_23},
          else_7_else_1_if_div_2cyc);
      div_mgc_div_4_a <= MUX_v_11_2_2({(else_7_else_1_if_acc_2_itm[11:1]) , else_7_else_1_if_slc_tmp_mut_2},
          else_7_else_1_if_div_2cyc);
      reg_div_mgc_div_1_b_reg <= MUX_v_10_2_2({mut_23 , (else_7_acc_4_itm[10:1])},
          else_7_else_1_else_div_2cyc);
      div_mgc_div_1_a <= MUX_v_11_2_2({else_7_else_1_else_slc_tmp_mut_2 , (else_7_else_1_else_acc_2_itm[11:1])},
          else_7_else_1_else_div_2cyc);
      reg_div_mgc_div_2_b_reg <= MUX_v_10_2_2({(else_7_acc_4_itm[10:1]) , mut_23},
          else_7_else_1_else_div_2cyc);
      div_mgc_div_2_a <= MUX_v_11_2_2({(else_7_else_1_else_acc_2_itm[11:1]) , else_7_else_1_else_slc_tmp_mut_2},
          else_7_else_1_else_div_2cyc);
      else_7_if_div_2cyc_st_1 <= MUX_s_1_2_2({(~ else_7_if_div_2cyc) , else_7_if_div_2cyc_st},
          and_73_cse);
      mut_23 <= else_7_acc_4_itm[10:1];
      else_7_if_1_slc_tmp_mut_3 <= else_7_if_1_acc_1_itm[11:1];
      else_7_else_1_if_slc_tmp_mut_2 <= else_7_else_1_if_acc_2_itm[11:1];
      else_7_else_1_else_slc_tmp_mut_2 <= else_7_else_1_else_acc_2_itm[11:1];
      else_7_equal_svs_st_1 <= else_7_equal_tmp;
      max_lpi_dfm_3_st_1 <= mux1h_2_tmp;
      equal_svs_st_1 <= equal_tmp;
      else_7_if_div_2cyc <= MUX_s_1_2_2({(~ else_7_if_div_2cyc) , else_7_if_div_2cyc},
          or_64_cse);
      else_7_if_1_div_2cyc <= MUX_s_1_2_2({(~ else_7_if_1_div_2cyc) , else_7_if_1_div_2cyc},
          equal_tmp | (~ else_7_equal_tmp));
      else_7_else_1_if_div_2cyc <= MUX_s_1_2_2({(~ else_7_else_1_if_div_2cyc) , else_7_else_1_if_div_2cyc},
          or_dcpl_59 | (~ else_7_else_1_equal_tmp));
      else_7_else_1_else_div_2cyc <= MUX_s_1_2_2({(~ else_7_else_1_else_div_2cyc)
          , else_7_else_1_else_div_2cyc}, or_dcpl_59 | else_7_else_1_equal_tmp);
      main_stage_0_2 <= 1'b1;
      main_stage_0_3 <= main_stage_0_2;
      max_lpi_dfm_3_mut_1 <= MUX_v_10_2_2({mux1h_2_tmp , max_lpi_dfm_3_mut_1}, or_64_cse);
      delta_sva_mut_1 <= MUX_v_10_2_2({(else_7_acc_4_itm[10:1]) , delta_sva_mut_1},
          or_64_cse);
      max_lpi_dfm_3_mut <= MUX_v_10_2_2({mux1h_2_tmp , max_lpi_dfm_3_mut}, or_64_cse);
      delta_sva_mut <= MUX_v_10_2_2({(else_7_acc_4_itm[10:1]) , delta_sva_mut}, or_64_cse);
      else_7_if_div_2cyc_st <= MUX_s_1_2_2({(~ else_7_if_div_2cyc) , else_7_if_div_2cyc_st},
          or_64_cse);
      acc_4_itm_1 <= nl_acc_4_itm_1[8:0];
      unequal_tmp_1 <= unequal_tmp;
      else_7_else_1_equal_svs_1 <= else_7_else_1_equal_tmp;
    end
  end
  assign nl_acc_4_itm_1  = conv_u2u_8_9(acc_5_itm[9:2]) + conv_u2u_1_9(acc_5_itm[1]);

  function [2:0] MUX1HOT_v_3_3_2;
    input [8:0] inputs;
    input [2:0] sel;
    reg [2:0] result;
    integer i;
  begin
    result = inputs[0+:3] & {3{sel[0]}};
    for( i = 1; i < 3; i = i + 1 )
      result = result | (inputs[i*3+:3] & {3{sel[i]}});
    MUX1HOT_v_3_3_2 = result;
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


  function [7:0] signext_8_1;
    input [0:0] vector;
  begin
    signext_8_1= {{7{vector[0]}}, vector};
  end
  endfunction


  function [4:0] signext_5_1;
    input [0:0] vector;
  begin
    signext_5_1= {{4{vector[0]}}, vector};
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


  function  [9:0] conv_u2u_9_10 ;
    input [8:0]  vector ;
  begin
    conv_u2u_9_10 = {1'b0, vector};
  end
  endfunction


  function  [7:0] conv_s2u_16_8 ;
    input signed [15:0]  vector ;
  begin
    conv_s2u_16_8 = vector[7:0];
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
  wire [10:0] div_mgc_div_a;
  wire [10:0] div_mgc_div_b;
  wire [10:0] div_mgc_div_z;
  wire [10:0] div_mgc_div_1_a;
  wire [10:0] div_mgc_div_1_b;
  wire [10:0] div_mgc_div_1_z;
  wire [10:0] div_mgc_div_2_a;
  wire [10:0] div_mgc_div_2_b;
  wire [10:0] div_mgc_div_2_z;
  wire [10:0] div_mgc_div_3_a;
  wire [10:0] div_mgc_div_3_b;
  wire [10:0] div_mgc_div_3_z;
  wire [10:0] div_mgc_div_4_a;
  wire [10:0] div_mgc_div_4_b;
  wire [10:0] div_mgc_div_4_z;
  wire [10:0] div_mgc_div_5_a;
  wire [10:0] div_mgc_div_5_b;
  wire [10:0] div_mgc_div_5_z;
  wire [9:0] div_mgc_div_6_a;
  wire [9:0] div_mgc_div_6_b;
  wire [9:0] div_mgc_div_6_z;
  wire [9:0] div_mgc_div_7_a;
  wire [9:0] div_mgc_div_7_b;
  wire [9:0] div_mgc_div_7_z;


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
  mgc_div #(.width_a(11),
  .width_b(11),
  .signd(1)) div_mgc_div (
      .a(div_mgc_div_a),
      .b(div_mgc_div_b),
      .z(div_mgc_div_z)
    );
  mgc_div #(.width_a(11),
  .width_b(11),
  .signd(1)) div_mgc_div_1 (
      .a(div_mgc_div_1_a),
      .b(div_mgc_div_1_b),
      .z(div_mgc_div_1_z)
    );
  mgc_div #(.width_a(11),
  .width_b(11),
  .signd(1)) div_mgc_div_2 (
      .a(div_mgc_div_2_a),
      .b(div_mgc_div_2_b),
      .z(div_mgc_div_2_z)
    );
  mgc_div #(.width_a(11),
  .width_b(11),
  .signd(1)) div_mgc_div_3 (
      .a(div_mgc_div_3_a),
      .b(div_mgc_div_3_b),
      .z(div_mgc_div_3_z)
    );
  mgc_div #(.width_a(11),
  .width_b(11),
  .signd(1)) div_mgc_div_4 (
      .a(div_mgc_div_4_a),
      .b(div_mgc_div_4_b),
      .z(div_mgc_div_4_z)
    );
  mgc_div #(.width_a(11),
  .width_b(11),
  .signd(1)) div_mgc_div_5 (
      .a(div_mgc_div_5_a),
      .b(div_mgc_div_5_b),
      .z(div_mgc_div_5_z)
    );
  mgc_div #(.width_a(10),
  .width_b(10),
  .signd(0)) div_mgc_div_6 (
      .a(div_mgc_div_6_a),
      .b(div_mgc_div_6_b),
      .z(div_mgc_div_6_z)
    );
  mgc_div #(.width_a(10),
  .width_b(10),
  .signd(0)) div_mgc_div_7 (
      .a(div_mgc_div_7_a),
      .b(div_mgc_div_7_b),
      .z(div_mgc_div_7_z)
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
      .div_mgc_div_7_z(div_mgc_div_7_z)
    );
endmodule



