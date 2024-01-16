#!/bin/bash -l

#SBATCH --job-name download
#SBATCH --partition cpu
#SBATCH --nodes 1
#SBATCH --cpus-per-task 1
#SBATCH --mem 32G
#SBATCH --time 04:00:00

module load gcc/10.4.0 fastqc

mkdir -p /work/FAC/FBM/DEE/mrobinso/bgee/marion/data/fastqc-report

#Script to generate FastQC reports using the FastQC tool

# fastq files directory
FASTQ_DIR="/work/FAC/FBM/DEE/mrobinso/bgee/marion/data"

# fastqc reports directory
REPORT_DIR="/work/FAC/FBM/DEE/mrobinso/bgee/marion/data/fastqc-report"

for file in $FASTQ_DIR/*.fastq.gz; do
   fastqc ${file} -o ${REPORT_DIR}
done

wait

module load gcc/10.4.0 multiqc

#Script to generate MultiQC reports using the MultiQC tool

mkdir -p /work/FAC/FBM/DEE/mrobinso/bgee/marion/data/multiqc

# fastqc directory
FASTQC_DIR="/work/FAC/FBM/DEE/mrobinso/bgee/marion/data/fastqc-report"

# Multiqc output directory
OUT_DIR="/work/FAC/FBM/DEE/mrobinso/bgee/marion/data/multiqc"

# run mutiqc
multiqc ${FASTQC_DIR}/*_fastqc.zip --outdir ${OUT_DIR}

