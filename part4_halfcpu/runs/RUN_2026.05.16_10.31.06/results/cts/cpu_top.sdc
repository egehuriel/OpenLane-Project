###############################################################################
# Created by write_sdc
# Sat May 16 10:31:35 2026
###############################################################################
current_design cpu_top
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name clk -period 10.0000 [get_ports {clk}]
set_clock_transition 0.1500 [get_clocks {clk}]
set_clock_uncertainty 0.2500 clk
set_propagated_clock [get_clocks {clk}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {rst}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {pc_out[0]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {pc_out[10]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {pc_out[11]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {pc_out[12]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {pc_out[13]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {pc_out[14]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {pc_out[15]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {pc_out[1]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {pc_out[2]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {pc_out[3]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {pc_out[4]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {pc_out[5]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {pc_out[6]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {pc_out[7]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {pc_out[8]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {pc_out[9]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {result[0]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {result[1]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {result[2]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {result[3]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {result[4]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {result[5]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {result[6]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {result[7]}]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.0334 [get_ports {pc_out[15]}]
set_load -pin_load 0.0334 [get_ports {pc_out[14]}]
set_load -pin_load 0.0334 [get_ports {pc_out[13]}]
set_load -pin_load 0.0334 [get_ports {pc_out[12]}]
set_load -pin_load 0.0334 [get_ports {pc_out[11]}]
set_load -pin_load 0.0334 [get_ports {pc_out[10]}]
set_load -pin_load 0.0334 [get_ports {pc_out[9]}]
set_load -pin_load 0.0334 [get_ports {pc_out[8]}]
set_load -pin_load 0.0334 [get_ports {pc_out[7]}]
set_load -pin_load 0.0334 [get_ports {pc_out[6]}]
set_load -pin_load 0.0334 [get_ports {pc_out[5]}]
set_load -pin_load 0.0334 [get_ports {pc_out[4]}]
set_load -pin_load 0.0334 [get_ports {pc_out[3]}]
set_load -pin_load 0.0334 [get_ports {pc_out[2]}]
set_load -pin_load 0.0334 [get_ports {pc_out[1]}]
set_load -pin_load 0.0334 [get_ports {pc_out[0]}]
set_load -pin_load 0.0334 [get_ports {result[7]}]
set_load -pin_load 0.0334 [get_ports {result[6]}]
set_load -pin_load 0.0334 [get_ports {result[5]}]
set_load -pin_load 0.0334 [get_ports {result[4]}]
set_load -pin_load 0.0334 [get_ports {result[3]}]
set_load -pin_load 0.0334 [get_ports {result[2]}]
set_load -pin_load 0.0334 [get_ports {result[1]}]
set_load -pin_load 0.0334 [get_ports {result[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {clk}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {rst}]
set_timing_derate -early 0.9500
set_timing_derate -late 1.0500
###############################################################################
# Design Rules
###############################################################################
set_max_transition 0.7500 [current_design]
set_max_fanout 10.0000 [current_design]
