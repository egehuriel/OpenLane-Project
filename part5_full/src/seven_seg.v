//part5 lab5 - full
// 7 multiplexer

module sevenseg_mux #(
    parameter CLKDIV =5000
)(
    input clk,
    input rst,
    input [7:0] value,
    output reg [6:0] seg,
    output dp,
    output reg [1:0] an
);

reg [12:0] refresh_count;
reg digit_sel;
reg [3:0] nibble;
assign dp = 1'b1;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        refresh_count <= 13'd0;
        digit_sel <= 1'b0;
    end else begin
        if(refresh_count == CLKDIV -1 ) begin
            refresh_count <= 13'd0;
            digit_sel <= digit_sel + 1'b1;
        end else begin
            refresh_count <= refresh_count + 1'b1;
        end
    end
end

always @(*) begin
    case (digit_sel)
        1'b0: nibble = value [3:0];
        1'b1: nibble = value[7:4];
        default: nibble = 4'h0;
    endcase
end

always @(*) begin
    an = 2'b11;
    an[digit_sel] = 1'b0;
end

always @(*) begin
    case (nibble)
        4'h0: seg = 7'b1000000;
        4'h1: seg = 7'b1111001;
        4'h2: seg = 7'b0100100;
        4'h3: seg = 7'b0110000;
        4'h4: seg = 7'b0011001;
        4'h5: seg = 7'b0010010;
        4'h6: seg = 7'b0000010;
        4'h7: seg = 7'b1111000;
        4'h8: seg = 7'b0000000;
        4'h9: seg = 7'b0010000;
        4'hA: seg = 7'b0001000;
        4'hB: seg = 7'b0000011;
        4'hC: seg = 7'b1000110;
        4'hD: seg = 7'b0100001;
        4'hE: seg = 7'b0000110;
        4'hF: seg = 7'b0001110;
        default: seg = 7'b1111111;
    endcase
end
endmodule
