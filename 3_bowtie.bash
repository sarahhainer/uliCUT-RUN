


module load bowtie2/2-2.1.0
module load samtools/0.0.19

bowtie2 -q -N 1 -X 1000 -x /path_to/mouse/mm10/mm10 -1 /path_to/CR1_R1.fq -2 /path_to/CR1_R2.fq -S CR1_bowtieoutput.sam

bowtie2 -q -N 1 -X 1000 -x /path_to/s_cerevisiae/sacCer3/sacCer3 -1 /path_to/CR1_R1.fq -2 /path_to/CR1_500000_R2.fq -S CR1_sacCer3_bowtieoutput.sam
