/root/myPrograms/STAR/bin/STAR --readFilesIn \
/root/stuff/ventaka/ChIP_S1_L001_R1_001.fastq.gz \
/root/stuff/ventaka/ChIP_S1_L001_R2_001.fastq.gz \
       --outFileNamePrefix /root/stuff/bam/P53_Venkata_ \
       --readFilesCommand zcat --runThreadN 30 --genomeDir /root/resources/star_hg38_overhang100/ \
       --outFilterMultimapNmax 1 --outFilterMismatchNmax 999 \
 --outFilterMismatchNoverLmax 0.06 \
       --alignIntronMax 1 --alignEndsType EndToEnd --alignMatesGapMax 2000 \
       --outSAMtype BAM SortedByCoordinate
       
 /root/myPrograms/STAR/bin/STAR --readFilesIn \
/root/stuff/fastq/P53-P007_48hr_doxo-36038012/P53_48h_doxo_R1.fastq.gz \
/root/stuff/fastq/P53-P007_48hr_doxo-36038012/P53_48h_doxo_R2.fastq.gz \
       --outFileNamePrefix /root/stuff/bam/P53_48h_doxo_s1_ \
       --readFilesCommand zcat --runThreadN 30 --genomeDir /root/resources/star_hg38_overhang100/ \
       --outFilterMultimapNmax 1 --outFilterMismatchNmax 999 \
 --outFilterMismatchNoverLmax 0.06 \
       --alignIntronMax 1 --alignEndsType EndToEnd --alignMatesGapMax 2000 \
       --outSAMtype BAM SortedByCoordinate
       
  /root/myPrograms/STAR/bin/STAR --readFilesIn \
/root/stuff/fastq/P53-P007_24hr_doxo-36037017/P53_24h_doxo_R1.fastq.gz \
/root/stuff/fastq/P53-P007_24hr_doxo-36037017/P53_24h_doxo_R2.fastq.gz \
       --outFileNamePrefix /root/stuff/bam/P53_24h_doxo_s1_ \
       --readFilesCommand zcat --runThreadN 30 --genomeDir /root/resources/star_hg38_overhang100/ \
       --outFilterMultimapNmax 1 --outFilterMismatchNmax 999 \
 --outFilterMismatchNoverLmax 0.06 \
       --alignIntronMax 1 --alignEndsType EndToEnd --alignMatesGapMax 2000 \
       --outSAMtype BAM SortedByCoordinate
       
  /root/myPrograms/STAR/bin/STAR --readFilesIn \
/root/stuff/RawData/P007_48_DMSO/P007_48_DMSO_1.fq.gz \
/root/stuff/RawData/P007_48_DMSO/P007_48_DMSO_2.fq.gz \
       --outFileNamePrefix /root/stuff/bam/input_48_DMSO_ \
       --readFilesCommand zcat --runThreadN 30 --genomeDir /root/resources/star_hg38_overhang100/ \
       --outFilterMultimapNmax 1 --outFilterMismatchNmax 999 \
 --outFilterMismatchNoverLmax 0.06 \
       --alignIntronMax 1 --alignEndsType EndToEnd --alignMatesGapMax 2000 \
       --outSAMtype BAM SortedByCoordinate
       
  /root/myPrograms/STAR/bin/STAR --readFilesIn \
/root/stuff/RawData/P007_48_DOXO/P007_48_DOXO_1.fq.gz \
/root/stuff/RawData/P007_48_DOXO/P007_48_DOXO_2.fq.gz \
       --outFileNamePrefix /root/stuff/bam/input_48_DOXO_ \
       --readFilesCommand zcat --runThreadN 30 --genomeDir /root/resources/star_hg38_overhang100/ \
       --outFilterMultimapNmax 1 --outFilterMismatchNmax 999 \
 --outFilterMismatchNoverLmax 0.06 \
       --alignIntronMax 1 --alignEndsType EndToEnd --alignMatesGapMax 2000 \
       --outSAMtype BAM SortedByCoordinate
       
  /root/myPrograms/STAR/bin/STAR --readFilesIn \
/root/stuff/RawData/TP53_48_DOXO/TP53_48_DOXO_1.fq.gz \
/root/stuff/RawData/TP53_48_DOXO/TP53_48_DOXO_2.fq.gz \
       --outFileNamePrefix /root/stuff/bam/TP53_48_DOXO_ \
       --readFilesCommand zcat --runThreadN 30 --genomeDir /root/resources/star_hg38_overhang100/ \
       --outFilterMultimapNmax 1 --outFilterMismatchNmax 999 \
 --outFilterMismatchNoverLmax 0.06 \
       --alignIntronMax 1 --alignEndsType EndToEnd --alignMatesGapMax 2000 \
       --outSAMtype BAM SortedByCoordinate
       
   /root/myPrograms/STAR/bin/STAR --readFilesIn \
/root/stuff/RawData/TP53_48_DMSO/TP53_48_DMSO_1.fq.gz \
/root/stuff/RawData/TP53_48_DMSO/TP53_48_DMSO_2.fq.gz \
       --outFileNamePrefix /root/stuff/bam/TP53_48_DMSO_ \
       --readFilesCommand zcat --runThreadN 30 --genomeDir /root/resources/star_hg38_overhang100/ \
       --outFilterMultimapNmax 1 --outFilterMismatchNmax 999 \
 --outFilterMismatchNoverLmax 0.06 \
       --alignIntronMax 1 --alignEndsType EndToEnd --alignMatesGapMax 2000 \
       --outSAMtype BAM SortedByCoordinate
   
