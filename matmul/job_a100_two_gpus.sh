#!/bin/bash
#SBATCH -N 1 
#SBATCH -p gpu_a100_8
#SBATCH --gres=gpu:2
#SBATCH -n 2 
#SBATCH --ntasks-per-node=2
#SBATCH --job-name="nccl_fixed"
#SBATCH -o slurm_nccl.%j.out
#SBATCH -e slurm_nccl.%j.err
source /apps/spack/share/spack/setup-env.sh
spack load nvhpc@24.9/245l5im
spack load cuda@12.6.0%nvhpc@24.9
spack load nccl@2.22.3-1%nvhpc@24.9 cuda_arch=80
spack load openmpi@4.1.6%nvhpc@24.9 +legacylaunchers
export NCCL_ROOT=$(spack location -i nccl@2.22.3-1%nvhpc@24.9 cuda_arch=80)
export CUDA_ROOT=$(spack location -i cuda@12.6.0%nvhpc@24.9)
export LD_LIBRARY_PATH=$NCCL_ROOT/lib:$CUDA_ROOT/lib64:$LD_LIBRARY_PATH
unset NCCL_P2P_LEVEL
unset NCCL_SOCKET_IFNAME
unset NCCL_P2P_DISABLE
unset NCCL_SHM_DISABLE
unset NCCL_IB_DISABLE
export NCCL_ASYNC_ERROR_HANDLING=1
mpirun -np 2 ./nccl_test
