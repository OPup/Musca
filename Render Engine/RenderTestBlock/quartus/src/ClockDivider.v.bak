module clk_div(clk_50mhz, rst_n, clk_60hz);
input clk_50mhz, rst_n;
output clk_60hz;
reg clk_60hz;

reg [47:0] counter;

always @(posedge clk_50mhz or negedge rst_n) begin
if (!rst_n) begin
counter clk_60hz end else begin
if (counter == 48'h65B9A) begin
counter clk_60hz end else begin
counter end
end // else: !if(!rst_n)
end // always @ (posedge clk_50mhz or negedge rst_n)
endmodule // clk_div