module alu (
    input  [7:0] A, B,
    input  [2:0] opcode,
    output reg [7:0] result,
    output reg carry
);
always @(*) begin
    carry = 0;
    case (opcode)
        3'b000: {carry, result} = A + B;
        3'b001: {carry, result} = A - B;
        3'b010: result = A & B;
        3'b011: result = A | B;
        3'b100: result = ~A;
        default: result = 8'b00000000;
    endcase
end
endmodule
