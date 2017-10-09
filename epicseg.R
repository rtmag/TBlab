Rscript ~/myPrograms/epicseg.R getcounts \
                    -m H3K27ac:/root/HCT116_histone_modification_Quy/STAR_alignment/bam/H3K27ac_rmdup_sort.bam \
                    -m H3K27me3:/root/HCT116_histone_modification_Quy/STAR_alignment/bam/H3K27me3_rmdup_sort.bam \
                    -m H3K36me3:/root/HCT116_histone_modification_Quy/STAR_alignment/bam/H3K36me3_rmdup_sort.bam \
                    -m H3K4me1:/root/HCT116_histone_modification_Quy/STAR_alignment/bam/H3K4me1_rmdup_sort.bam \
                    -m H3K4me3:/root/HCT116_histone_modification_Quy/STAR_alignment/bam/H3K4me3_rmdup_sort.bam \
                    -m H3K9me3:/root/HCT116_histone_modification_Quy/STAR_alignment/bam/H3K9me3_rmdup_sort.bam \
                    -r hg38.bed --binsize 220 \
                    -t hct116_counts.txt
                    
