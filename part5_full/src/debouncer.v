//part 5 - lab5 full
//button debouncer , pulse

module debounce #(
    parameter COUNT_MAX = 100000
)(
    input      clk,
    input      rst,
    input      btn_in,
    output reg btn_out
);
    reg sync0, sync1;
    reg [16:0] count;
 
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            sync0   <= 1'b0;
            sync1   <= 1'b0;
            btn_out <= 1'b0;
            count   <= 17'd0;
        end else begin
            sync0 <= btn_in;
            sync1 <= sync0;
            if (sync1 == btn_out) begin
                count <= 17'd0;
            end else begin
                if (count == COUNT_MAX) begin
                    btn_out <= sync1;
                    count   <= 17'd0;
                end else begin
                    count <= count + 1'b1;
                end
            end
        end
    end
endmodule
 
module one_pulse (
    input      clk,
    input      rst,
    input      sig_in,
    output reg pulse
);
    reg sig_d;
 
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            sig_d <= 1'b0;
            pulse <= 1'b0;
        end else begin
            pulse <= sig_in & ~sig_d;
            sig_d <= sig_in;
        end
    end
endmodule
