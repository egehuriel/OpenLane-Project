//lab5 - part 5 - full
// half cpu top model

module cpu_top (
    input         clk,
    input         rst,
    output [7:0]  result,
    output [15:0] pc_out
);

    reg [15:0] pc;
    assign pc_out = pc;

    wire [15:0] instruction;

    wire [3:0] opcode;
    wire [3:0] ra, rb, rd;

    wire [15:0] reg_a_data, reg_b_data;

    wire [7:0]  alu_result;
    wire [2:0]  alu_op;
    wire        reg_we;

    assign alu_op = opcode[2:0];
    assign reg_we = (opcode != 4'b1111);

    register_file instr_mem (
        .clk     (clk),
        .rst     (rst),
        .we      (1'b0),
        .addr    (pc[3:0]),
        .data_in (16'd0),
        .data_out(instruction)
    );

    decoder dec (
        .instruction(instruction),
        .opcode     (opcode),
        .ra         (ra),
        .rb         (rb),
        .rd         (rd)
    );

    register_file reg_file_a (
        .clk     (clk),
        .rst     (rst),
        .we      (1'b0),
        .addr    (ra),
        .data_in (16'd0),
        .data_out(reg_a_data)
    );

    register_file reg_file_b (
        .clk     (clk),
        .rst     (rst),
        .we      (1'b0),
        .addr    (rb),
        .data_in (16'd0),
        .data_out(reg_b_data)
    );

    alu alu_inst (
        .A  (reg_a_data[7:0]),
        .B  (reg_b_data[7:0]),
        .op (alu_op),
        .Y  (alu_result)
    );

    assign result = alu_result;

    register_file reg_file_d (
        .clk     (clk),
        .rst     (rst),
        .we      (reg_we),
        .addr    (rd),
        .data_in ({8'h00, alu_result}),
        .data_out()
    );

    always @(posedge clk) begin
        if (rst)
            pc <= 16'd0;
        else if (opcode != 4'b1111)
            pc <= pc + 16'd1;
    end

endmodule
