#!/bin/bash

#SBATCH -p general
#SBATCH -n 12
#SBATCH -N 1
#SBATCH --mem 80000
#SBATCH -t 4-0:00:00
#SBATCH -J angsd_af
#SBATCH -o logs/angsd_af_%j.out
#SBATCH -e logs/angsd_af_%j.err
#SBATCH --constraint=holyib

#Use ANGSD 9.12
module load gcc/4.8.2-fasrc01 ngsTools/20170201-fasrc01

REF=../genome/final.assembly.homo.fa

SAMPLES=$1
BAMLISTDIR=$2

#Use GATK model for GL calculation, infer major/minor based on HF reference, write called genotype encoded as -1,0,1,2, and print major and minor alleles
#Filters are only keep unique hits, remove "bad" reads, no trimming, (didn't use filter for reads where mates could be mapped), only keep reads with a minimum mapping quality of 20, minimum read depth of 30 and maximum of 100 (based on the distribution), only keep sites where there are data for at least half of the individuals. Minimum base quality of 20

angsd -bam ${BAMLISTDIR}/${SAMPLES}_BamList.txt -ref $REF -uniqueOnly 1 -remove_bads 1 -trim 0 -minMapQ 20 -minQ 20 -minInd 4 -setMinDepth 30 -only_proper_pairs 0 -out results/${SAMPLES} -doMaf 3 -doMajorMinor 4 -GL 1 -nThreads 12

