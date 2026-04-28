module pipeline_tb;

reg clk, reset;

pipeline_processor uut (
    .clk(clk),
    .reset(reset)
);

// Clock
always #5 clk = ~clk;

initial begin
    clk = 0; reset = 1;
    #10 reset = 0;

    $display("=== 4-Stage Pipeline Processor Simulation ===");
    $display("Stages: IF | ID | EX | WB");
    $display("=============================================");

    // Run enough cycles for all instructions
    #100;

    $display("=============================================");
    $display("Simulation Complete!");
    $finish;
end

initial begin
    $dumpfile("pipeline_wave.vcd");
    $dumpvars(0, pipeline_tb);
end

endmodule
