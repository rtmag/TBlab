library(edgeR)
library(Rsubread)
options(scipen=999)

data<-featureCounts(c(
"HL-60_ActD/Aligned.sortedByCoord.out.bam",
"HL-60_DMSO/Aligned.sortedByCoord.out.bam",
"HL-60_DRB/Aligned.sortedByCoord.out.bam"
),
annot.ext="/home/rtm/references/gencode.v28.annotation.gtf",
isGTFAnnotationFile=TRUE,
minMQS=4,
strandSpecific=0,
isPairedEnd=TRUE,
autosort=TRUE,
nthreads=20,
GTF.attrType="gene_name"
)

x <- DGEList(counts=data$counts, genes=data$annotation[,c("GeneID","Length")])
x_rpkm <- rpkm(x,x$genes$Length)

colnames(x_rpkm)=c("ActD","DMSO","DRB")

write.csv(x_rpkm, "rpkm_wt_hl-60_all.csv")
############################################################################################
rpkm = x_rpkm

log_rpkm =log2(rpkm+1)

