
###########################################################################################################
bamCoverage -p max -bs 1 --normalizeUsing CPM --ignoreDuplicates \
-b /root/quy/ach2az/HL-60_ActD_hiEU/GRCh38.r88.align/after.trimming/Aligned.sortedByCoord.out.bam \
-o /root/quy/ach2az/HL-60_ActD_acH2AZ.bw

bamCoverage -p max -bs 1 --normalizeUsing CPM --ignoreDuplicates \
-b /root/quy/ach2az/HL-60_DMSO_hiEU/GRCh38.r88.align/after.trimming/Aligned.sortedByCoord.out.bam \
-o /root/quy/ach2az/HL-60_DMSO_acH2AZ.bw

bamCoverage -p max -bs 1 --normalizeUsing CPM --ignoreDuplicates \
-b /root/quy/ach2az/HL-60_DRB_hiEU/GRCh38.r88.align/after.trimming/Aligned.sortedByCoord.out.bam \
-o /root/quy/ach2az/HL-60_DRB_acH2AZ.bw
###########################################################################################################
bamCoverage -p max -bs 1 --normalizeUsing CPM \
-b /root/quy/h2az/HL-60_ActD_Aligned.sortedByCoord.out.rmdup.bam \
-o /root/quy/h2az/HL-60_ActD_H2AZ.bw

bamCoverage -p max -bs 1 --normalizeUsing CPM --ignoreDuplicates \
-b /root/quy/h2az/HL-60_DMSO_Aligned.sortedByCoord.out.rmdup.bam \
-o /root/quy/h2az/HL-60_DRB_H2AZ.bw

bamCoverage -p max -bs 1 --normalizeUsing CPM --ignoreDuplicates \
-b /root/quy/h2az/HL-60_DRB_Aligned.sortedByCoord.out.rmdup.bam \
-o /root/quy/h2az/HL-60_DMSO_H2AZ.bw
###########################################################################################################
more rpkm_wt_hl-60_all.txt |cut -f1 > rpkm_names.txt
###########################################################################################################
~/myPrograms/kentUtils/bin/bigWigToWig HL-60_ActD_acH2AZ.bw HL-60_ActD_acH2AZ.wig
~/myPrograms/kentUtils/bin/bigWigToWig HL-60_DMSO_acH2AZ.bw HL-60_DMSO_acH2AZ.wig &
~/myPrograms/kentUtils/bin/bigWigToWig HL-60_DRB_acH2AZ.bw HL-60_DRB_acH2AZ.wig &

awk -F"\t" '{ if($1 ~ /\#/){gsub("section ","section chr");print $0}else{print "chr"$0} }' HL-60_ActD_acH2AZ.wig > HL-60_ActD_acH2AZ_chrEDIT.wig &
awk -F"\t" '{ if($1 ~ /\#/){gsub("section ","section chr");print $0}else{print "chr"$0} }' HL-60_DMSO_acH2AZ.wig > HL-60_DMSO_acH2AZ_chrEDIT.wig &
awk -F"\t" '{ if($1 ~ /\#/){gsub("section ","section chr");print $0}else{print "chr"$0} }' HL-60_DRB_acH2AZ.wig > HL-60_DRB_acH2AZ_chrEDIT.wig &

perl -pe 's/chrMT/chrM/g' HL-60_ActD_acH2AZ_chrEDIT.wig > HL-60_ActD_acH2AZ_chrEDIT2.wig &
perl -pe 's/chrMT/chrM/g' HL-60_DMSO_acH2AZ_chrEDIT.wig > HL-60_DMSO_acH2AZ_chrEDIT2.wig &
perl -pe 's/chrMT/chrM/g' HL-60_DRB_acH2AZ_chrEDIT.wig > HL-60_DRB_acH2AZ_chrEDIT2.wig &

grep -v -P "chrKI|chrGL" HL-60_ActD_acH2AZ_chrEDIT2.wig > HL-60_ActD_acH2AZ_chrEDIT3.wig &
grep -v -P "chrKI|chrGL" HL-60_DMSO_acH2AZ_chrEDIT2.wig > HL-60_DMSO_acH2AZ_chrEDIT3.wig &
grep -v -P "chrKI|chrGL" HL-60_DRB_acH2AZ_chrEDIT2.wig > HL-60_DRB_acH2AZ_chrEDIT3.wig &

~/myPrograms/kentUtils/bin/wigToBigWig HL-60_ActD_acH2AZ_chrEDIT3.wig ~/resources/hg38.chrom.sizes HL-60_ActD_acH2AZ_chrEDIT.bigwig &
~/myPrograms/kentUtils/bin/wigToBigWig HL-60_DMSO_acH2AZ_chrEDIT3.wig ~/resources/hg38.chrom.sizes HL-60_DMSO_acH2AZ_chrEDIT.bigwig &
~/myPrograms/kentUtils/bin/wigToBigWig HL-60_DRB_acH2AZ_chrEDIT3.wig ~/resources/hg38.chrom.sizes HL-60_DRB_acH2AZ_chrEDIT.bigwig &
###########################################################################################################
computeMatrix reference-point \
-S \
/root/quy/ach2az/HL-60_DMSO_acH2AZ_chrEDIT.bigwig \
/root/quy/h2az/HL-60_DMSO_H2AZ.bw \
/root/quy/ach2az/HL-60_ActD_acH2AZ_chrEDIT.bigwig \
/root/quy/h2az/HL-60_ActD_H2AZ.bw \
/root/quy/ach2az/HL-60_DRB_acH2AZ_chrEDIT.bigwig \
/root/quy/h2az/HL-60_DRB_H2AZ.bw \
-R hg38_tss_filteredbyRPKM.bed --referencePoint center --outFileSortedRegions hg38_tss_filteredbyRPKM_sorted.bed \
--sortRegions descend -bs 1 -a 4000 -b 4000 -p max -out h2az_1bp_4kb_CPM.mat

