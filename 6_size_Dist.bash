

perl -e ' $col=8;  while (<>) { s/\r?\n//; @F = split /\t/, $_; $val = $F[$col]; if (! exists $count{$val}) { push @order, $val } $count{$val}++; } foreach $val (@order) { print "$val\t$count{$val}\n" } warn "\nPrinted number of occurrences for ", scalar(@order), " values in $. lines.\n\n"; ' CR1_filtered.sam > CR1_filtered_unique.counts.txt

perl -e ' $col=8;  while (<>) { s/\r?\n//; @F = split /\t/, $_; $val = $F[$col]; if (! exists $count{$val}) { push @order, $val } $count{$val}++; } foreach $val (@order) { print "$val\t$count{$val}\n" } warn "\nPrinted number of occurrences for ", scalar(@order), " values in $. lines.\n\n"; ' CR1_sacCer3_bowtieoutput.sam > CR1_sacCer3_unique.counts.txt