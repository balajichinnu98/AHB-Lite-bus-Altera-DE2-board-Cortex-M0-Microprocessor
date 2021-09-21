#Update -period with clock period (in nanoseconds) of the clock driving the fpga
create_clock -name CLOCK_50 -period 20 [get_ports CLOCK_50]

#Setting LED outputs as false path, since no timing requirement
set_false_path -from * -to [get_ports LEDG[*]]

