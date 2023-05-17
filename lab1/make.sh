#!/bin/bash -x

xmvhdl -v93 src/design.vhd src/lab1_and.vhd src/lab1_beh.vhd src/lab1_not.vhd src/lab1_or.vhd src/lab1_struct.vhd src/testbench.vhd
xmelab -messages -coverage all -access +rwc worklib.testbench:tb
xmsim -gui worklib.testbench:tb
