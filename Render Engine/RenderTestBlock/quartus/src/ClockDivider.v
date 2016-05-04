module clk_div(clk_50mhz, rst_n, clk_60hz);
   input clk_50mhz, rst_n;
   output      clk_60hz;
   reg         clk_60hz;
   
   reg [47:0]  counter;

   always @(posedge clk_50mhz or negedge rst_n) begin
      if (!rst_n) begin
         counter <= 48'h00000;
         clk_60hz <= 1'b0;
      end else begin
        if (counter == 48'h65B9A) begin
           counter <= 48'h00000;
           clk_60hz <= ~clk_60hz;
        end else begin
           counter <= counter + 1'b1;
        end
      end // else: !if(!rst_n)
   end // always @ (posedge clk_50mhz or negedge rst_n)
endmodule // clk_div