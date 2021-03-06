/root/myPrograms/STAR/bin/STAR --runThreadN 35 --runMode genomeGenerate --genomeDir /root/resources/mm10/ \
--genomeFastaFiles /root/resources/mm10/mm10.fasta 

##############################
##############################
##############################
##############################

/root/myPrograms/STAR/bin/STAR --genomeDir /root/resources/mm10/ \
_overhang100 \
--readFilesCommand zcat \
--runThreadN 35 \
--alignIntronMax 1 \
--alignEndsType EndToEnd \
--readFilesIn /root/ayako/ayako_dejavu/RawData/CD41_ATAC1/CD41_ATAC1_SD17090476_HG2JVCCXY_L2_1.fq.gz \
/root/ayako/ayako_dejavu/RawData/CD41_ATAC1/CD41_ATAC1_SD17090476_HG2JVCCXY_L2_2.fq.gz \
--outSAMtype BAM SortedByCoordinate \
--outFileNamePrefix /root/ayako/ayako_dejavu/bam/CD41+_untr_1_

/root/myPrograms/STAR/bin/STAR --genomeDir /root/resources/mm10/ \
_overhang100 \
--readFilesCommand zcat \
--runThreadN 35 \
--alignIntronMax 1 \
--alignEndsType EndToEnd \
--readFilesIn /root/ayako/ayako_dejavu/RawData/CD41_ATAC2/CD41_ATAC2_SD17090477_HG2JVCCXY_L2_1.fq.gz \
/root/ayako/ayako_dejavu/RawData/CD41_ATAC2/CD41_ATAC2_SD17090477_HG2JVCCXY_L2_2.fq.gz \
--outSAMtype BAM SortedByCoordinate \
--outFileNamePrefix /root/ayako/ayako_dejavu/bam/CD41+_untr_2_

/root/myPrograms/STAR/bin/STAR --genomeDir /root/resources/mm10/ \
_overhang100 \
--readFilesCommand zcat \
--runThreadN 35 \
--alignIntronMax 1 \
--alignEndsType EndToEnd \
--readFilesIn /root/ayako/ayako_dejavu/RawData/CD41_ATAC3/CD41_ATAC3_SD17090478_HG2JVCCXY_L2_1.fq.gz \
/root/ayako/ayako_dejavu/RawData/CD41_ATAC3/CD41_ATAC3_SD17090478_HG2JVCCXY_L2_2.fq.gz \
--outSAMtype BAM SortedByCoordinate \
--outFileNamePrefix /root/ayako/ayako_dejavu/bam/CD41+_untr_3_
##############################
##############################
/root/myPrograms/STAR/bin/STAR --genomeDir /root/resources/mm10/ \
_overhang100 \
--readFilesCommand zcat \
--runThreadN 35 \
--alignIntronMax 1 \
--alignEndsType EndToEnd \
--readFilesIn /root/ayako/ayako_dejavu/C401SC17100122/raw_data/T2/T2_SGL00012_HGLVWCCXY_L1_1.fq.gz \
/root/ayako/ayako_dejavu/C401SC17100122/raw_data/T2/T2_SGL00012_HGLVWCCXY_L1_2.fq.gz \
--outSAMtype BAM SortedByCoordinate \
--outFileNamePrefix /root/ayako/ayako_dejavu/bam/CD41+_tr_1_

/root/myPrograms/STAR/bin/STAR --genomeDir /root/resources/mm10/ \
_overhang100 \
--readFilesCommand zcat \
--runThreadN 35 \
--alignIntronMax 1 \
--alignEndsType EndToEnd \
--readFilesIn /root/ayako/ayako_dejavu/C401SC17100122/raw_data/T3/T3_SGL00013_HGLVWCCXY_L1_1.fq.gz \
/root/ayako/ayako_dejavu/C401SC17100122/raw_data/T3/T3_SGL00013_HGLVWCCXY_L1_2.fq.gz \
--outSAMtype BAM SortedByCoordinate \
--outFileNamePrefix /root/ayako/ayako_dejavu/bam/CD41+_tr_2_

/root/myPrograms/STAR/bin/STAR --genomeDir /root/resources/mm10/ \
_overhang100 \
--readFilesCommand zcat \
--runThreadN 35 \
--alignIntronMax 1 \
--alignEndsType EndToEnd \
--readFilesIn /root/ayako/ayako_dejavu/C401SC17100122/raw_data/T_2/T_2_SGL00014_HGLVWCCXY_L1_1.fq.gz \
/root/ayako/ayako_dejavu/C401SC17100122/raw_data/T_2/T_2_SGL00014_HGLVWCCXY_L1_2.fq.gz \
--outSAMtype BAM SortedByCoordinate \
--outFileNamePrefix /root/ayako/ayako_dejavu/bam/CD41-_tr_1_


