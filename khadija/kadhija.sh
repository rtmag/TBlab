STAR --genomeDir /root/resources/star_hg38_overhang100/ \
--readFilesCommand zcat \
--runThreadN 1 \
--readFilesIn /root/kadhija/BioinfRNAData/08-12-2017/Set_B3_R1.fastq.gz \
/root/kadhija/BioinfRNAData/08-12-2017/Set_B3_R2.fastq.gz \
--outSAMtype BAM SortedByCoordinate  \
--outFileNamePrefix /root/kadhija/bam/control_

STAR --genomeDir /root/resources/star_hg38_overhang100/ \
--readFilesCommand zcat \
--runThreadN 1 \
--readFilesIn /root/kadhija/BioinfRNAData/21_11_2017/Set_B4_R1.fastq.gz \
/root/kadhija/BioinfRNAData/21_11_2017/Set_B4_R2.fastq.gz  \
--outSAMtype BAM SortedByCoordinate  \
--outFileNamePrefix /root/kadhija/bam/epsilon_
