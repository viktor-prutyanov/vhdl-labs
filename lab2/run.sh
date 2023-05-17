#!/usr/bin/bash

rm -rf *.o *.cf dump.vcd testbench
ghdl -a --std=08 '-fsynopsys' '-fexplicit' maxW.vhd maxWN.vhd argmaxWN.vhd design.vhd test_req_gen.vhd testbench.vhd
ghdl -e --std=08 '-fsynopsys' '-fexplicit' testbench
./testbench --vcd=dump.vcd
