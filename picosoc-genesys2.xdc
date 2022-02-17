# external TCXO 10MHz
set_property LOC T25 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]
# nextpnr can't read this
# create_clock -period ?? clk_bufg

set_property LOC T28 [get_ports led[0]]
set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]
set_property LOC V19 [get_ports led[1]]
set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]

set_property LOC G19 [get_ports sw[0]]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[0]}]

set_property LOC Y23 [get_ports tx]
set_property IOSTANDARD LVCMOS33 [get_ports {tx}]

set_property LOC Y20 [get_ports rx]
set_property IOSTANDARD LVCMOS33 [get_ports {rx}]
