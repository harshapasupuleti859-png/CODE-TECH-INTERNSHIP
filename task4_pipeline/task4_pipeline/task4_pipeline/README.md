# CODTECH VLSI Internship - Task 4

## 4-Stage Pipelined Processor

Designed a 4-stage pipelined processor in Verilog
supporting ADD, SUB, and LOAD instructions.

## Pipeline Stages
1. IF  - Instruction Fetch
2. ID  - Instruction Decode
3. EX  - Execute
4. WB  - Write Back

## Instructions Supported
| Opcode | Operation |
|--------|-----------|
| 0001   | ADD       |
| 0010   | SUB       |
| 0011   | LOAD      |

## Simulation Results
| Operation    | Result |
|-------------|--------|
| ADD R3=R1+R2 | R3=30  |
| SUB R4=R2-R1 | R4=10  |
| LOAD R5=15   | R5=15  |
| ADD R6=R3+R4 | R6=70  |

## Tool Used
EDA Playground - Riviera PRO

## Intern
Name: Harshavardhan
Intern ID: CTIS8866
