# ABM
An 8-bit processor using Verilog based on Ben Eater's playlist link : ![link](https://www.youtube.com/playlist?list=PLowKtXNTBypGqImE405J2565dvjafglHU.)

# Architecture
![image](https://github.com/Sheldon38/ABM/assets/109095852/c92d3ede-27a2-40ad-adcd-51cec0b8e38a)

# Programs
To add the assembly level instructions add the instructions in instructions.txt
The instruction follows the format : 

+---------+---------+
| 4 bit   | 4 bit   |
+---------+---------+
| Op code | Operand |
+---------+---------+

Currently only four instructions are programmed which can be updated in future inside microprogrammed_instruction.xlsx

+-------+------+
| LDA   | 0001 |
+-------+------+
| ADD   | 0010 |
+-------+------+
| OUT A | 1110 |
+-------+------+
| OUT B | 1111 |
+-------+------+


