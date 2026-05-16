//part 5 - lab 5 - full
// full system = half cpu, debouncer , 7 segment mux

module full_system(
    input clk,
    input rst,
    input btn_step,
    output [6:0] seg,
    output dp,
    output [1:0] an
);

wire btn_db;
wire btn_pulse;
wire [7:0] cpu_result;
wire [15:0] pc_out;

debounce #(
    .COUNT_MAX(100000)
) u_debounce (
    .clk (clk),
    .rst (rst),
    .btn_in (btn_step),
    .btn_out (btn_db)
);

one_pulse u_one_pulse (
    .clk (clk),
    .rst (rst),
    .sig_in (btn_db),
    .pulse (btn_pulse)
);

cpu_top u_cpu(
    .clk (clk),
    .rst (rst),
    .result (cpu_result),
    .pc_out (pc_out)
);

sevenseg_mux #(
    .CLKDIV(5000)
) u_sevenseg (
    .clk (clk),
    .rst (rst),
    .value (cpu_result),
    .seg (seg),
    .dp (dp),
    .an (an)
);

endmodule
