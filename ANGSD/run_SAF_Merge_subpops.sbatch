#!/bin/bash

#SBATCH -p shared
#SBATCH -n 1
#SBATCH -N 1
#SBATCH --mem 16000
#SBATCH -t 1-0:00:00
#SBATCH -J angsd_saf_merge
#SBATCH -o logs/angsd_saf_merge_%j.out
#SBATCH -e logs/angsd_saf_merge_%j.err
#SBATCH --constraint=holyib

module load gcc/4.8.2-fasrc01 ngsTools/20170201-fasrc01

SAMPLES=$1

realSFS cat results_saf_subpops/${SAMPLES}_Int1.saf.idx results_saf_subpops/${SAMPLES}_Int2.saf.idx results_saf_subpops/${SAMPLES}_Int3.saf.idx results_saf_subpops/${SAMPLES}_Int4.saf.idx results_saf_subpops/${SAMPLES}_Int5.saf.idx results_saf_subpops/${SAMPLES}_Int6.saf.idx results_saf_subpops/${SAMPLES}_Int7.saf.idx results_saf_subpops/${SAMPLES}_Int8.saf.idx results_saf_subpops/${SAMPLES}_Int9.saf.idx results_saf_subpops/${SAMPLES}_Int10.saf.idx results_saf_subpops/${SAMPLES}_Int11.saf.idx results_saf_subpops/${SAMPLES}_Int12.saf.idx results_saf_subpops/${SAMPLES}_Int13.saf.idx results_saf_subpops/${SAMPLES}_Int14.saf.idx results_saf_subpops/${SAMPLES}_Int15.saf.idx results_saf_subpops/${SAMPLES}_Int16.saf.idx results_saf_subpops/${SAMPLES}_Int17.saf.idx results_saf_subpops/${SAMPLES}_Int18.saf.idx results_saf_subpops/${SAMPLES}_Int19.saf.idx results_saf_subpops/${SAMPLES}_Int20.saf.idx -outnames results_saf_merged/${SAMPLES}_merged