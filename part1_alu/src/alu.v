//part 1
//8bit alu op

module alu (
    input [7:0] A,
    input [7:0] B,
    input [2:0] op,
    output reg [15:0] Y
);

localparam OP_ADD = 3'b000;
localparam OP_SUB = 3'b001;
localparam OP_MUL = 3'b010;
localparam OP_DIV = 3'b011;
localparam OP_AND = 3'b100;
localparam OP_OR = 3'b101;
localparam OP_NOT = 3'b110;
localparam OP_XOR = 3'b111;

always @(*) begin
    case (op)
        OP_ADD: Y = {8'h00, A} + {8'h00, B};
        OP_SUB: Y = {8'h00, A} - {8'h00, B};
        OP_MUL: Y = A * B;
        OP_DIV: Y = (B == 8'd0) ? 16'h0000 : {8'h00, (A/B)};
        OP_AND: Y = {8'h00, A & B};
        OP_OR: Y = {8'h00, A | B};
        OP_NOT: Y = {8'h00, ~A};
        OP_XOR: Y = {8'h00, A ^ B};
        default: Y = 16'h0000;
    endcase
end

endmodule
