vlib work
vlog tb.v
vsim -voptargs="+acc" work.tb
add wave -r *
run -all
