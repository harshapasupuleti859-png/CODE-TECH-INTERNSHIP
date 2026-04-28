module pipeline_processor (
    input clk,
    input reset
);

// =============================
// INSTRUCTION MEMORY (8 instructions)
// =============================
reg [15:0] instr_mem [0:7];
// Format: [15:12]=opcode [11:8]=rd [7:4]=rs1 [3:0]=rs2/imm
// Opcodes: 0001=ADD, 0010=SUB, 0011=LOAD

// REGISTER FILE
reg [7:0] reg_file [0:7];

// =============================
// PIPELINE REGISTERS
// =============================

// IF/ID
reg [15:0] IF_ID_instr;
reg [2:0]  IF_ID_pc;

// ID/EX
reg [3:0]  ID_EX_opcode;
reg [2:0]  ID_EX_rd;
reg [7:0]  ID_EX_rs1_val;
reg [7:0]  ID_EX_rs2_val;
reg [3:0]  ID_EX_imm;

// EX/WB
reg [2:0]  EX_WB_rd;
reg [7:0]  EX_WB_result;
reg        EX_WB_reg_write;

// Program Counter
reg [2:0] pc;

// =============================
// INITIALIZE
// =============================
integer i;
initial begin
    pc = 0;
    for (i = 0; i < 8; i = i + 1)
        reg_file[i] = i * 10; // R0=0, R1=10, R2=20...

    // Instructions
    // ADD R3 = R1 + R2  → 0001_011_001_010_0
    instr_mem[0] = 16'b0001_0011_0001_0010;
    // SUB R4 = R2 - R1  → 0010_100_010_001_0
    instr_mem[1] = 16'b0010_0100_0010_0001;
    // LOAD R5 = 15      → 0011_101_000_1111
    instr_mem[2] = 16'b0011_0101_0000_1111;
    // ADD R6 = R3 + R4
    instr_mem[3] = 16'b0001_0110_0011_0100;
    instr_mem[4] = 16'b0000_0000_0000_0000;
    instr_mem[5] = 16'b0000_0000_0000_0000;
    instr_mem[6] = 16'b0000_0000_0000_0000;
    instr_mem[7] = 16'b0000_0000_0000_0000;
end

// =============================
// STAGE 1: INSTRUCTION FETCH
// =============================
always @(posedge clk or posedge reset) begin
    if (reset) begin
        IF_ID_instr <= 0;
        IF_ID_pc    <= 0;
        pc          <= 0;
    end else begin
        IF_ID_instr <= instr_mem[pc];
        IF_ID_pc    <= pc;
        pc          <= pc + 1;
        $display("[IF ] PC=%0d Instr=%b", pc, instr_mem[pc]);
    end
end

// =============================
// STAGE 2: INSTRUCTION DECODE
// =============================
always @(posedge clk or posedge reset) begin
    if (reset) begin
        ID_EX_opcode  <= 0;
        ID_EX_rd      <= 0;
        ID_EX_rs1_val <= 0;
        ID_EX_rs2_val <= 0;
        ID_EX_imm     <= 0;
    end else begin
        ID_EX_opcode  <= IF_ID_instr[15:12];
        ID_EX_rd      <= IF_ID_instr[11:8];
        ID_EX_rs1_val <= reg_file[IF_ID_instr[7:4]];
        ID_EX_rs2_val <= reg_file[IF_ID_instr[3:0]];
        ID_EX_imm     <= IF_ID_instr[3:0];
        $display("[ID ] Opcode=%b RD=R%0d RS1=%0d RS2=%0d",
                  IF_ID_instr[15:12],
                  IF_ID_instr[11:8],
                  reg_file[IF_ID_instr[7:4]],
                  reg_file[IF_ID_instr[3:0]]);
    end
end

// =============================
// STAGE 3: EXECUTE
// =============================
always @(posedge clk or posedge reset) begin
    if (reset) begin
        EX_WB_rd       <= 0;
        EX_WB_result   <= 0;
        EX_WB_reg_write<= 0;
    end else begin
        EX_WB_rd        <= ID_EX_rd;
        EX_WB_reg_write <= 1;
        case (ID_EX_opcode)
            4'b0001: begin // ADD
                EX_WB_result <= ID_EX_rs1_val + ID_EX_rs2_val;
                $display("[EX ] ADD: %0d + %0d = %0d",
                          ID_EX_rs1_val, ID_EX_rs2_val,
                          ID_EX_rs1_val + ID_EX_rs2_val);
            end
            4'b0010: begin // SUB
                EX_WB_result <= ID_EX_rs1_val - ID_EX_rs2_val;
                $display("[EX ] SUB: %0d - %0d = %0d",
                          ID_EX_rs1_val, ID_EX_rs2_val,
                          ID_EX_rs1_val - ID_EX_rs2_val);
            end
            4'b0011: begin // LOAD immediate
                EX_WB_result <= {4'b0, ID_EX_imm};
                $display("[EX ] LOAD: Imm=%0d", ID_EX_imm);
            end
            default: begin
                EX_WB_result    <= 0;
                EX_WB_reg_write <= 0;
                $display("[EX ] NOP");
            end
        endcase
    end
end

// =============================
// STAGE 4: WRITE BACK
// =============================
always @(posedge clk or posedge reset) begin
    if (reset) begin
        // nothing
    end else begin
        if (EX_WB_reg_write) begin
            reg_file[EX_WB_rd] <= EX_WB_result;
            $display("[WB ] R%0d = %0d", EX_WB_rd, EX_WB_result);
        end
    end
end

endmodule
