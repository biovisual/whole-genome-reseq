#!/bin/bash

#SBATCH -p general
#SBATCH -n 6
#SBATCH -N 1
#SBATCH --mem 30000
#SBATCH -t 1-00:00:00
#SBATCH -J angsd_LRT_20
#SBATCH -o logs/angsd_LRT_%A_%a.out
#SBATCH -e logs/angsd_LRT_%A_%a.err
#SBATCH --constraint=holyib
#SBATCH --array=0-30

module load angsd/0.911-fasrc01

REF=../genome/final.assembly.homo.fa

SAMPLES=$1
BAMLISTDIR=$2
MININD=$3
MINCOV=$4
MAXCOV=$5
GLMODEL=$6
ASSO=$7

#Use Samtools model for GL calculation, infer major/minor based on HF reference, calculate Likelhood Ratio Tests comparing samples from different time points.

angsd -bam ${BAMLISTDIR}/${SAMPLES}_BamList.txt -ref ${REF} -out results_LRTInt_Asso${ASSO}_GL${GLMODEL}/${SAMPLES}_20_${SLURM_ARRAY_TASK_ID} -uniqueOnly 1 -remove_bads 1 -trim 0 -minMapQ 20 -only_proper_pairs 0 -minQ 20 -minInd ${MININD} -setMinDepth ${MINCOV} -setMaxDepth ${MAXCOV} -doMaf 2 -doMajorMinor 4 -GL ${GLMODEL} -nThreads 6 -ybin ${BAMLISTDIR}/${SAMPLES}_yBin.txt -doAsso ${ASSO} -SNP_pval 1e-6 -minMaf 0.10 -doPost 1 -rf split_fai_int20_angsd/final.assembly.homo.fa_20_${SLURM_ARRAY_TASK_ID} 
