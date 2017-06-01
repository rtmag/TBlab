
~/myPrograms/Bismark/bismark --bowtie2 --multicore 64 \
/root/resources/HCT116_bs/ \
-1 HCT116.Decitabine.WGBS.run1.1.fastq.gz \
-2 HCT116.Decitabine.WGBS.run1.2.fastq.gz

~/myPrograms/Bismark/bismark --bowtie2 --multicore 64 \
/root/resources/HCT116_bs/ \
-1 HCT116.Decitabine.WGBS.run2.1.fastq.gz \
-2 HCT116.Decitabine.WGBS.run2.2.fastq.gz

~/myPrograms/Bismark/bismark --bowtie2 --multicore 64 \
/root/resources/HCT116_bs/ \
-1 HCT116.control.WGBS.run1.1.fastq.gz \
-2 HCT116.control.WGBS.run1.2.fastq.gz

~/myPrograms/Bismark/bismark --bowtie2 --multicore 64 \
/root/resources/HCT116_bs/ \
-1 HCT116.control.WGBS.run2.1.fastq.gz \
-2 HCT116.control.WGBS.run2.2.fastq.gz

##

~/myPrograms/Bismark/bismark_methylation_extractor --multicore 62 --gzip --buffer_size 20G --paired-end --ample_memory --cytosine_report --genome_folder /root/resources/HCT116_bs/ ./combine_hct116_WGBS_1_bismark_bt2_pe.bam

