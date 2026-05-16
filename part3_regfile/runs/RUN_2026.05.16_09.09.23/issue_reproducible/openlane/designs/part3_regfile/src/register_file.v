//part 3 - lab4
//16bit register r/w

module register_file (
    input clk,
    input rst,
    input we,
    input [15:0] address,
    input [15:0] data_in,
    output reg [15:0] data_out
);

reg[15:0] mem[0:65535];

always @(posedge clk) begin
    if(rst) begin
        data_out <= 16'd0;
    end else begin
        if (we) begin
            mem[address] <= data_in;
        end
        data_out <= mem[address];
    end
end

endmodule
