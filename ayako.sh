
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
macs2 callpeak -f BAMPE -g mm --call-summits --nolambda --buffer-size 1000000 -q 0.001 -t ATAC-20k_S1_Aligned.sortedByCoord.out.bam -n ATAC_s1 &
macs2 callpeak -f BAMPE -g mm --call-summits --nolambda --buffer-size 1000000 -q 0.001 -t ATAC-20k_S2_Aligned.sortedByCoord.out.bam -n ATAC_s2 &
#
macs2 callpeak -f BAMPE -g mm --call-summits --buffer-size 1000000 -q 0.01 -t ATAC-20k_S1_Aligned.sortedByCoord.out.bam -n ATAC_s1_fdr1 &
macs2 callpeak -f BAMPE -g mm --call-summits --buffer-size 1000000 -q 0.01 -t ATAC-20k_S2_Aligned.sortedByCoord.out.bam -n ATAC_s2_fdr1 &
#
macs2 callpeak -f BAMPE -g mm --call-summits --nolambda --buffer-size 1000000 -q 0.0001 -t ATAC-20k_S1_Aligned.sortedByCoord.out.bam -n ATAC_s1 &
macs2 callpeak -f BAMPE -g mm --call-summits --nolambda --buffer-size 1000000 -q 0.0001 -t ATAC-20k_S2_Aligned.sortedByCoord.out.bam -n ATAC_s2 &
#


macs2 callpeak -f BAMPE -g mm --call-summits --buffer-size 1000000 -q 0.0001 -t ATAC-20k_S1_Aligned.sortedByCoord.out.bam -n ATAC_s1_fdr0001 &
macs2 callpeak -f BAMPE -g mm --call-summits --buffer-size 1000000 -q 0.0001 -t ATAC-20k_S2_Aligned.sortedByCoord.out.bam -n ATAC_s2_fdr0001 &
#


macs2 callpeak -f BAMPE -g mm --call-summits --buffer-size 1000000 -q 0.00001 -t ATAC-20k_S1_Aligned.sortedByCoord.out.bam -n ATAC_s1_fdr00001 &
macs2 callpeak -f BAMPE -g mm --call-summits --buffer-size 1000000 -q 0.00001 -t ATAC-20k_S2_Aligned.sortedByCoord.out.bam -n ATAC_s2_fdr00001 &
#


macs2 callpeak -f BAMPE -g mm --call-summits --buffer-size 1000000 -q 0.000001 -t ATAC-20k_S1_Aligned.sortedByCoord.out.bam -n ATAC_s1_fdr000001 &
macs2 callpeak -f BAMPE -g mm --call-summits --buffer-size 1000000 -q 0.000001 -t ATAC-20k_S2_Aligned.sortedByCoord.out.bam -n ATAC_s2_fdr000001 &
#

