# SSITH AWS FPGA

[![Build Status](https://travis-ci.org/acceleratedtech/ssith-aws-fpga.svg?branch=master)](https://travis-ci.org/acceleratedtech/ssith-aws-fpga)

This repository contains the host software for controlling a RISC-V processor running on Amazon AWS F1 FPGA.

## Setting up development tools

```bash
  sudo apt-get install cmake device-tree-compiler build-essential libssl-dev libcurl4-openssl-dev libsdl-dev libelf-dev
```

## Building `ssith_aws_fpga` for simulation

```bash
   mkdir build
   cd build
   cmake ..
   make
   cd ..
   dtc -I dts -O dtb -o build/devicetree.dtb src/dts/devicetree.dts
   ln -s hw/src_AWS_P2/verilator/bin/vlsim build
   ln -s hw/src_AWS_P2/verilator/bin/libconnectal-sim.so build
   LD_LIBRARY_PATH=./build ./build/ssith_aws_fpga --dtb build/devicetree.dtb  --elf foo.elf
```

## Setting up FPGA

Build FPGA utilities and set them up to run as root:

```bash
   cd aws-fpga
   . hdk_setup
   sudo chmod u+s /usr/local/bin/fpga-local-cmd
```

Install connectal and load drivers

```bash
  sudo add-apt-repository -y ppa:jamey-hicks/connectal
  sudo apt-get install connectal
  fpga-clear-local-fpga -S 0
  modprobe portalmem
  modprobe pcieportal
```

## Building and running `ssith_aws_fpga` on FPGA

```bash
   mkdir build
   cd build
   cmake -DFPGA=1 ..
   make
   cd ..
   dtc -I dts -O dtb -o build/devicetree.dtb src/dts/devicetree.dts
   fpga-load-local-image -S 0 -I agfi-01019fdac375031e7
   ./build/ssith_aws_fpga --dtb build/devicetree.dtb  --elf foo.elf
```
