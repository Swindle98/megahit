#!/bin/bash

# Script to extract the top 10,000 reads from each fastq.gz file in the current directory and gzip the output

for fq in *.fastq.gz; do
    out="${fq%.fastq.gz}_top10000.fastq.gz"
    zcat "$fq" | awk 'NR%4==1{c++} c<=10000' | gzip > "$out"
done