plotHeatmap --xAxisLabel "" --yAxisLabel "" --refPointLabel "TSS" \
--colorList "white,#00BA38" "white,#00BA38" "white,#F8766D" "white,#F8766D" "white,#619CFF" "white,#619CFF" \
-m h2az_1bp_4kb_CPM.mat --regionsLabel "genes" \
 --samplesLabel "acH2AZ DMSO" "H2AZ DMSO" "acH2AZ ActD" "H2AZ ActD" "acH2AZ DRB" "H2AZ DRB" \
-out h2az_1bp_4kb_CPM.pdf


###########################################################################################################
computeMatrix reference-point \
-S \
/root/quy/ach2az/HL-60_DMSO_acH2AZ_chrEDIT.bigwig \
/root/quy/h2az/HL-60_DMSO_H2AZ.bw \
/root/quy/ach2az/HL-60_ActD_acH2AZ_chrEDIT.bigwig \
/root/quy/h2az/HL-60_ActD_H2AZ.bw \
/root/quy/ach2az/HL-60_DRB_acH2AZ_chrEDIT.bigwig \
/root/quy/h2az/HL-60_DRB_H2AZ.bw \
-R ../hg38_tss_filteredbyRPKM.bed --referencePoint center --outFileSortedRegions hg38_tss_filteredbyRPKM_sorted.bed \
--sortRegions descend -bs 20 -a 2000 -b 2000 -p max -out h2az_20bp_2kb_CPM.mat
###########################################################################################################
# Ac
computeMatrix reference-point \
-S \
/root/quy/ach2az/HL-60_DMSO_acH2AZ_chrEDIT.bigwig \
/root/quy/ach2az/HL-60_ActD_acH2AZ_chrEDIT.bigwig \
/root/quy/ach2az/HL-60_DRB_acH2AZ_chrEDIT.bigwig \
-R hg38_tss_filteredbyRPKM_sorted.bed --referencePoint center \
--sortRegions keep -bs 20 -a 2000 -b 2000 -p max -out ach2azOnly_20bp_2kb_CPM.mat \
--outFileNameMatrix ach2azOnly_20bp_2kb_CPM.rmat
# H2 CPM
#computeMatrix reference-point \
#-S \
#/root/quy/h2az/HL-60_DMSO_H2AZ.bw \
#/root/quy/h2az/HL-60_ActD_H2AZ.bw \
#/root/quy/h2az/HL-60_DRB_H2AZ.bw \
#-R hg38_tss_filteredbyRPKM_sorted.bed --referencePoint center \
#--sortRegions keep -bs 20 -a 2000 -b 2000 -p max -out h2azOnly_20bp_2kb_CPM.mat
# H2 Q MNASE
computeMatrix reference-point \
-S \
/root/quy/HL-60_DMSO_smoothed.qnor.bigWig \
/root/quy/HL-60_ActD_smoothed.qnor.bigWig \
/root/quy/HL-60_DRB_smoothed.qnor.bigWig \
-R hg38_tss_filteredbyRPKM_sorted.bed --referencePoint center \
--sortRegions keep -bs 20 -a 2000 -b 2000 -p max -out h2azOnly_20bp_2kb_QNORM.mat \
--outFileNameMatrix h2azOnly_20bp_2kb_QNORM.rmat
###########################################################################################################
plotHeatmap --xAxisLabel "" --yAxisLabel "" --refPointLabel "TSS" \
--colorMap Blues Reds Greens \
-m ach2azOnly_20bp_2kb_CPM.mat --regionsLabel "genes" \
 --samplesLabel "acH2AZ DRB" "acH2AZ ActD" "acH2AZ DMSO" \
-out ach2azOnly_20bp_2kb_CPM.pdf

#plotHeatmap --xAxisLabel "" --yAxisLabel "" --refPointLabel "TSS" \
#--colorMap Greens Reds Blues \
#-m h2azOnly_20bp_2kb_CPM.mat --regionsLabel "genes" \
# --samplesLabel "H2AZ DMSO" "H2AZ ActD" "H2AZ DRB" \
#-out h2azOnly_20bp_2kb_CPM.svg

plotHeatmap --xAxisLabel "" --yAxisLabel "" --refPointLabel "TSS" \
--colorMap Blues Reds Greens \
-m h2azOnly_20bp_2kb_QNORM.mat --regionsLabel "genes" \
 --samplesLabel "H2AZ DRB" "H2AZ ActD" "H2AZ DMSO" \
-out h2azOnly_20bp_2kb_QNORM.pdf

pdfjam ach2azOnly_20bp_2kb_CPM.pdf h2azOnly_20bp_2kb_QNORM.pdf --nup 2x1 --landscape
###########################################################################################################
 
plotProfile -m ach2azOnly_20bp_2kb_CPM.mat \
 --samplesLabel "acH2AZ DRB" "acH2AZ ActD" "acH2AZ DMSO" \
--colors "#619CFF" "#F8766D" "#00BA38" \
-out ach2azOnly_20bp_2kb_CPM_profile.pdf --perGroup --refPointLabel "TSS"
 
 plotProfile -m h2azOnly_20bp_2kb_QNORM.mat \
 --samplesLabel "H2AZ DRB" "H2AZ ActD" "H2AZ DMSO" \
--colors "#619CFF" "#F8766D" "#00BA38" \
-out h2azOnly_20bp_2kb_QNORM_profile.pdf --perGroup --refPointLabel "TSS"
