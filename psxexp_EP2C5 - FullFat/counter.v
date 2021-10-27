module counter(
    input clk,
    output reg [24:0] out,
    input reset
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        out <= 0;
    end else begin
        out <= out + 1;
    end
end

endmodule