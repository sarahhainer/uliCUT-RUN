

module load samtools/0.0.19

samtools view -h -o CR1_bowtieoutput_Picard2.sam CR1_bowtieoutput_Picard2.bam

samtools view -Sq 10 CR1_bowtieoutput_Picard2.sam > CR1_filtered.sam
