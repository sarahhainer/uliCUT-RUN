

awk '{if(NR%4==1){print $1} else{print substr($1, 1, 25)}}' CR1_R1.fastq > CR1_R1_trim25.fastq
awk '{if(NR%4==1){print $1} else{print substr($1, 1, 25)}}' CR1_R2.fastq > CR1_R2_trim25.fastq

