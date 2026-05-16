//part2 - lab3
// 8 alu op + flag bit
//flag = carry overflow zero sign
 
module alu_flags (
    input  [7:0]  A,
    input  [7:0]  B,
    input  [2:0]  op,
    output reg [15:0] Y,
    output reg        carry,
    output reg        overflow,
    output reg        zero,
    output reg        sign
);
 
localparam OP_ADD = 3'b000;
localparam OP_SUB = 3'b001;
localparam OP_MUL = 3'b010;
localparam OP_DIV = 3'b011;
localparam OP_AND = 3'b100;
localparam OP_OR  = 3'b101;
localparam OP_NOT = 3'b110;
localparam OP_XOR = 3'b111;
 
reg [8:0] temp;
 
always @(*) begin
    Y        = 16'h0000;
    carry    = 1'b0;
    overflow = 1'b0;
    temp     = 9'b0;
 
    case (op)
        OP_ADD: begin
            temp     = {1'b0, A} + {1'b0, B};
            Y        = {8'h00, temp[7:0]};
            carry    = temp[8];
            overflow = (A[7] == B[7]) && (temp[7] != A[7]);
        end
 
        OP_SUB: begin
            temp     = {1'b0, A} - {1'b0, B};
            Y        = {8'h00, temp[7:0]};
            carry    = temp[8];
            overflow = (A[7] != B[7]) && (temp[7] != A[7]);
        end
 
        OP_MUL: begin
            Y        = A * B;
            carry    = 1'b0;
            overflow = (Y[15:8] != 8'h00);
        end
 
        OP_DIV: begin
            Y        = (B == 8'd0) ? 16'h0000 : {8'h00, (A / B)};
            carry    = 1'b0;
            overflow = 1'b0;
        end
 
        OP_AND: begin
            Y        = {8'h00, A & B};
            carry    = 1'b0;
            overflow = 1'b0;
        end
 
        OP_OR: begin
            Y        = {8'h00, A | B};
            carry    = 1'b0;
            overflow = 1'b0;
        end
 
        OP_NOT: begin
            Y        = {8'h00, ~A};
            carry    = 1'b0;
            overflow = 1'b0;
        end
 
        OP_XOR: begin
            Y        = {8'h00, A ^ B};
            carry    = 1'b0;
            overflow = 1'b0;
        end
 
        default: begin
            Y        = 16'h0000;
            carry    = 1'b0;
            overflow = 1'b0;
        end
    endcase
 
    zero = (Y == 16'h0000);
    sign = Y[7];
end
 
endmodule

