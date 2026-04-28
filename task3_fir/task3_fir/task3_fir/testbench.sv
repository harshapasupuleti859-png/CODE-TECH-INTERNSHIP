module fir_tb;

reg clk, reset;
reg signed [7:0] x_in;
wire signed [18:0] y_out;

fir_filter uut (.clk(clk), .reset(reset),
                .x_in(x_in), .y_out(y_out));

always #5 clk = ~clk;

initial begin
    clk = 0; reset = 1; x_in = 0;
    #10 reset = 0;
    $display("Time\t Input\t Output");
    $monitor("%0t\t %0d\t %0d", $time, x_in, y_out);
    x_in = 8'd10; #10;
    x_in = 8'd20; #10;
    x_in = 8'd30; #10;
    x_in = 8'd40; #10;
    x_in = 8'd50; #10;
    x_in = 8'd0;  #10;
    x_in = 8'd0;  #10;
    x_in = 8'd0;  #10;
    $finish;
end
initial begin
    $dumpfile("fir_wave.vcd");
    $dumpvars(0, fir_tb);
end
endmodule
