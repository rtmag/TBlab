
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
macs2 callpeak -f BAMPE -g mm --call-summits --nolambda --buffer-size 1000000 -q 0.001 -t ATAC-20k_S1_Aligned.sortedByCoord.out.bam -n ATAC_s1
macs2 callpeak -f BAMPE -g mm --call-summits --nolambda --buffer-size 1000000 -q 0.001 -t ATAC-20k_S2_Aligned.sortedByCoord.out.bam -n ATAC_s2
#
