//part 3 - lab4
//16bit register r/w
 
module register_file (
    input             clk,
    input             rst,
    input             we,
    input  [15:0]     address,
    input  [15:0]     data_in,
    output reg [15:0] data_out
);
 
    reg [15:0] regs [0:15];
    integer i;
 
    always @(posedge clk) begin
        if (rst) begin
            for (i = 0; i < 16; i = i + 1)
                regs[i] <= 16'd0;
        end else if (we) begin
            regs[address[3:0]] <= data_in;
        end
    end
 
    always @(*) begin
        data_out = regs[address[3:0]];
    end
 
endmodule
