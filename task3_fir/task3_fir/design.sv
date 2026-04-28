module fir_filter (
    input clk,
    input reset,
    input signed [7:0] x_in,
    output reg signed [18:0] y_out
);

parameter signed [7:0] h0 = 8'd1;
parameter signed [7:0] h1 = 8'd2;
parameter signed [7:0] h2 = 8'd2;
parameter signed [7:0] h3 = 8'd1;

reg signed [7:0] x0, x1, x2, x3;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        x0 <= 0; x1 <= 0;
        x2 <= 0; x3 <= 0;
        y_out <= 0;
    end else begin
        x0 <= x_in;
        x1 <= x0;
        x2 <= x1;
        x3 <= x2;
        y_out <= (h0 * x_in) + (h1 * x0) +
                 (h2 * x1)   + (h3 * x2);
    end
end
endmodule
