#!/bin/bash
#
#SBATCH --mail-user=hehouts@ucdavis.edu   # Your email
#SBATCH --mail-type=ALL             # Options: ALL, NONE, BEGIN, END, FAIL, REQUEUE
#SBATCH -J sgc                   # Job name (limit character usage)
#SBATCH -e batch.err               # batch script's standard error file
#SBATCH -o batch.out               # batch script's standard output file
#SBATCH --time=00-20:00:00          # time allocated to this job FORMAT: dd-hh:mm:ss
#SBATCH --mem=70Gb                  # memory allocated to each node
#SBATCH --partition bmm     # partition to request resources from

set -e # exits job upon running into an error
set -x # print commands and their arguments as they are executed.

conda activate sgc
python -m spacegraphcats run config_mvx_k15_r1.yml extract_contigs extract_reads --nolock