
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
/root/quy/ach2az/HL-60_ActD_acH2AZ.bw \
/root/quy/h2az/HL-60_ActD_H2AZ.bw \
/root/quy/ach2az/HL-60_DMSO_acH2AZ.bw \
/root/quy/h2az/HL-60_DMSO_H2AZ.bw \
/root/quy/ach2az/HL-60_DRB_acH2AZ.bw \
/root/quy/h2az/HL-60_DRB_H2AZ.bw \
-R hg38_tss_filteredbyRPKM.bed --referencePoint center --outFileSortedRegions hg38_tss_filteredbyRPKM_sorted.bed \
--sortRegions descend -bs 1 -a 4000 -b 4000 -p max -out h2az_1bp_4kb.mat


plotHeatmap --xAxisLabel "" --yAxisLabel "" --refPointLabel "TSS" --colorMap Blues \
-m h2_mnase.mat --regionsLabel "genes" \
 --samplesLabel "HL-60_ActD" "HL-60_DMSO" "HL-60_DRB" \
-out h2_mnase.pdf


###########################################################################################################
