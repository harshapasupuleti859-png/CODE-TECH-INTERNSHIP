module ram_tb;
    reg clk, we;
    reg [3:0] addr;
    reg [7:0] din;
    wire [7:0] dout;

    sync_ram uut (.clk(clk),.we(we),.addr(addr),.din(din),.dout(dout));

    always #5 clk = ~clk;

    initial begin
        clk = 0; we = 0;
        $display("Time\tOP\tAddr\tData_In\tData_Out");
        $monitor("%0t\t%s\t%0d\t%0d\t%0d",
                  $time, we ? "WRITE":"READ", addr, din, dout);
        we=1; addr=4'd0; din=8'd55;  #10;
        we=1; addr=4'd1; din=8'd100; #10;
        we=1; addr=4'd2; din=8'd200; #10;
        we=1; addr=4'd3; din=8'd75;  #10;
        we=0; addr=4'd0; #10;
        we=0; addr=4'd1; #10;
        we=0; addr=4'd2; #10;
        we=0; addr=4'd3; #10;
        $finish;
    end
    initial begin
        $dumpfile("ram_wave.vcd");
        $dumpvars(0, ram_tb);
    end
endmodule
