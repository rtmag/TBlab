STAR --genomeDir /home/rtm/resources/hg38/star/star_hg38_overhang100 \
_overhang100 \
--readFilesCommand zcat \
--runThreadN 15 \
--alignIntronMax 1 \
--alignEndsType EndToEnd \
--readFilesIn HCT116-ATAC-25k-1_R1_combined.fastq.gz \
HCT116-ATAC-25k-1_R2_combined.fastq.gz \
--outSAMtype BAM SortedByCoordinate \
--outFileNamePrefix atac_steph1_

STAR --genomeDir /home/rtm/resources/hg38/star/star_hg38_overhang100 \
_overhang100 \
--readFilesCommand zcat \
--runThreadN 15 \
--alignIntronMax 1 \
--alignEndsType EndToEnd \
--readFilesIn HCT116-ATAC-25k-2_R1_combined.fastq.gz \
HCT116-ATAC-25k-2_R2_combined.fastq.gz \
--outSAMtype BAM SortedByCoordinate \
--outFileNamePrefix atac_steph2_
#

bamCoverage -b atac_steph1_Aligned.sortedByCoord.out.bam \
--numberOfProcessors 15 \
--normalizeTo1x 2451960000 \
-bs 1 \
-o hct116_atac1.bw

bamCoverage -b atac_steph2_Aligned.sortedByCoord.out.bam \
--numberOfProcessors 15 \
--normalizeTo1x 2451960000 \
-bs 1 \
-o hct116_atac2.bw
