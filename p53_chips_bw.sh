samtools index P53_24h_doxo_s1_rmdup.bam
samtools index P53_48h_doxo_s1_rmdup.bam
samtools index P53_Venkata_rmdup.bam
samtools index TP53_48_DMSO_rmdup.bam
samtools index TP53_48_DOXO_rmdup.bam

bamCoverage -p max -bs 1 --normalizeUsingRPKM -b P53_24h_doxo_s1_rmdup.bam -o P53_24h_doxo_s1.bw
bamCoverage -p max -bs 1 --normalizeUsingRPKM -b P53_48h_doxo_s1_rmdup.bam -o P53_48h_doxo_s1.bw
bamCoverage -p max -bs 1 --normalizeUsingRPKM -b P53_Venkata_rmdup.bam -o P53_Venkata.bw
bamCoverage -p max -bs 1 --normalizeUsingRPKM -b TP53_48_DMSO_rmdup.bam -o TP53_48_DMSO.bw
bamCoverage -p max -bs 1 --normalizeUsingRPKM -b TP53_48_DOXO_rmdup.bam -o TP53_48_DOXO.bw
#
