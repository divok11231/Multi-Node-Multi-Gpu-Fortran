#!/bin/bash
set -e
source /apps/spack/share/spack/setup-env.sh
spack load nvhpc@24.9/245l5im
spack load cuda@12.6.0%nvhpc@24.9
spack load nccl@2.22.3-1%nvhpc@24.9 cuda_arch=80
spack load openmpi@4.1.6%nvhpc@24.9 +legacylaunchers
NCCL_HOME=$(spack location -i nccl@2.22.3-1%nvhpc@24.9 cuda_arch=80)
rm -f nccl_test *.o *.mod
mpifort -Mcuda -O3 -fPIC \
    -I${NCCL_HOME}/include \
    -L${NCCL_HOME}/lib -lnccl \
    -Wl,-rpath,${NCCL_HOME}/lib \
    -lcudart \
    nccl_fort_mod.f90 \
    test_nccl_send.cuf \
    -o nccl_test
