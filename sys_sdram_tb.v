module sys_sdram_tb(
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

reg stage;

always @ (posedge clk_in) begin
  if (!zusr_key) begin
    // reset
    stage <= 0;
    addr <= 0;
    valid <= 1;
    wdata <= 'h11111111;
    wstrb <= 'hf;
  end
  if (zusr_key) begin
    if (valid && ready) begin
      if (stage == 0) begin
        stage <= 1;
        wdata <= wdata + 1;
        wstrb <= 'hf;
      end
      if (stage == 1) begin
        stage <= 0;
        addr <= addr + 1;
        wstrb <= 'h0;
      end
    end
  end
end

endmodule
