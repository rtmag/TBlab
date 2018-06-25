

computeMatrix reference-point \
-S \
HL-60_ActD_smoothed.qnor.bigWig \
HL-60_DMSO_smoothed.qnor.bigWig \
HL-60_DRB_smoothed.qnor.bigWig \
-R hg38_tss_knownCanonical.bed --referencePoint center \
--sortRegions descend -bs 20 -a 2000 -b 2000 -p max -out h2_mnase.mat


plotHeatmap --xAxisLabel "" --yAxisLabel "" --refPointLabel "TSS" --colorMap Blues \
-m h2_mnase.mat --regionsLabel "genes" \
 --samplesLabel "HL-60_ActD" "HL-60_DMSO" "HL-60_DRB" \
-out h2_mnase.pdf
