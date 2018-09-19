# CUT-RUN
Example scripts for analyzing CUT&amp;RUN datasets


Here is the general pipeline for analysis:

1) trim reads to 25 bases (while keeping paired)

awk '{if(NR%4==1){print $1} else{print substr($1, 1, 25)}}' CUTandRUN111213_S1_L001_R1_001.fastq > CUTandRUN111213_S1_L001_R1_001_trim25.fastq

awk '{if(NR%4==1){print $1} else{print substr($1, 1, 25)}}' CUTandRUN111213_S1_L001_R2_001.fastq > CUTandRUN111213_S1_L001_R2_001_trim25.fastq

2) split reads using novocraft (also trims off barcode with -l option)


3) Align reads using Bowtie2 (align to yeast or to mouse)

bowtie2 -q -N 1 -X 2000 -x /path_to/mm10 -1 /path_to/50K_Brg1_R1.fastq -2 /path_to/50K_Brg1_R2.fastq -S 50K_Brg1_bowtieoutput.sam

bowtie2 -q -N 1 -X 2000 -x /path_to/sacCer3 -1 /path_to/50K_Brg1_R1.fastq -2 /path_to/50K_Brg1_R2.fastq -S 50K_Brg1_sacCer3_bowtieoutput.sam

*note, can use -X 1000, or even less, rather than 2000

4) Remove duplicate reads (created through PCR) using Picard

java -Xmx4g -jar /path_to/picard-tools-2.5.0/picard.jar SortSam INPUT=50K_Brg1_bowtieoutput.sam OUTPUT=50K_Brg1_Picard.bam VALIDATION_STRINGENCY=LENIENT TMP_DIR=/tmp SORT_ORDER=coordinate

java -Xmx4g -jar /path_to/picard-tools-2.5.0/picard.jar MarkDuplicates INPUT=50K_Brg1_Picard.bam OUTPUT=50K_Brg1_Picard2.bam VALIDATION_STRINGENCY=LENIENT TMP_DIR=/tmp METRICS_FILE=dup.txt REMOVE_DUPLICATES=true

5) Remove low quality reads (MAPQ <10)


samtools view -h -o 50K_Brg1_Picard2.sam 50K_Brg1_Picard2.bam  
samtools view -Sq 10 50K_Brg1_Picard2.sam > 50K_Brg1_Picard2_filtered.sam


6) Make Size Distribution file for mm10

perl -e ' $col=8;  while (<>) { s/\r?\n//; @F = split /\t/, $_; $val = $F[$col]; if (! exists $count{$val}) { push @order, $val } $count{$val}++; } foreach $val (@order) { print "$val\t$count{$val}\n" } warn "\nPrinted number of occurrences for ", scalar(@order), " values in $. lines.\n\n"; ' Picard2_filtered.sam > Picard2_filtered_unique.counts.txt

5B) Make size distribution for sacCer3, spike in:

perl -e ' $col=8;  while (<>) { s/\r?\n//; @F = split /\t/, $_; $val = $F[$col]; if (! exists $count{$val}) { push @order, $val } $count{$val}++; } foreach $val (@order) { print "$val\t$count{$val}\n" } warn "\nPrinted number of occurrences for ", scalar(@order), " values in $. lines.\n\n"; ' sacCer3_bowtieoutput.sam > sacCer3_unique.counts.txt

7) Make size classes (1-120 for TF, 150-500 for 

awk ' $9 <= 120 && $9 >= 1 || $9 >= -120 && $9 <= -1 ' 50K_Brg1_Picard2_filtered.sam > 50K_Brg1.1_120.sam
cp bowtie2.header 50K_Brg1.1_120.header
cat 50K_Brg1.1_120.sam >> 50K_Brg1.1_120.header
rm 50K_Brg1.1_120.sam
mv 50K_Brg1.1_120.header 50K_Brg1.1_120.sam
samtools view -S -t /path_to/mm10.chrom.sizes -b -o 50K_Brg1.1_120.bam 50K_Brg1.1_120.sam
rm 50K_Brg1.1_120.sam

awk ' $9 <= 500 && $9 >= 150 || $9 >= -500 && $9 <= -150 ' 50K_Brg1_Picard2_filtered.sam > 50K_Brg1.150_500.sam
cp bowtie2.header 50K_Brg1.150_500.header
cat 50K_Brg1.150_500.sam >> 50K_Brg1.150_500.header
rm 50K_Brg1.150_500.sam
mv 50K_Brg1.150_500.header 50K_Brg1.150_500.sam
samtools view -S -t /path_to/mm10.chrom.sizes -b -o 50K_Brg1.150_500.bam 50K_Brg1.150_500.sam
rm 50K_Brg1.150_500.sam

8) Homer analysis

makeTagDirectory 

makeUCSCfile 

make aggregation plots or heatmaps over specific anchor location (using annotatepeaks.pl)

call peaks (using findPeaks.pl)

find motifs (using findMotifs.pl)
