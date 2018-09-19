
module load samtools/0.0.19
module load java/1.8.0_77

java -Xmx4g -jar /path_to/picard-tools-2.5.0/picard.jar SortSam INPUT=CR1_bowtieoutput.sam OUTPUT=CR1_bowtieoutput_Picard.bam VALIDATION_STRINGENCY=LENIENT TMP_DIR=/tmp SORT_ORDER=coordinate

java -Xmx4g -jar /path_to/picard-tools-2.5.0/picard.jar MarkDuplicates INPUT=CR1_bowtieoutput_Picard.bam OUTPUT=CR1_bowtieoutput_Picard2.bam VALIDATION_STRINGENCY=LENIENT TMP_DIR=/tmp METRICS_FILE=dup.txt REMOVE_DUPLICATES=true