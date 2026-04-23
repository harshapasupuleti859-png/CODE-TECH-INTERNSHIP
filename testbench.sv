module alu_tb;
reg  [7:0] A, B;
reg  [2:0] opcode;
wire [7:0] result;
wire carry;
alu uut (.A(A), .B(B), .opcode(opcode), .result(result), .carry(carry));
initial begin
    $display("OP\t A\t B\t Result\t Carry");
    $monitor("%b\t %d\t %d\t %d\t %b", opcode, A, B, result, carry);
    A = 8'd15; B = 8'd10; opcode = 3'b000; #10;
    A = 8'd20; B = 8'd5;  opcode = 3'b001; #10;
    A = 8'b10101010; B = 8'b11001100; opcode = 3'b010; #10;
    A = 8'b10101010; B = 8'b11001100; opcode = 3'b011; #10;
    A = 8'b10101010; B = 8'd0; opcode = 3'b100; #10;
    $finish;
end
initial begin
    $dumpfile("alu_wave.vcd");
    $dumpvars(0, alu_tb);
end
endmodule