/root/myPrograms/STAR/bin/STAR --genomeDir /root/resources/mm10/ \
_overhang100 \
--readFilesCommand zcat \
--runThreadN 35 \
--alignIntronMax 1 \
--alignEndsType EndToEnd \
--readFilesIn /root/ayako/ayako_dejavu/C401SC17100122/raw_data/T_3/T_3_SGL00015_HGLVWCCXY_L1_1.fq.gz \
/root/ayako/ayako_dejavu/C401SC17100122/raw_data/T_3/T_3_SGL00015_HGLVWCCXY_L1_2.fq.gz \
--outSAMtype BAM SortedByCoordinate \
--outFileNamePrefix /root/ayako/ayako_dejavu/bam/CD41-_tr_2_

##############################
##############################
##############################
##############################

java -jar /root/myPrograms/picard/build/libs/picard.jar MarkDuplicates REMOVE_DUPLICATES=true I=/root/ayako/ayako_dejavu/bam/CD41+_untr_1_Aligned.sortedByCoord.out.bam \
O=/root/ayako/ayako_dejavu/bam/CD41+_untr_1_Aligned_rmdup.sortedByCoord.out.bam M=/root/ayako/ayako_dejavu/bam/CD41+_untr_1.mfile

java -jar /root/myPrograms/picard/build/libs/picard.jar MarkDuplicates REMOVE_DUPLICATES=true I=/root/ayako/ayako_dejavu/bam/CD41+_untr_2_Aligned.sortedByCoord.out.bam \
O=/root/ayako/ayako_dejavu/bam/CD41+_untr_2_Aligned_rmdup.sortedByCoord.out.bam M=/root/ayako/ayako_dejavu/bam/CD41+_untr_2.mfile

java -jar /root/myPrograms/picard/build/libs/picard.jar MarkDuplicates REMOVE_DUPLICATES=true I=/root/ayako/ayako_dejavu/bam/CD41+_untr_3_Aligned.sortedByCoord.out.bam \
O=/root/ayako/ayako_dejavu/bam/CD41+_untr_3_Aligned_rmdup.sortedByCoord.out.bam M=/root/ayako/ayako_dejavu/bam/CD41+_untr_3.mfile

java -jar /root/myPrograms/picard/build/libs/picard.jar MarkDuplicates REMOVE_DUPLICATES=true I=/root/ayako/ayako_dejavu/bam/CD41+_tr_1_Aligned.sortedByCoord.out.bam \
O=/root/ayako/ayako_dejavu/bam/CD41+_tr_1_Aligned_rmdup.sortedByCoord.out.bam M=/root/ayako/ayako_dejavu/bam/CD41+_tr_1.mfile

java -jar /root/myPrograms/picard/build/libs/picard.jar MarkDuplicates REMOVE_DUPLICATES=true I=/root/ayako/ayako_dejavu/bam/CD41+_tr_2_Aligned.sortedByCoord.out.bam \
O=/root/ayako/ayako_dejavu/bam/CD41+_tr_2_Aligned_rmdup.sortedByCoord.out.bam M=/root/ayako/ayako_dejavu/bam/CD41+_tr_2.mfile

java -jar /root/myPrograms/picard/build/libs/picard.jar MarkDuplicates REMOVE_DUPLICATES=true I=/root/ayako/ayako_dejavu/bam/CD41-_tr_1_Aligned.sortedByCoord.out.bam \
O=/root/ayako/ayako_dejavu/bam/CD41-_tr_1_Aligned_rmdup.sortedByCoord.out.bam M=/root/ayako/ayako_dejavu/bam/CD41-_tr_1.mfile

java -jar /root/myPrograms/picard/build/libs/picard.jar MarkDuplicates REMOVE_DUPLICATES=true I=/root/ayako/ayako_dejavu/bam/CD41-_tr_2_Aligned.sortedByCoord.out.bam \
O=/root/ayako/ayako_dejavu/bam/CD41-_tr_2_Aligned_rmdup.sortedByCoord.out.bam M=/root/ayako/ayako_dejavu/bam/CD41-_tr_2.mfile

##############################
##############################
##############################
##############################

samtools index /root/ayako/ayako_dejavu/bam/CD41+_untr_1_Aligned_rmdup.sortedByCoord.out.bam &
samtools index /root/ayako/ayako_dejavu/bam/CD41+_untr_2_Aligned_rmdup.sortedByCoord.out.bam &
samtools index /root/ayako/ayako_dejavu/bam/CD41+_untr_3_Aligned_rmdup.sortedByCoord.out.bam &
samtools index /root/ayako/ayako_dejavu/bam/CD41+_tr_1_Aligned_rmdup.sortedByCoord.out.bam &
samtools index /root/ayako/ayako_dejavu/bam/CD41+_tr_2_Aligned_rmdup.sortedByCoord.out.bam
samtools index /root/ayako/ayako_dejavu/bam/CD41-_tr_1_Aligned_rmdup.sortedByCoord.out.bam
samtools index /root/ayako/ayako_dejavu/bam/CD41-_tr_2_Aligned_rmdup.sortedByCoord.out.bam

##############################
##############################
##############################
##############################

