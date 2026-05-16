//parh 5 = lab 5 - full
//16bit register file

module register_file (
    input             clk,
    input             rst,
    input             we,
    input  [3:0]      addr,
    input  [15:0]     data_in,
    output [15:0]     data_out
);
 
    reg [15:0] regs [0:15];
    integer i;
 
    always @(posedge clk) begin
        if (rst) begin
            for (i = 0; i < 16; i = i + 1)
                regs[i] <= 16'd0;
        end else if (we) begin
            regs[addr] <= data_in;
        end
    end
 
    assign data_out = regs[addr];
 
endmodule
 
