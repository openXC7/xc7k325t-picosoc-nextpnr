set_property LOC F22 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]
# nextpnr can't read this
# create_clock -period 20 clk_bufg

set_property LOC J26 [get_ports led[0]]
set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]

set_property LOC H26 [get_ports led[1]]
set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]

set_property LOC AF10 [get_ports sw]
set_property IOSTANDARD LVCMOS33 [get_ports {sw}]

set_property LOC A8 [get_ports rx]
set_property IOSTANDARD LVCMOS33 [get_ports {rx}]

set_property LOC A9 [get_ports tx]
set_property IOSTANDARD LVCMOS33 [get_ports {tx}]