STAR --genomeDir /root/resources/star_hg38_overhang100/ \
--readFilesCommand zcat \
--runThreadN 1 \
--readFilesIn /root/kadhija/BioinfRNAData/08-12-2017/Set_B3_R1.fastq.gz \
/root/kadhija/BioinfRNAData/08-12-2017/Set_B3_R2.fastq.gz \
--outSAMtype BAM SortedByCoordinate  \
--outFileNamePrefix /root/kadhija/bam/control_

STAR --genomeDir /root/resources/star_hg38_overhang100/ \
--readFilesCommand zcat \
--runThreadN 1 \
--readFilesIn /root/kadhija/BioinfRNAData/21_11_2017/Set_B4_R1.fastq.gz \
/root/kadhija/BioinfRNAData/21_11_2017/Set_B4_R2.fastq.gz  \
--outSAMtype BAM SortedByCoordinate  \
--outFileNamePrefix /root/kadhija/bam/epsilon_

STAR --readFilesIn \
ERR671805_1.fastq.gz \
ERR671805_2.fastq.gz \
       --outFileNamePrefix ERR671805 \
       --readFilesCommand zcat --runThreadN 14 --genomeDir /logical_dev/resources/hg38_noanno/ \
       --outFilterMultimapNmax 1 --outFilterMismatchNmax 999 \
 --outFilterMismatchNoverLmax 0.06 \
       --alignIntronMax 1 --alignEndsType EndToEnd --alignMatesGapMax 2000 \
--outSAMtype BAM SortedByCoordinate

STAR --readFilesIn \
ERR671880.fastq.gz \
       --outFileNamePrefix ERR671880 \
       --readFilesCommand zcat --runThreadN 14 --genomeDir /logical_dev/resources/hg38_noanno/ \
       --outFilterMultimapNmax 1 --outFilterMismatchNmax 999 \
 --outFilterMismatchNoverLmax 0.06 \
       --alignIntronMax 1 --alignEndsType EndToEnd --alignMatesGapMax 2000 \
--outSAMtype BAM SortedByCoordinate
###
##
samtools index ERR671805Aligned.sortedByCoord.out.bam &
samtools index ERR671880Aligned.sortedByCoord.out.bam &
#
bamCoverage -p max -bs 1 --normalizeUsing CPM -b ERR671805Aligned.sortedByCoord.out.bam -o ERR671805_hl60_cebpe.bw
bamCoverage -p max -bs 1 --normalizeUsing CPM -b ERR671880Aligned.sortedByCoord.out.bam -o ERR671880_hl60_cebpe.bw
###
#