#######
samtools view -b -F 4 /root/stuff/bam/P53_Venkata_Aligned.sortedByCoord.out.bam > /root/stuff/bam/P53_Venkata.bam 
samtools view -b -F 4 /root/stuff/bam/P53_48h_doxo_s1_Aligned.sortedByCoord.out.bam > /root/stuff/bam/P53_48h_doxo_s1.bam 
samtools view -b -F 4 /root/stuff/bam/P53_24h_doxo_s1_Aligned.sortedByCoord.out.bam > /root/stuff/bam/P53_24h_doxo_s1.bam 

samtools view -b -F 4 /root/stuff/bam/input_48_DMSO_Aligned.sortedByCoord.out.bam > /root/stuff/bam/input_48_DMSO.bam 
samtools view -b -F 4 /root/stuff/bam/input_48_DOXO_Aligned.sortedByCoord.out.bam > /root/stuff/bam/input_48_DOXO.bam 
samtools view -b -F 4 /root/stuff/bam/TP53_48_DMSO_Aligned.sortedByCoord.out.bam > /root/stuff/bam/TP53_48_DMSO.bam 
samtools view -b -F 4 /root/stuff/bam/TP53_48_DOXO_Aligned.sortedByCoord.out.bam > /root/stuff/bam/TP53_48_DOXO.bam 

## DUP REMOVAL
java -jar /root/myPrograms/picard/build/libs/picard.jar MarkDuplicates REMOVE_DUPLICATES=true I=/root/stuff/bam/P53_Venkata.bam \
O=/root/stuff/bam/P53_Venkata_rmdup.bam  M=/root/stuff/bam/P53_Venkata.mfile

java -jar /root/myPrograms/picard/build/libs/picard.jar MarkDuplicates REMOVE_DUPLICATES=true I=/root/stuff/bam/P53_48h_doxo_s1.bam \
O=/root/stuff/bam/P53_48h_doxo_s1_rmdup.bam  M=/root/stuff/bam/P53_48h_doxo_s1.mfile

java -jar /root/myPrograms/picard/build/libs/picard.jar MarkDuplicates REMOVE_DUPLICATES=true I=/root/stuff/bam/P53_24h_doxo_s1.bam \
O=/root/stuff/bam/P53_24h_doxo_s1_rmdup.bam  M=/root/stuff/bam/P53_24h_doxo_s1.mfile

java -jar /root/myPrograms/picard/build/libs/picard.jar MarkDuplicates REMOVE_DUPLICATES=true I=/root/stuff/bam/input_48_DMSO.bam \
O=/root/stuff/bam/input_48_DMSO_rmdup.bam  M=/root/stuff/bam/input_48_DMSO.mfile

java -jar /root/myPrograms/picard/build/libs/picard.jar MarkDuplicates REMOVE_DUPLICATES=true I=/root/stuff/bam/input_48_DOXO.bam \
O=/root/stuff/bam/input_48_DOXO_rmdup.bam  M=/root/stuff/bam/input_48_DOXO.mfile

java -jar /root/myPrograms/picard/build/libs/picard.jar MarkDuplicates REMOVE_DUPLICATES=true I=/root/stuff/bam/TP53_48_DMSO.bam \
O=/root/stuff/bam/TP53_48_DMSO_rmdup.bam  M=/root/stuff/bam/TP53_48_DMSO.mfile

java -jar /root/myPrograms/picard/build/libs/picard.jar MarkDuplicates REMOVE_DUPLICATES=true I=/root/stuff/bam/TP53_48_DOXO.bam \
O=/root/stuff/bam/TP53_48_DOXO_rmdup.bam  M=/root/stuff/bam/TP53_48_DOXO.mfile

###### MACS2

macs2 callpeak -f BAMPE -g hs -q 0.05 --keep-dup auto --call-summits -n P53_Venkata --outdir /root/stuff/macs2/ \
-t /root/stuff/bam/P53_Venkata_rmdup.bam -c /root/stuff/bam/input_48_DOXO_rmdup.bam &

macs2 callpeak -f BAMPE -g hs -q 0.05 --keep-dup auto --call-summits -n P53_48h_doxo_s1 --outdir /root/stuff/macs2/ \
-t /root/stuff/bam/P53_48h_doxo_s1_rmdup.bam -c /root/stuff/bam/input_48_DOXO_rmdup.bam &

macs2 callpeak -f BAMPE -g hs -q 0.05 --keep-dup auto --call-summits -n TP53_48h_doxo --outdir /root/stuff/macs2/ \
-t /root/stuff/bam/TP53_48_DOXO_rmdup.bam -c /root/stuff/bam/input_48_DOXO_rmdup.bam &

macs2 callpeak -f BAMPE -g hs -q 0.05 --keep-dup auto --call-summits -n TP53_48h_dmso --outdir /root/stuff/macs2/ \
-t /root/stuff/bam/TP53_48_DMSO_rmdup.bam -c /root/stuff/bam/input_48_DMSO_rmdup.bam &
