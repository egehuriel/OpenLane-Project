//part 5 - lab 5 - full
//instruction decoder

module decoder (
    input [15:0] instruction,
    output [3:0] opcode,
    output [3:0] ra,
    output [3:0] rb,
    output [3:0] rd
);

assign opcode = instruction[15:12];
assign ra = instruction[11:8];
assign rb = instruction[7:4];
assign rd = instruction[3:0];

endmodule
