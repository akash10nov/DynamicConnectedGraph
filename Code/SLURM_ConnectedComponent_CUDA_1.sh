#!/bin/bash
#SBATCH --partition=debug
#SBATCH --gres=gpu:1
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --job-name=MM_CUDA_1
#SBATCH --time=00:10:00
#SBATCH --mail-user=chaofeng@buffalo.edu
#SBATCH --output=Result_MM_CUDA_1.csv
#SBATCH --error=Result_MM_CUDA_1.out

echo "GPU"
ulimit -s unlimited
#

module load cuda
nvcc Gpu_ConnectedComponent.cu -o Gpu_ConnectedComponent -arch=sm_20

./Gpu_ConnectedComponent 1000 500
./Gpu_ConnectedComponent 1000 1000
./Gpu_ConnectedComponent 2000 500
./Gpu_ConnectedComponent 2000 1000
./Gpu_ConnectedComponent 3000 500
./Gpu_ConnectedComponent 3000 1000
./Gpu_ConnectedComponent 4000 500
./Gpu_ConnectedComponent 4000 1000
./Gpu_ConnectedComponent 5000 500
./Gpu_ConnectedComponent 5000 1000
./Gpu_ConnectedComponent 6000 500
./Gpu_ConnectedComponent 6000 1000
./Gpu_ConnectedComponent 7000 500
./Gpu_ConnectedComponent 7000 1000
./Gpu_ConnectedComponent 8000 500
./Gpu_ConnectedComponent 8000 1000
./Gpu_ConnectedComponent 9000 500
./Gpu_ConnectedComponent 9000 1000
./Gpu_ConnectedComponent 10000 500
./Gpu_ConnectedComponent 10000 1000
./Gpu_ConnectedComponent 11000 500
./Gpu_ConnectedComponent 11000 1000
./Gpu_ConnectedComponent 12000 500
./Gpu_ConnectedComponent 12000 1000
./Gpu_ConnectedComponent 13000 500
./Gpu_ConnectedComponent 13000 1000
./Gpu_ConnectedComponent 14000 500
./Gpu_ConnectedComponent 14000 1000
./Gpu_ConnectedComponent 15000 500
./Gpu_ConnectedComponent 15000 1000
./Gpu_ConnectedComponent 16000 500
./Gpu_ConnectedComponent 16000 1000
./Gpu_ConnectedComponent 17000 500
./Gpu_ConnectedComponent 17000 1000
./Gpu_ConnectedComponent 18000 500
./Gpu_ConnectedComponent 18000 1000
./Gpu_ConnectedComponent 19000 500
./Gpu_ConnectedComponent 19000 1000
./Gpu_ConnectedComponent 20000 500
./Gpu_ConnectedComponent 20000 1000
./Gpu_ConnectedComponent 21000 500
./Gpu_ConnectedComponent 21000 1000
./Gpu_ConnectedComponent 22000 500
./Gpu_ConnectedComponent 22000 1000
./Gpu_ConnectedComponent 23000 500
./Gpu_ConnectedComponent 23000 1000
./Gpu_ConnectedComponent 24000 500
./Gpu_ConnectedComponent 24000 1000
./Gpu_ConnectedComponent 25000 500
./Gpu_ConnectedComponent 25000 1000


#

