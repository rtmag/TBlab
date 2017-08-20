
~/programs/STAR/bin/Linux_x86_64/STAR --genomeDir /root/star_index/STAR_mm10_nogtf/ \
_overhang100 \
--readFilesCommand zcat \
--runThreadN 15 \
--alignIntronMax 1 \
--alignEndsType EndToEnd \
--readFilesIn /root/170512_NS500769_0037_AHM7TGAFXX_analysis/ATAC-20k_S1_R1.fastq.gz \
/root/170512_NS500769_0037_AHM7TGAFXX_analysis/ATAC-20k_S1_R2.fastq.gz \
--outSAMtype BAM SortedByCoordinate \
--outFileNamePrefix /root/bam/ATAC-20k_S1_

~/programs/STAR/bin/Linux_x86_64/STAR --genomeDir /root/star_index/STAR_mm10_nogtf/ \
_overhang100 \
--readFilesCommand zcat \
--runThreadN 15 \
--alignIntronMax 1 \
--alignEndsType EndToEnd \
--readFilesIn /root/170512_NS500769_0037_AHM7TGAFXX_analysis/ATAC-20k_S2_R1.fastq.gz \
/root/170512_NS500769_0037_AHM7TGAFXX_analysis/ATAC-20k_S2_R2.fastq.gz \
--outSAMtype BAM SortedByCoordinate \
--outFileNamePrefix /root/bam/ATAC-20k_S2_

# Genome track file
