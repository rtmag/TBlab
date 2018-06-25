

computeMatrix reference-point \
-S \
/root/ong_dukenus/chip-seq/bw/sh143_input_1.bw \
/root/ong_dukenus/chip-seq/bw/sh400-input_1.bw \
/root/ong_dukenus/chip-seq/bw/shNT-input_1.bw \
-R /root/resources/hg19_tss_knownCanonical_noUnasembled.bed --referencePoint center \
--sortRegions descend -bs 20 -a 2000 -b 2000 -p max -out mnaseseq.mat


plotHeatmap --xAxisLabel "" --yAxisLabel "" --refPointLabel "TSS" --colorMap Blues \
-m mnaseseq.mat --regionsLabel "genes" \
 --samplesLabel "sh143" "sh400" "shNT" \
-out mnaseseq20.pdf
