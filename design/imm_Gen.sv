`timescale 1ns / 1ps

module imm_Gen (
    input  logic [31:0] inst_code,
    output logic [31:0] Imm_out
);

//Explicacao dessa parte: a saída sao 32 bits.
//Ele vai comparar o bit mais significativo (no caso das imediatas), para saber se é negativo ou positivo.
// Se for 1 (neg), vai concatenar 1111..., caso contrario (pos) vai concatenar 00...
// Tem que fazer isso pro ADDI, JAL, JALR

  always_comb
    case (inst_code[6:0])
      7'b0000011:  /*I-type load part*/
      Imm_out = {inst_code[31] ? 20'hFFFFF : 20'b0, inst_code[31:20]};
			
			7'b0010011:  /*I-type*/ // ADDI
      Imm_out = {inst_code[31] ? 20'hFFFFF : 20'b0, inst_code[31:20]};
      
      7'b0100011:  /*S-type*/
      Imm_out = {inst_code[31] ? 20'hFFFFF : 20'b0, inst_code[31:25], inst_code[11:7]};

      7'b1100011:  /*B-type*/
      Imm_out = {
        inst_code[31] ? 19'h7FFFF : 19'b0,
        inst_code[31],
        inst_code[7],
        inst_code[30:25],
        inst_code[11:8],
        1'b0
      };
      
   

      default: Imm_out = {32'b0};

    endcase

endmodule