bamCoverage -p max -bs 1 --normalizeUsingRPKM -b /root/ayako/ayako_dejavu/bam/CD41+_untr_1_Aligned_rmdup.sortedByCoord.out.bam -o /root/ayako/ayako_dejavu/bw/CD41+_untr_1.bw
bamCoverage -p max -bs 1 --normalizeUsingRPKM -b /root/ayako/ayako_dejavu/bam/CD41+_untr_2_Aligned_rmdup.sortedByCoord.out.bam -o /root/ayako/ayako_dejavu/bw/CD41+_untr_2.bw
bamCoverage -p max -bs 1 --normalizeUsingRPKM -b /root/ayako/ayako_dejavu/bam/CD41+_untr_3_Aligned_rmdup.sortedByCoord.out.bam -o /root/ayako/ayako_dejavu/bw/CD41+_untr_3.bw
bamCoverage -p max -bs 1 --normalizeUsingRPKM -b /root/ayako/ayako_dejavu/bam/CD41+_tr_1_Aligned_rmdup.sortedByCoord.out.bam -o /root/ayako/ayako_dejavu/bw/CD41+_tr_1.bw
bamCoverage -p max -bs 1 --normalizeUsingRPKM -b /root/ayako/ayako_dejavu/bam/CD41+_tr_2_Aligned_rmdup.sortedByCoord.out.bam -o /root/ayako/ayako_dejavu/bw/CD41+_tr_2.bw
bamCoverage -p max -bs 1 --normalizeUsingRPKM -b /root/ayako/ayako_dejavu/bam/CD41-_tr_1_Aligned_rmdup.sortedByCoord.out.bam -o /root/ayako/ayako_dejavu/bw/CD41-_tr_1.bw
bamCoverage -p max -bs 1 --normalizeUsingRPKM -b /root/ayako/ayako_dejavu/bam/CD41-_tr_2_Aligned_rmdup.sortedByCoord.out.bam -o /root/ayako/ayako_dejavu/bw/CD41-_tr_2.bw


##############################
##############################
##############################
##############################

samtools merge -f -h /root/ayako/ayako_dejavu/bam/CD41+_untr_1_Aligned_rmdup.sortedByCoord.out.bam /root/ayako/ayako_dejavu/bam/CD41+_untr.bam \
/root/ayako/ayako_dejavu/bam/CD41+_untr_1_Aligned_rmdup.sortedByCoord.out.bam /root/ayako/ayako_dejavu/bam/CD41+_untr_2_Aligned_rmdup.sortedByCoord.out.bam \
/root/ayako/ayako_dejavu/bam/CD41+_untr_3_Aligned_rmdup.sortedByCoord.out.bam &

samtools merge -f -h /root/ayako/ayako_dejavu/bam/CD41+_tr_1_Aligned_rmdup.sortedByCoord.out.bam /root/ayako/ayako_dejavu/bam/CD41+_tr.bam \
/root/ayako/ayako_dejavu/bam/CD41+_tr_1_Aligned_rmdup.sortedByCoord.out.bam /root/ayako/ayako_dejavu/bam/CD41+_tr_2_Aligned_rmdup.sortedByCoord.out.bam &

samtools merge -f -h /root/ayako/ayako_dejavu/bam/CD41-_tr_1_Aligned_rmdup.sortedByCoord.out.bam /root/ayako/ayako_dejavu/bam/CD41-_tr.bam \
/root/ayako/ayako_dejavu/bam/CD41-_tr_1_Aligned_rmdup.sortedByCoord.out.bam /root/ayako/ayako_dejavu/bam/CD41-_tr_2_Aligned_rmdup.sortedByCoord.out.bam &
##
##

macs2 callpeak -t /root/ayako/ayako_dejavu/bam/CD41+_untr.bam -f BAMPE --keep-dup all --nomodel --broad -g mm --outdir /root/ayako/ayako_dejavu/peakcall -n CD41+_untr &
macs2 callpeak -t /root/ayako/ayako_dejavu/bam/CD41+_tr.bam -f BAMPE --keep-dup all --nomodel --broad -g mm --outdir /root/ayako/ayako_dejavu/peakcall -n CD41+_tr &
macs2 callpeak -t /root/ayako/ayako_dejavu/bam/CD41-_tr.bam -f BAMPE --keep-dup all --nomodel --broad -g mm --outdir /root/ayako/ayako_dejavu/peakcall -n CD41-_tr &
##
macs2 callpeak -t /root/ayako/ayako_dejavu/bam/CD41+_untr.bam -f BAMPE --keep-dup all --nomodel --broad -g mm -q 0.05 --outdir /root/ayako/ayako_dejavu/peakcall -n CD41+_untr_fdr5 &
macs2 callpeak -t /root/ayako/ayako_dejavu/bam/CD41+_tr.bam -f BAMPE --keep-dup all --nomodel --broad -g mm -q 0.05 --outdir /root/ayako/ayako_dejavu/peakcall -n CD41+_tr_fdr5 &
macs2 callpeak -t /root/ayako/ayako_dejavu/bam/CD41-_tr.bam -f BAMPE --keep-dup all --nomodel --broad -g mm -q 0.05 --outdir /root/ayako/ayako_dejavu/peakcall -n CD41-_tr_fdr5 &
##
#
