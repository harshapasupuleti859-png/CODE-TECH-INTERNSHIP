# CODTECH VLSI Internship - Task 2

## Synchronous RAM Module

Designed a 16x8-bit Synchronous RAM in Verilog supporting:
- Write Operation (we=1)
- Read Operation (we=0)
- Clock synchronized operations

## Simulation Results
| Time | Operation | Address | Data_In | Data_Out |
|------|-----------|---------|---------|----------|
| 0    | WRITE     | 0       | 55      | x        |
| 10   | WRITE     | 1       | 100     | x        |
| 20   | WRITE     | 2       | 200     | x        |
| 30   | WRITE     | 3       | 75      | x        |
| 45   | READ      | 0       | -       | 55       |
| 55   | READ      | 1       | -       | 100      |
| 65   | READ      | 2       | -       | 200      |
| 75   | READ      | 3       | -       | 75       |

## Tool Used
EDA Playground - Riviera PRO

## Intern
Name: [Your Name]
Intern ID: [Your ID]
