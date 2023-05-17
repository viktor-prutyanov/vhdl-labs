#!/usr/bin/bash

rm -rf *.o *.cf dump.vcd testbench
ghdl -a --std=08 '-fsynopsys' '-fexplicit' memory.vhd test_mem.vhd testbench.vhd
ghdl -e --std=08 '-fsynopsys' '-fexplicit' testbench
./testbench --vcd=dump.vcd
