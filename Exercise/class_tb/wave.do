onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top/dut0/PCLK
add wave -noupdate /top/dut0/PRESETN
add wave -noupdate /top/dut0/PADDR
add wave -noupdate /top/dut0/PWDATA
add wave -noupdate /top/dut0/PRDATA
add wave -noupdate /top/dut0/PWRITE
add wave -noupdate /top/dut0/PSEL
add wave -noupdate /top/dut0/PENABLE
add wave -noupdate /top/dut0/PREADY
add wave -noupdate /top/dut0/sclk_pad_o
add wave -noupdate /top/dut0/mosi_pad_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1733239 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {1828050 ps}
