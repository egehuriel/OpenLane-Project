//part 4 lab 4&5
//8bit alu

module alu(
    input [7:0] A,
    input [7:0] B,
    input [2:0] op,
    output reg [7:0] Y
);

localparam OP_ADD = 3'b000;
localparam OP_SUB = 3'b001;
localparam OP_SHL = 3'b010;
localparam OP_SHR = 3'b011;
localparam OP_AND = 3'b100;
localparam OP_OR = 3'b101;
localparam OP_NOT = 3'b110;
localparam OP_XOR = 3'b111;

always @(*) begin
    case (op)
        OP_ADD: Y = A + B;
        OP_SUB: Y = A - B;
        OP_SHL: Y = A << 1;
        OP_SHR: Y = A >> 1;
        OP_AND: Y = A & B;
        OP_OR: Y = A | B;
        OP_NOT: Y = ~A;
        OP_XOR: Y = A ^ B;
        default: Y = 8'h00;
    endcase
end
endmodule
