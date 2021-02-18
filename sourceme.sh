#!/usr/bin/env bash

# Set PYTHONPATH accordingly
if [ -z "$PYTHONPATH" ]
then
    export PYTHONPATH=$PWD
else
    export PYTHONPATH=$PWD:$PYTHONPATH
fi

# Set MYPYPATH accordingly
if [ -z "$MYPYPATH" ]
then
    export MYPYPATH=$PWD/ssp1_fpga
else
    export MYPYPATH=$PWD/ssp1_fpga:$MYPYPATH
fi

# Source toolbox sourceme
cd toolbox; source sourceme.sh; cd ..

# Source toolbox-xilinx-tools sourceme
cd toolbox-xilinx-tools; source sourceme.sh; cd ..

# Source uart-interface-generator sourceme
cd uart-interface-generator; source sourceme.sh; cd ..

# Set SSP1_FPGA_HOME variable
export PROJECT_HOME=$PWD

# Vivado setup (adds stuff to path)
source /tools/Xilinx/Vivado/2020.2/settings64.sh

# Setup license file stuff (taken from https://inst.eecs.berkeley.edu/~inst/xilinx/eecs/)
export XILINXD_LICENSE_FILE=2200@bwrcflex-1.eecs.berkeley.edu:2200@bwrcflex-2.eecs.berkeley.edu
export LM_LICENSE_FILE=2200@bwrcflex-1.eecs.berkeley.edu:2200@bwrcflex-2.eecs.berkeley.edu
