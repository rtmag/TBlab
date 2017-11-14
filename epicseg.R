Rscript ~/myPrograms/epicseg.R getcounts \
                    -m H3K27ac:/root/HCT116_histone_modification_Quy/STAR_alignment/bam/H3K27ac_rmdup_sort.bam \
                    -m H3K27me3:/root/HCT116_histone_modification_Quy/STAR_alignment/bam/H3K27me3_rmdup_sort.bam \
                    -m H3K36me3:/root/HCT116_histone_modification_Quy/STAR_alignment/bam/H3K36me3_rmdup_sort.bam \
                    -m H3K4me1:/root/HCT116_histone_modification_Quy/STAR_alignment/bam/H3K4me1_rmdup_sort.bam \
                    -m H3K4me3:/root/HCT116_histone_modification_Quy/STAR_alignment/bam/H3K4me3_rmdup_sort.bam \
                    -m H3K9me3:/root/HCT116_histone_modification_Quy/STAR_alignment/bam/H3K9me3_rmdup_sort.bam \
                    -r hg38_normal.bed --binsize 220 \
                    -t hct116_counts.txt
                    
#
Rscript ~/myPrograms/epicseg.R segment --counts hct116_counts.txt \
                  --regions hct116_counts_refined_regions.bed \
                  --annot genes:hg38_genes.bed \
                  --nstates 5 --outdir ./segmentation/ --prefix hct116_n5_ &
                  
Rscript ~/myPrograms/epicseg.R segment --counts hct116_counts.txt \
                  --regions hct116_counts_refined_regions.bed \
                  --annot genes:hg38_genes.bed \
                  --nstates 6 --outdir ./segmentation/ --prefix hct116_n6_ &
                  
Rscript ~/myPrograms/epicseg.R segment --counts hct116_counts.txt \
                  --regions hct116_counts_refined_regions.bed \
                  --annot genes:hg38_genes.bed \
                  --nstates 7 --outdir ./segmentation/ --prefix hct116_n7_ &
                  
Rscript ~/myPrograms/epicseg.R segment --counts hct116_counts.txt \
                  --regions hct116_counts_refined_regions.bed \
                  --annot genes:hg38_genes.bed \
                  --nstates 8 --outdir ./segmentation/ --prefix hct116_n8_ &
                  
Rscript ~/myPrograms/epicseg.R segment --counts hct116_counts.txt \
                  --regions hct116_counts_refined_regions.bed \
                  --annot genes:hg38_genes.bed \
                  --nstates 9 --outdir ./segmentation/ --prefix hct116_n9_ &
#
