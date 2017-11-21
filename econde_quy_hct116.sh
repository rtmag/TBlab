
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

java -jar ~/myPrograms/picard/build/libs/picard.jar MarkDuplicates REMOVE_DUPLICATES=true METRICS_FILE=atac_rmdup.txt INPUT=atac_steph1_Aligned.sortedByCoord.out.bam OUTPUT=atac_steph1_rmdup.bam
samtools index atac_steph1_rmdup.bam
bamCoverage -p max -bs 1 --normalizeUsingRPKM -b atac_steph1_rmdup.bam -o atac_rmdup.bw
##

computeMatrix reference-point \
-S atac_rmdup.bw P53_Venkata.bw P53_24h_doxo_s1.bw P53_48h_doxo_s1.bw H3K27ac.bw H3K4me1.bw H3K4me3.bw H3K27me3.bw H3K9me3.bw H3K36me3.bw \
-R FISHER_DMR.bed --referencePoint center \
--missingDataAsZero --sortRegions descend -bs 1 -a 2000 -b 2000 -p max -out FISHER_DMR.mat

computeMatrix reference-point \
-S atac_rmdup.bw P53_Venkata.bw P53_24h_doxo_s1.bw P53_48h_doxo_s1.bw H3K27ac.bw H3K4me1.bw H3K4me3.bw H3K27me3.bw H3K9me3.bw H3K36me3.bw \
-R fisher_neb_0.01_+1.bed --referencePoint center \
--missingDataAsZero --sortRegions descend -bs 1 -a 2000 -b 2000 -p max -out fisher_neb_0.01_+1.mat

computeMatrix reference-point \
-S atac_rmdup.bw P53_Venkata.bw P53_24h_doxo_s1.bw P53_48h_doxo_s1.bw H3K27ac.bw H3K4me1.bw H3K4me3.bw H3K27me3.bw H3K9me3.bw H3K36me3.bw \
-R undiff_90meth_15diff.bed --referencePoint center \
--missingDataAsZero --sortRegions descend -bs 1 -a 1000 -b 1000 -p max -out undiff_90meth_15diff.mat

#
cat diff_30diff_qval01.bed > diff_undiff.bed
echo '# Differentially Methylated' >> diff_undiff.bed
cat undiff_90meth_15diff.bed >> diff_undiff.bed
echo '# Non-differentially Methylated' >> diff_undiff.bed
#
computeMatrix reference-point \
-S atac_rmdup.bw  \
-R diff_undiff.bed --referencePoint center \
--missingDataAsZero --sortRegions descend -bs 1 -a 1000 -b 1000 -p max -out atac_diff_undiff.mat

plotHeatmap --xAxisLabel "" --refPointLabel "CpG" -m atac_diff_undiff.mat -out atac_diff_undiff.pdf
#

computeMatrix reference-point \
-S atac_rmdup.bw P53_Venkata.bw P53_24h_doxo_s1.bw P53_48h_doxo_s1.bw H3K27ac.bw H3K4me1.bw H3K4me3.bw H3K27me3.bw H3K9me3.bw H3K36me3.bw  \
-R diff_undiff.bed --referencePoint center \
--missingDataAsZero --sortRegions descend -bs 1 -a 1000 -b 1000 -p max -out diff_undiff.mat

plotHeatmap --xAxisLabel "" --refPointLabel "CpG" -m diff_undiff.mat -out diff_undiff.pdf

computeMatrix reference-point \
-S atac_rmdup.bw P53_Venkata.bw P53_24h_doxo_s1.bw P53_48h_doxo_s1.bw H3K27ac.bw H3K4me1.bw H3K4me3.bw H3K27me3.bw H3K9me3.bw H3K36me3.bw  \
-R diff_undiff.bed --referencePoint center \
--sortRegions descend -bs 1 -a 1000 -b 1000 -p max -out diff_undiff_z.mat

plotHeatmap --xAxisLabel "" --refPointLabel "CpG" -m diff_undiff_z.mat -out diff_undiff_z.pdf

##########
######
###
##

STAR --genomeDir ~/resources/star_hg38_overhang100/ \
--readFilesCommand zcat \
--runThreadN 45 \
--alignIntronMax 1 \
--alignEndsType EndToEnd \
--readFilesIn ENCFF000PBW.fastq.gz \
--outSAMtype BAM SortedByCoordinate \
--outFileNamePrefix ./input1_


STAR --genomeDir ~/resources/star_hg38_overhang100/ \
--readFilesCommand zcat \
--runThreadN 45 \
--alignIntronMax 1 \
--alignEndsType EndToEnd \
--readFilesIn ENCFF000PBY.fastq.gz \
--outSAMtype BAM SortedByCoordinate \
--outFileNamePrefix ./input2_

##########
samtools merge input.bam input1_Aligned.sortedByCoord.out.bam input2_Aligned.sortedByCoord.out.bam
java -jar ~/myPrograms/picard/build/libs/picard.jar MarkDuplicates REMOVE_DUPLICATES=true METRICS_FILE=input.txt INPUT=input.bam OUTPUT=input_rmdup.bam
##
#

macs2 callpeak -t /root/HCT116_histone_modification_Quy/STAR_alignment/bam/H3K4me1_rmdup_sort.bam -c /root/HCT116_histone_modification_Quy/raw_data/input/input_rmdup.bam -g hs --broad -q 0.01 --outdir /root/HCT116_histone_modification_Quy/STAR_alignment/peakcalls -n H3K4me1_ &
macs2 callpeak -t /root/HCT116_histone_modification_Quy/STAR_alignment/bam/H3K4me3_rmdup_sort.bam -c /root/HCT116_histone_modification_Quy/raw_data/input/input_rmdup.bam -g hs --broad -q 0.01 --outdir /root/HCT116_histone_modification_Quy/STAR_alignment/peakcalls -n H3K4me3_ &
macs2 callpeak -t /root/HCT116_histone_modification_Quy/STAR_alignment/bam/H3K27ac_rmdup_sort.bam -c /root/HCT116_histone_modification_Quy/raw_data/input/input_rmdup.bam -g hs --broad -q 0.01 --outdir /root/HCT116_histone_modification_Quy/STAR_alignment/peakcalls -n H3K27ac_ &
#
#
