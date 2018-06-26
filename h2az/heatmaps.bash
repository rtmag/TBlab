
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

