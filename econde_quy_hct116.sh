
samtools merge bam/H3K27ac.bam H3K27ac/ENCFF000VCQ_Aligned.sortedByCoord.out.bam H3K27ac/ENCFF000VCS_Aligned.sortedByCoord.out.bam

java -jar ~/myPrograms/picard/build/libs/picard.jar MarkDuplicates REMOVE_DUPLICATES=true METRICS_FILE=bam/H3K27ac.txt INPUT=bam/H3K27ac.bam OUTPUT=bam/H3K27ac_rmdup.bam
#
java -jar ~/myPrograms/picard/build/libs/picard.jar MarkDuplicates REMOVE_DUPLICATES=true METRICS_FILE=bam/H3K27me3.txt INPUT=bam/H3K27me3.bam OUTPUT=bam/H3K27me3_rmdup.bam
samtools sort H3K27me3_rmdup.bam -o H3K27me3_rmdup_sort.bam
cd bam
#
samtools merge bam/H3K27ac.bam H3K27ac/ENCFF000VCQ_Aligned.sortedByCoord.out.bam H3K27ac/ENCFF000VCS_Aligned.sortedByCoord.out.bam
samtools merge bam/H3K27me3.bam H3K27me3/ENCFF281SBT_ENCFF124GII_Aligned.sortedByCoord.out.bam H3K27me3/ENCFF851YMW_Aligned.sortedByCoord.out.bam
samtools merge bam/H3K36me3.bam H3K36me3/ENCFF002AAN_Aligned.sortedByCoord.out.bam H3K36me3/ENCFF002AAO_Aligned.sortedByCoord.out.bam
samtools merge bam/H3K4me1.bam H3K4me1/ENCFF000VCI_Aligned.sortedByCoord.out.bam H3K4me1/ENCFF000VCK_Aligned.sortedByCoord.out.bam
samtools merge bam/H3K4me3.bam H3K4me3/ENCFF183OZI_ENCFF659FPR_Aligned.sortedByCoord.out.bam H3K4me3/ENCFF960ZXH_Aligned.sortedByCoord.out.bam
samtools merge bam/H3K9me3.bam H3K9me3/ENCFF002AAK_Aligned.sortedByCoord.out.bam H3K9me3/ENCFF002AAM_Aligned.sortedByCoord.out.bam
#
java -jar ~/myPrograms/picard/build/libs/picard.jar MarkDuplicates REMOVE_DUPLICATES=true METRICS_FILE=bam/H3K27me3.txt INPUT=bam/H3K27me3.bam OUTPUT=bam/H3K27me3_rmdup.bam
java -jar ~/myPrograms/picard/build/libs/picard.jar MarkDuplicates REMOVE_DUPLICATES=true METRICS_FILE=bam/H3K36me3.txt INPUT=bam/H3K36me3.bam OUTPUT=bam/H3K36me3_rmdup.bam
java -jar ~/myPrograms/picard/build/libs/picard.jar MarkDuplicates REMOVE_DUPLICATES=true METRICS_FILE=bam/H3K4me1.txt INPUT=bam/H3K4me1.bam OUTPUT=bam/H3K4me1_rmdup.bam
java -jar ~/myPrograms/picard/build/libs/picard.jar MarkDuplicates REMOVE_DUPLICATES=true METRICS_FILE=bam/H3K4me3.txt INPUT=bam/H3K4me3.bam OUTPUT=bam/H3K4me3_rmdup.bam
java -jar ~/myPrograms/picard/build/libs/picard.jar MarkDuplicates REMOVE_DUPLICATES=true METRICS_FILE=bam/H3K9me3.txt INPUT=bam/H3K9me3.bam OUTPUT=bam/H3K9me3_rmdup.bam
java -jar ~/myPrograms/picard/build/libs/picard.jar MarkDuplicates REMOVE_DUPLICATES=true METRICS_FILE=bam/H3K27ac.txt INPUT=bam/H3K27ac.bam OUTPUT=bam/H3K27ac_rmdup.bam
#
cd bam
#
samtools sort H3K27me3_rmdup.bam -o H3K27me3_rmdup_sort.bam
samtools sort H3K36me3_rmdup.bam -o H3K36me3_rmdup_sort.bam
samtools sort H3K4me1_rmdup.bam -o H3K4me1_rmdup_sort.bam
samtools sort H3K4me3_rmdup.bam -o H3K4me3_rmdup_sort.bam
samtools sort H3K9me3_rmdup.bam -o H3K9me3_rmdup_sort.bam
samtools sort H3K27ac_rmdup.bam -o H3K27ac_rmdup_sort.bam
#
#
java -jar ~/myPrograms/picard/build/libs/picard.jar MarkDuplicates REMOVE_DUPLICATES=true METRICS_FILE=bam/H3K27me3.txt INPUT=bam/H3K27me3.bam OUTPUT=bam/H3K27me3_rmdup.bam
samtools sort H3K27me3_rmdup.bam -o H3K27me3_rmdup_sort.bam
cd bam
#
samtools index H3K27me3_rmdup_sort.bam
samtools index H3K36me3_rmdup_sort.bam
samtools index H3K4me1_rmdup_sort.bam
samtools index H3K4me3_rmdup_sort.bam
samtools index H3K9me3_rmdup_sort.bam
samtools index H3K27ac_rmdup_sort.bam
#
bamCoverage -p max -bs 1 -e 200 --normalizeUsingRPKM -b H3K27me3_rmdup_sort.bam -o H3K27me3.bw
bamCoverage -p max -bs 1 -e 200 --normalizeUsingRPKM -b H3K36me3_rmdup_sort.bam -o H3K36me3.bw
bamCoverage -p max -bs 1 -e 200 --normalizeUsingRPKM -b H3K4me1_rmdup_sort.bam -o H3K4me1.bw
bamCoverage -p max -bs 1 -e 200 --normalizeUsingRPKM -b H3K4me3_rmdup_sort.bam -o H3K4me3.bw
bamCoverage -p max -bs 1 -e 200 --normalizeUsingRPKM -b H3K9me3_rmdup_sort.bam -o H3K9me3.bw
bamCoverage -p max -bs 1 -e 200 --normalizeUsingRPKM -b H3K27ac_rmdup_sort.bam -o H3K27ac.bw
#
samtools index atac_steph1_Aligned.sortedByCoord.out.bam
bamCoverage -p max -bs 1 --normalizeUsingRPKM -b atac_steph1_Aligned.sortedByCoord.out.bam -o atac.bw
#



makeTagDirectory Macrophage-H3K4me1-ChIP-Seq/ s_1_sequence.align.sam  -format bam
