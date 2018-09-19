module load samtools/0.0.19

awk ' $9 <= 120 && $9 >= 1 || $9 >= -120 && $9 <= -1 ' CR1_filtered.sam > CR1.1_120.sam
cp mm10_bowtie2.header CR1.1_120.header
cat CR1.1_120.sam >> CR1.1_120.header
rm CR1.1_120.sam
mv CR1.1_120.header CR1.1_120.sam
samtools view -S -t /path_to/mouse/mm10/mm10.chrom.sizes -b -o CR1.1_120.bam CR1.1_120.sam
rm CR1.1_120.sam

awk ' $9 <= 500 && $9 >= 150 || $9 >= -500 && $9 <= -150 ' CR1_filtered.sam > CR1.150_500.sam
cp mm10_bowtie2.header CR1.150_500.header
cat CR1.150_500.sam >> CR1.150_500.header
rm CR1.150_500.sam
mv CR1.150_500.header CR1.150_500.sam
samtools view -S -t /path_to/mouse/mm10/mm10.chrom.sizes -b -o CR1.150_500.bam CR1.150_500.sam
rm CR1.150_500.sam