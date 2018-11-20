# HL-60 RNA-seq
~/myPrograms/sra-tools/sratoolkit.2.9.0-centos_linux64/bin/fastq-dump --split-files -Z SRR1983910 > SRR1983910.fastq &

#  THP1_mRNAseq
~/myPrograms/sra-tools/sratoolkit.2.9.0-centos_linux64/bin/fastq-dump --split-files -Z SRR494112 > SRR494112.fastq &
~/myPrograms/sra-tools/sratoolkit.2.9.0-centos_linux64/bin/fastq-dump --split-files -Z SRR494111 > SRR494111.fastq &
~/myPrograms/sra-tools/sratoolkit.2.9.0-centos_linux64/bin/fastq-dump --split-files -Z SRR494110 > SRR494110.fastq &


STAR --genomeDir /root/resources/star_hg38_gencode27_overhang50/ \
--runThreadN 55 \
--readFilesIn SRR1983910.fastq \
--outSAMtype BAM SortedByCoordinate  \
--outFileNamePrefix hl60_

STAR --genomeDir /root/resources/star_hg38_gencode27_overhang50/ \
--runThreadN 55 \
--readFilesIn SRR494110.fastq \
--outSAMtype BAM SortedByCoordinate  \
--outFileNamePrefix THP1_1_

STAR --genomeDir /root/resources/star_hg38_gencode27_overhang50/ \
--runThreadN 55 \
--readFilesIn SRR494111.fastq \
--outSAMtype BAM SortedByCoordinate  \
--outFileNamePrefix THP1_2_

STAR --genomeDir /root/resources/star_hg38_gencode27_overhang50/ \
--runThreadN 55 \
--readFilesIn SRR494112.fastq \
--outSAMtype BAM SortedByCoordinate  \
--outFileNamePrefix THP1_3_

