#!/bin/bash -l

#SBATCH --job-name download
#SBATCH --partition cpu
#SBATCH --nodes 1
#SBATCH --cpus-per-task 1
#SBATCH --mem 32G
#SBATCH --time 04:00:00

module load gcc/10.4.0 sratoolkit/3.0.0

mkdir -p /work/FAC/FBM/DEE/mrobinso/bgee/marion/data

cd /work/FAC/FBM/DEE/mrobinso/bgee/marion/data

SAMPLES="ERR032229 ERR032218 ERR032213 ERR032231"

for SAMPLE in $SAMPLES; do

prefetch ${SAMPLE} --max-size u
fastq-dump --gzip --split-files ${SAMPLE}

done
