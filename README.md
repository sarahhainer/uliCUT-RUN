# CUT-RUN
 Included in this GitHub are example scripts for analyzing CUT&amp;RUN datasets and peak files from previously published ChIP-seq datasets (peaks were called using HOMER)

Here is the general pipeline for analysis:

1) trim reads to 25 bases (while keeping paired)

2) split reads using novocraft (also trims off barcode with -l option)

3) Align reads using Bowtie2 (align to yeast or to mouse)

4) Remove duplicate reads (created through PCR) using Picard

5) Remove low quality reads (MAPQ <10)

6) Make Size Distribution file for mm10

6B) Make size distribution for sacCer3, spike in

7) Make size classes (1-120 for TF, 150-500 for histones)

8) Homer analysis

- makeTagDirectory 

- makeUCSCfile 

- make aggregation plots or heatmaps over specific anchor location 

- call peaks 

- find motifs 
