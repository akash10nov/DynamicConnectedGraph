#!/bin/bash
#SBATCH --partition=debug
#SBATCH --gres=gpu:1
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --job-name=MM_CUDA_1
#SBATCH --time=00:10:00
#SBATCH --mail-user=chaofeng@buffalo.edu
#SBATCH --output=Seq_gpu.csv
#SBATCH --error=Seq_gpu.out

echo "seq"
ulimit -s unlimited
#

module load cuda
gcc -std=c99 Seq.c


./a.out 1000 500
./a.out 1000 1000
./a.out 2000 500
./a.out 2000 1000
./a.out 3000 500
./a.out 3000 1000
./a.out 4000 500
./a.out 4000 1000
./a.out 5000 500
./a.out 5000 1000
./a.out 6000 500
./a.out 6000 1000
./a.out 7000 500
./a.out 7000 1000
./a.out 8000 500
./a.out 8000 1000
./a.out 9000 500
./a.out 9000 1000
./a.out 10000 500
./a.out 10000 1000
./a.out 11000 500
./a.out 11000 1000
./a.out 12000 500
./a.out 12000 1000
./a.out 13000 500
./a.out 13000 1000
./a.out 14000 500
./a.out 14000 1000
./a.out 15000 500
./a.out 15000 1000
./a.out 16000 500
./a.out 16000 1000
./a.out 17000 500
./a.out 17000 1000
./a.out 18000 500
./a.out 18000 1000
./a.out 19000 500
./a.out 19000 1000
./a.out 20000 500
./a.out 20000 1000
./a.out 21000 500
./a.out 21000 1000
./a.out 22000 500
./a.out 22000 1000
./a.out 23000 500
./a.out 23000 1000
./a.out 24000 500
./a.out 24000 1000
./a.out 25000 500
./a.out 25000 1000

#

