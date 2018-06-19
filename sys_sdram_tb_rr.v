module sys_sdram_tb_rr(
    input clk_in,
    input zusr_key
);


    reg valid; // synthesis keep
    wire ready; // synthesis keep
    reg [31:0] addr; // synthesis keep
    reg [31:0] wdata; // synthesis keep
    reg [3:0] wstrb; // synthesis keep
    wire [31:0] rdata; // synthesis keep

sys_sdram (
    .clk(clk_in),
    .rst_n(zusr_key),
    .i_valid(valid),
    .o_ready(ready),
    .i_addr(addr),
    .i_wdata(wdata),
    .i_wstrb(wstrb),
    .o_rdata(rdata)
);

always @ (posedge clk_in) begin
  if (!zusr_key) begin
    // reset
    addr <= 0;
    valid <= 1;
    wdata <= 'h0;
    wstrb <= 'h0;
  end
  if (zusr_key) begin
    if (valid && ready) begin
      addr <= addr + 1;
    end
  end
end

endmodule
